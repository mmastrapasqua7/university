# NETWORK SCANNING
Analisi di S.O., software e configurazioni presenti su una macchina per determinare i tipi di attacco fattibili. Questa analisi può essere eseguita da un singolo host oppure distribuita su più host (botnet). Nel caso di distribuito diminuisce l'impronta digitale del crimine, rendendolo pressochè anonimo.
## OBIETTIVI
- riconoscere servizi TCP e UDP disponibili sulle porte
	- cosa e su quale porta
	- quali utenti hanno accesso
	- anonymous logins
	- servizi di autenticazione
- riconoscere sistemi di filtraggio
- riconoscere OS

---
# SCANNING
## MODALITà
- **ATTIVO**
rapporto completo delle porte aperte della macchina, ma non rileva porte filtrate protette da port knocking (tentativi di connessione a una sequenza prestabilita di porte chiuse, che in caso di combinazione corretta, aggiornano il firewall). è molto intrusivo, può essere rilevato da IDS e non identifica host non attivi.
- **PASSIVO**
rapporto parziale, non intrusivo, non rilevato da IDS, ma rileva soltanto gli host attivi.

## TIPI DI SCAN
- **VERTICAL**
più porte di un singolo host
- **HORIZONTAL**
singola porta fra più host
- **STROBE**
più porte fra più host
- **BLOCK**
tutte le porte fra più host

## RISULTATI
- **OPEN**
porta aperta, servizio in ascolto
- **CLOSED**
host non risponde, richieste rifiutate
- **DROPPED / FILTERED**
firewall o altri sistemi di sicurezza bloccano l'accesso alla porta, non si sa lo stato (null)

## TCP specs
- **OPEN PORT**
	- **SYN** ---> **SYN/ACK**
	- **ACK** ---> **RST**
		- other ---> ...nothing...
- **CLOSED PORT**
	- **RST**:0 ---> **RST**
	- **RST**:1 ---> ...nothing...
- **DROPPED/FILTERED**
	- anything ---> **ICMP host unreachable**
	- anything ---> ...nothing...

## METODI
- #### ARP
	- **broadcast**
	mando ARP broadcast sulla LAN (solo in locale). è spesso disabilitato per questioni ovvie.

- #### IP
	- **ping**
	mando un pacchetto con il field PROTOCOL su un protocollo non abilitato dall'host. Attendo per un **ICMP host unreachable**. Se lo ottengo, la porta è **chiusa**.

- #### ICMP
	- **random messages**
	mando pacchetti diversi dal classico ping, come timestamp, address mask, error ecc...

