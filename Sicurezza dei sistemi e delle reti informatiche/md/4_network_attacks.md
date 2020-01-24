# NETWORK ATTACKS
## 2. data link layer
---
- #### Switch MAC address learning
	- **COSA FA**: impara automaticamente i MAC address degli host collegati alle interfacce di rete.
	- **COME LO FA**: appena avviato, lo switch si comporta come hub: fa  broadcast di tutti i pacchetti ricevuti su tutte le interfacce di rete, tranne quella di ricezione. Si mette poi in ascolto delle risposte per associare **source** e **dest** dei pacchetti, popolando la **MAC address table** (lookup table) con tuple contenenti (numero_interfaccia, MAC_address). Ovviamente questa tabella ha dimensione finita.
	- **INTERESSANTE**: Quando vengono esaurite le risorse, lo switch entra in modalità di riconfigurazione, dove si comporta di nuovo come hub (riavvio).
	- **ATTACCO**:
		- **[SNIFFING] MAC address flooding**
		invio tanti pacchetti fasulli, ognuno con un MAC address diverso (random), per far esaurire le risorse dello switch.

- #### ARP (Address Resolution Protocol)
	- **COSA FA**: risolve un IP address nel suo rispettivo MAC address
	- **COME LO FA**: manda pacchetti broadcast alla LAN con un IP address noto. Attende una reply contenente il MAC address rispettivo a quell'IP.
	- **INTERESSANTE**: si basa sulla fiducia. Ogni host ha una ARP cache table per le associazioni note (su linux: $ arp ) che viene aggiornata a ogni reply, anche senza aver mandato request. Non ha un meccanismo di autenticazione. Richieste non tracciate.
	- **ATTACCO**:
	  - **[MITM] ARP cache poisoning**
		invio ARP reply con IP spoofato (della vittima), che creerà una falsa entry nella ARP cache table, e tutto il traffico di quell'host viene ridiretto verso di me.

## 3. network layer
---
- #### IP (Internet Protocol)
	- **INTERESSANTE**: I router non tengono traccia dei pacchetti, non guardano il campo **source** ma solo il **dest** per un fast forwarding. Non c'è modo di verificare l'autore di un pacchetto. Inoltre, IP ha un massimo payload di 64kB. Se mando un pacchetto con l'offset settato al massimo, il contenuto del pacchetto non può superare i 7B per rientrare nella lunghezza massima.
	- **ATTACCO**:
		- **[Various...] IP spoofing**
		mando pacchetti con IP address source fasullo. Potenzialità infinite.
		- **[DoS] ping of death**
		Sfrutto la frammentazione dei pacchetti IP (size + offset) mandando un pacchetto con massimo offset e payload > 7B. In questo modo, se il network_stack fa schifo, causo un buffer overflow, con le relative conseguenze.

- #### ICMP (Internet Control Message Protocol)
	- **COSA FA**: protocollo usato per testare la rete in termini di operazioni, banda, trasmissione, errori e altro.
	- **ATTACCO**
		- **[DDoS] ICMP broadcast (smurf) + IP spoof**
		Faccio un ping con IP address broadcast della LAN e IP **source** l'IP della vittima. Tutta la rete risponderà all'host vittima dell'attacco.

## 4. transport layer
---
- #### TCP (Transmission Control Protocol)
	- **COSA FA**: stabilisce una connessione affidabile full duplex tra due endpoint.
	- **COME LO FA**: esegue step incrementali: [1] viene effettuato un three-way handshake (SYN, SYN-ACK, ACK) in cui vengono scambiati parametri di connessione come **ISn (Initial SEQ number)**, **ACKn**, **PORTn** e altri parametri; [2] lo scambio dati all'interno della sessione è tracciato da due parametri principali, SEQ e ACK, che vengono incrementati rispettivamente all'invio e alla ricezione corretta dei dati. Ogni pacchetto quindi deve trovarsi nel posto giusto per essere accettato.
	- **INTERESSANTE**: Se riesco a guessare ISn o SEQn, riesco a inviare pacchetti all'interno di una sessione senza esserne partecipe. Se un computer riceve un ACK con numero più grande del suo numero di SEQ, il computer rinvia un ACK con le informazioni attuali.
	- **ATTACCO**:
		- **[DoS] IP spoof + ISn/SEQn prediction + RST flag**
		Se riesco a guessare uno dei parametri, invio un pacchetto TCP con flag RST, che resetterà la connessione.
		- **[DoS] IP spoof + ISn/SEQn prediction + ACK desynchronization (storm)**
		Se riesco a guessare uno dei parametri, invio a entrambi gli host un pacchetto TCP con qualche dato e SEQ number valido da entrambe le parti. I due host si scambiano gli ACK che però non corrispondono alla realtà, perchè sono stati iniettati pacchetti dall'esterno, e quindi provvederanno a mandarsi ACK con le informazioni aggiornate. Ma dato che sono desincronizzati, entreranno in loop inondandosi di ACK.
		- **[DoS] IP spoof + ISn/SEQn prediction + Local DoS o LAND**
		Se riesco a guessare uno dei due parametri, invio un pacchetto TCP contenente l'IP address della vittima sia nel campo **source** sia nel campo **dest**, con lo stesso PORTn. In questo modo, l'host entrerà in loop con se stesso inondandosi di traffico, esaurendo le risorse.
		- **[...] IP spoof + SEQn prediction + session hijacking**
		Ci sono due tipologie di attacchi possibili in questa categoria:
			- **blind IP spoof (remote)**
			Inizializzo una connesione con un hosto/server remoto con SYN. Il server invierà SYN-ACK alla vittima spoofata, che però risponderà con un RST. Metto fuori uso questa vittima e provo a fare il guessing del SEQn che il server ha generato. Se ci riesco, ottengo una connessione col server con gli stessi privilegi di accesso che ha la macchina vittima, solitamente nella stessa rete, sbarazzandomi di firewall e altri sistemi.
			- **NON-blind IP spoof (local)**
			Nella stessa rete, analizzo il traffico con una delle tecniche viste per sniffare il traffico e analizzare il pattern del SEQn, per poi iniziare l'attacco.
		- **[DoS]  IP spoof + SYN flooding**
		inondo il server di pacchetti SYN per inizializzare una connessione, ma con IP spoofati. Il server risponde con SYN-ACK. In questo modo il server è costretto a tenere traccia della connessione in attesa di risposta, occupando risorse inutili, finchè non esaurisce le risorse (full queue). Un TCB (Transmission Control Block) di TCP occupa circa 280B.
		- **[DDoS] IP spoof + ACK reflection (backscatter)**
		mando tante richieste SYN a server legittimi (normali siti web) con IP spoofato della vittima. I server risponderanno SYN-ACK verso questo IP. Quindi la vittima viene inondata di pacchetti da IP legittimi, senza saperne l'autore.

- #### UDP (User Datagram Protocol)
	- **COSA FA**: connessione best effort (come gli apparati Internet)
	- **INTERESSANTE**: Usato soprattutto per servizi real-time o streaming come video.
	- **ATTACCO**:
		- **[DoS] teardrop (overlapping packets)**
		Invio pacchetti UDP ma modificando i parametri reali di size e offsett. Il S.O. può non essere capace di riassemblarli correttamente perchè si sovrappongono, e può portare a un blocco della macchina.

## 7. application layer
---
- #### DNS (Domain Name System)
	- **ATTACCO**:
		- **[DDoS] IP spoof + DNS amplification**
		Mando tante query DNS con parametro ANY (tutte le entry di un DNS) e IP spoofato della vittima. La risposta generata può essere molto grande. Con una botnet, o tanti computer, posso creare una valanga di traffico.
		- **[DDoS] DNS water torture**
		Forzo il DNS a risolvere query ricorsive con nomi fasulli e annidati, in modo che ci sia l'effetto delega di sant'antonio, consumando risorse inutili.
- #### HTTP (HyperText Transfer Protocol)
	- **ATTACCO**:
		- **[DDoS] IP spoof + HTTP flooding**
		Se ho una botnet o tanti computer a disposizione, mando tante richieste HTTP request che sono molto leggere verso la vittima. Il payload di un webserver pu essere molto grande, per cui il server non regge il carico di richieste e inonda la rete, prima di esaurire tutte le risorse.
- #### NTP (Network Time Protocol)
	- **ATTACCO**:
		- **[DoS] IP spoof + NTP amplification**
		I server NTP malconfigurati hanno un comando di debug chiamato "monlist" che restituisce l'elenco degli ultimi 600 host aggiornati. Con una botnet o tanti computer, mando richieste "monlist" a NTP server con IP spoofato della vittima.