- #### TCP
	- **SYN ping**
	mando un inizio di connessione, si ascolta per una risposta **SYN/ACK** o **RST**. Rilevabile da un firewall (loggato, può tener traccia).
		- **half open**
		se ricevo **SYN/ACK** mando **RST** per far fallire l'handshake (NB: se ricevo RST la porta è chiusa)
		- **full open**:
		se ricevo **SYN/ACK** completo la connessione con **ACK** e subito dopo **RST**. Lascia tracce, viene loggata.
	- **SYN/ACK ping** (stealth)(inverse mapping)
	mando pacchetti diversi da **SYN** tipo **SYN/ACK**. Se ricevo **RST** la porta è chiusa. Dato un elenco di porte da scansionare, elimino tutte quelle che hanno risposto **RST**, ottenendo per esclusione le porte aperte. Inoltre, se **SYN/ACK** raggiunge la destinazione (almeno una porta chiusa), il firewall è stateless (superato)(non tiene traccia, non sa distinguere fasi connessione). Evita la maggior parte degli IDS.
	- **ACK ping** (stealth)(inverse mapping)
	mando pacchetti **ACK**. Se ricevo **RST** la porta è chiusa. Inferisco ottenendo l'elenco delle porte aperte. Anche qui, se almeno un **ACK** arriva a destinazione, il firewall è stateless (superato).
	- **ACK window size**
	mando un **ACK** e attendo risposta **RST**, e analizzo il field windows size. Se la porta è aperta, molti sistemi operativi restituiscono un valore Ws > 0, mentre se è chiusa Ws = 0.
	- **FIN** (inverse mapping)
	mando un pacchetto con flag **FIN**:1. Se ottengo **RST** la porta è chiusa.
	- **flag Xmas** (**FIN**:1 && **URG**:1 && **PUSH**:1):
	mando con questi flag. Se ottengo **RST** la porta è chiusa.
	- **fragmentation**
	mando un pacchetto con una combinazione dei flag Xmas e osservo i risultati. Il server può anche crashare.
	- **idle**
	uso uno zombie e sfrutto un dettaglio implementativo dell'IP header, il field ID, incrementato per ogni gruppo di frammenti, ma che rimane lo stesso all'interno del gruppo. Procedo:
		1. mando un **ACK** allo zombie, e ottengo un **RST** in risposta. Analizzo l'IP_ID nell'header del pacchetto di ritorno;
		2. mando un **SYN** con IP spoofato dello zombie al target. Se la porta è aperta, risponde **SYN/ACK** allo zombie, che incrementerà l'IP_ID dei suoi header.
		3. mando un altro **ACK** allo zombie, e ottengo **RST**. Analizzo di nuovo l'IP_ID. Se è stato cincrementato di +2, allora ha risposto a una connessione (quella col target), quindi la porta è aperta. Altrimenti, se +1, non ha ricevuto nessun pacchetto.
	- **null flags** (inverse mapping)
	mando pacchetto con tutti i flag:0. Se risponde **RST** la porta è chiusa.
	- **FTP bounce**
	mi connetto a un server FTP in "active mode", ovvero non solo download ma anche comandi. Invio al server il comando di iniziare una connessione col target. Se avviene l'handshake, il server FTP risponderà con connessione avviata, quindi porta aperta, altrimenti messaggio di errore se la porta è chiusa.
	- **tcp traceroute (TTL)** (anaylize network)
	mando un pacchetto con TTL:0 e procedo inviandone altri incrementando di +1 ogni TTL di ogni pacchetto. In questo modo costruisco una mappa del viaggio che faranno i pacchetti.

- #### UDP
	- **ping**
	mando un pacchetto UDP vuoto a una porta. Attendo una risposta **ICMP host unreachable** o altri errori di ICMP. Se la ricevo, la porta è aperta, mentre se non la ricevo vuol dire che può essere dropped/filtered. Solitamente non si ha mai risposta, bisogna provare applicazioni specifiche come DNS (53).

---
# FINGERPRINTING
si cerca di risalire al sistema operativo della macchina sfruttando la conoscenza di dettagli implementativi che variano da OS a OS. Esistono già database che hanno un rapporto completo su questi dettagli implementativi che distinguono il network stack di ogni sistema operativo. Questo principalmente perchè non ogni OS si adegua agli standard proposti dalle RFC.

## METODI
- **ICMP message quoting**
Mando pacchetto a una porta chiusa. Tutti gli host dovrebbero mandare indietro l'IP header iniziale con 8B in aggiunta. Solaris e Linux ne ritornano di più 8.
- **TCP FIN prob**
mando un pacchetto **FIN**:1. Gli O.S MS Windows, BSDI e CISCO IOS mandano **RST** in seguito a un FIN (non aderiscono alla RFC 793 che dice "non va inviata alcuna risposta in seguito a questo evento").
- **TCP FIN e SYN**
Se mando un **FIN** o un **SYN**, su Linux viene risposto **FIN** e **SYN/ACK** rispettivamente.
- **TCP bogus flag probe**
il settimo (7) bit dei flag TCP è inutilizzato, mentre su Linux il flag è settato in risposta.
- **TCP initial window size (Ws)**
Ws = 0x3F25 per AIX O.S;
Ws = 0x402E per OpenBSD o FreeBSD.
