# SERVICE ATTACKS
## DHCP
- **COSA FA**: Distribuisce configurazione di rete preimpostata per nuovi host che si connettono in rete, oltre a un IP address e gateway IP.
- **COME LO FA**:
	1. Un nuovo host connesso in rete fa **DHCP discover**
	2. Il server DHCP risponde proponendo un IP address con **DHCP offer**
	3. Se l'host accetta la configurazione, risponde **DHCP request**
	4. Se tutto va a buon fine, il server conferma la transazione con **DHCP ACK**
- **INTERESSANTE**:
Non solo assegna un IP address a un host, ma fornisce altre informazioni:
	- IP address del router piu' vicino (gateway)
	- IP address e nome del DNS server piu' vicino
	- subnet mask
Inoltre la richiesta avviene interamente su layer 2 (data link), quindi solamente su frame ethernet con MAC address, prima di essere configurati con un IP.
- **ATTACCO**
	- **[DoS] starvation**
	indondo di **DHCP request** il server modificando ogni pacchetto Ethernet con MAC address random diverso. Il DHCP server esaurisce il pool di indirizzi e in questo modo nuovi host non sono piu' in grado di connettersi (avere un IP address). Inoltre posso hostare un DHCP server personale e risolvere richieste al posto di quello originale.
	- **[MITM] rogue server**
	mi metto nel mezzo delle comunicazioni hostando un DHCP server. Nella rete infatti un host puo' ricevere tante **DHCP offer** da piu' host diversi, ma ne accettera' solamente una. In coppia con la starvation, posso mettermi nel mezzo della comunicazione.
	- **fake gateway**
	se riesco a ottenere il controllo dell'IP address del gateway che useranno gli host, posso attirare tutti i pacchetti come un magnete
	- **fake DNS**
	posso risolvere gli indirizzi in modo fittizio, ridirigendo il traffico verso siti web personali.
		- **DIFESA: DHCP snooping**
		costruisco un DB di DHCP trusted. Solo i trusted potranno mandare tutti i messaggi, mentre gli untrasted solo richieste.

## RIP
- **INTERESSANTE**
**count to infinity problem**
- **ATTACCO**
	- **[DoS] IP spoof + RIP reflection**
	uso l'IP spoofing per mandare una richiesta iniziale di RIP, che e' un rip broadcast, per conoscere i suoi vicini. A questo punto ogni 30 secondi (intervallo aggiornamento) i router inonderanno l'IP address spoofato di aggiornamenti.


## OSPF
- **COSA FA**
protocollo di routing intra-AS
- **COME LO FA**
appoggiandosi su IP, manda una richiesta broadcast che viene indondata a tutta la rete. Crea una topologia della rete completa. C'e' un aggiornamento ogni 30 minuti (LSU = Link State Update).
- **INTERESSANTE**
La modalita' di autenticazione in OSPF e' mandata in chiaro in IP. I router girano il software "gated" (daemon).
- **ATTACCO**
	- **[DoS] IP spoof + MAX age**
	Mando un pacchetto di aggiornamento (LSA = Link State Advertisement) spoofato con MAX age field settato al massimo (3600 = 1h). Il router originale genera un refresh message che pero' verra' ignorato per 1h. Posso continuare a farlo creando una situazione di DoS.
	- **IP spoof + SEQ++**
	Mando un pacchetto di aggiornamento (LSA) spoofato con SEQn piu' grande di quello attuale. Il router originale contestera' l'aggiornamento mandando il suo pacchetto, che pero' risolutera' datato, ovvero con SEQn minore.
	- **IP spoof + MAX_SEQ**
	Mando un pacchetto di aggiornamento (LSU) spoofato con MAX SEQ settato al massimo (0x7FFFFFFF). I router si aggiornano pensando che sia la rotta piu' aggiornata. Il router spoofato mandera' aggiornamenti che pero' verranno ignorati per via del SEQn datato.
	- **Bogus LSA**
	Mando un pacchetto malformato che fa crashare il servizio gated in ascolto sui router. Questo costringe la macchina a riavviare il processo, costringendo la rete a cambiare le rotte in sostituzione a quel link.

## BGP
- **COSA FA**
protocollo di routing infra-AS.
- **COME LO FA**
appoggiandosi su TCP, determina le coppie **source**-**dest** che si estendono lungo gli AS. Fornisce informazioni sulla raggiungibilita' di subnet vicine e propaga l'informazione ai router interni ad AS (iBGP = internal BGP) e infine determina le rotte migliori basandosi sulle politiche del traffico (eBGP = external BGP). E' molto vulnerabile. Blackhole di singoli indirizzi, Hijacing. Non e' interessante perche' la maggior parte degli attori, hacker compresi, voglioni internet funzionante. Difficile da aggiustare, ci sono circa 30k AS in competizione.
- **INTERESSANTE**
	- **BGP peers (TCP): Internal Session, External Session**
	Viene usata la notazione CIDR per aggregare prefissi. In questo modo una serie di subnet viene aggregata sotto un unico IP in notazione CIDR. Esempio, se ho 4 subnet dello stesso IP da /24, all'esterno annunciero' solamente l'IP/22 che le aggrega tutte e 4.
	- Il protocollo e' costruito per scegliere la destinazione, ovvero la subnet, che si avvicina di piu' all'IP header del pacchetto. Per cui, se annuncio due rotte sullo stesso IP, una con /24 e l'altra con /22, BGP scegliera' la rotta piu' specifica, la /24.
	- Ogni AS ha un numero identificativo assegnato dalla IANA (ASNs). I numeri vanno da 1-64511 per quelli pubblici.
	- Ogni volta che la **BGP roting table** e' aggiornata, viene incrementato di +1 il numero della versione.
	- BGP non ha nessun meccanismo di autenticazione o integrita'. Si possono modificare rotte annunciate modificando IP associati a una rotta, cambiando AS path o riannunciando AS path senza permesso.
	- **routing table construction and diffusion**
		1. viene registrata la sequenza di AS per ogni destinazione. I nodi indirizzabili da un AS sono quelli con un determinato prefisso. Un AS path e' la lista degli AS da attraversare per raggiungere un nodo con un dato.
		2. **AS 1** annuncia (UPDATE) ai vicini quali prefissi **x** sa indirizzare (**A x**).
		3. il vicino **B** annuncia (UPDATE) **B A x**
		4. chi riceve un path che contiene se stesso non lo inoltra
		5. i path contengono info sulle policy di traffico dell'AS
		6. ogni router decidera' per ogni prefisso qual e' la rotta migliore e se inoltrarla
	- **link flapping**
	link flapping: un link viene disattivato e poi riattivato (normalissimo nel mondo degli ISP per via di aggiornamenti continui). Per prevenire danni, si usa la route dampening: la riattivazione della rotta viene accettata con tempi incrementali (sempre piu' lunghi, come sbagliare codice iPhone)
- **ATTACCO**
	- **[DoS] blackhole**
	faccio si che un AS annunci rotte che non sa raggiungere. Dopo vari aggiornamenti, il traffico verra' ridiretto verso l'AS che non sapra' che farsene. Il traffico viene smarrito.
	- **[sniffing] AS spoof (redirection)**
	un AS annuncia un prefisso gia' annunciato da un AS. Dopo diversi aggiornamenti, tuttti gli AS che devono passare per l'attaccante o che sono piu' distanti di esso mandano il traffico dell'AS spoofato verso di esso. L'attaccante AS infine fara' forwarding verso l'AS reale per fare sniffing e rendere l'attacco invisibile.
	- **[DoS] prefix deaggregation**
	un AS annuncia un prefisso gia' annunciato da un AS, ma lo deaggrega: se un AS ha annunciato un singolo prefisso /23, l'attaccante AS annunciera' due prefissi /24 per lo stesso (piu' lunghi di un singolo bit). Dato il protocollo, Internet preferira' la rotta piu' specifica, e l'intero traffico globale verra' ridiretto verso di esso (YouTube Pakistan 2008)
	- **[sniffing] shortening path (interception)**
	Invece di originare prefissi uguali o deaggregati, non cambio prefissi, ma accorcio il costo di una rotta togliendo di mezzo l'AS che voglio attaccare. In questo modo, attraggo il traffico che normalmente passerebbe per l'AS attaccato verso di me.
	- **[DoS/sniffing] annunci contradditori**
	Annuncio a tutti i router interni dell'AS che la rotta per l'AS da attaccare non va annunciata al di fuori (Internet), ma dico di annunciarne un'altra paddata, ovvero con hop aggiunti inutilmente. Lo scopo e' congestionare quell'AS.
	- **[DoS] link flapping**
	Faccio link flapping di continuo da parte di un AS, in questo modo la sua rotta rimarra' invariata per un tot di tempo prima di correggerla, dovuto al **route dampening**, ovvero politica di tempo incrementale per la riabilitazione rotte.
- **DIFESA**
	- **IP TTL**
	- **TTL (RFC 3682)**
	- **MD5 auth (RFC 2385)**
	descrive un'estensione del TCP, nel field OPTION, includendo un hash MD5 di valori combinati tra l'header IP e il TCP. Protegge contro session hijacking, replay attacks, unauthorized sessions.
	- **IPsec**
	- **Route filtering**
	creo un ACL (Access Control List) di prefissi o di AS per controllare UPDATE inviati o ricevuti. I messaggi in uscita passano per filtri. Gli UPDATE in ingresso sono filtrati e controllati. Gli ISP pero' devono conoscere il possessore di ogni singolo blocco di indirizzi attraverso **IRRs (Internet Routing Registries)**
	- **RPKI (Resource Public Key Infrastructure)**
	Gli AS ottengono un certificato ROA (Route Origin Authorizations) (come per i certificati TLS di HTTPS) dalle autorita' regionali RIR (Regional Internet Registries) che sono gli stessi che assegnano blocchi IP agli AS, sono punti di trust. ROA: ASn (AS number), range validita' in date, prefissi IP. Dice se un AS e' autorizzato o meno ad annunciare un determinato prefisso.


## DNS
- **COSA FA**
e' un servizio gerarchico per la risoluzioni di stringhe (Domain Name) in indirizzi IP. Usati da siti web, mail ecc... In Internet ci sono 13 root DNS server, replicati in una rete di 247 server sparsi per il mondo.
- **TERMINOLOGIA**
	- **TOP LEVEL DOMAIN (TLD) servers**
	responsabili dei macro domini (.org, .com, .edu, .gov ecc) e dei domini nazionali (.it, .fr, .co.uk ecc)
	- **Authoritative name server**
	per sottodomini. Sono DNS server autorizzati per risolvere tutti i sottodomini di un'organizzazione. Possono essere hostati personalmente o delegati pagando servizi DNS dei provider. La maggior parte delle grandi organizzazioni, come aziende e universita', hostano il proprio DNS autoritativo (primary) e il suo backup (secondary).
	- **Local name resolvers**
	contattano authoritative server solo quando non conoscono un nome.
	- **ZONE**
	collezione di coppie (hostname, IP) gestite insieme. Esempio: di.unimi.it, homes.di.unimi.it, pippo.unimi.it fanno parte della "unimi.it zone"
	- **NAMESERVER**
	software che risponde a domande DNS. A volte il server conosce la risposta (e' Authoritative per la zona), altre volte ridirige la domanda (recursive nameserver).
	- **AUTHORITATIVE NAMESERVER**
	per ogni zona bisogna mantenere un file delle tuple delle associazioni
	- **RESOLVER**
	parte del client del sistema DNS client/server. Programma che gestisce il servizio DNS, mandando richieste per interrogare i DNS server. Ogni host ha una libreria per la risoluzione di nomi (gethostbyname in UNIX). Ogni resolver conosce almeno un DNS server locale.
	- **RESOURCE RECORD**
	e' un database contenente la tupla:
	(name, value, type, ttl)
	types:
		1. **A** (address), IP address
		2. **NS** (name server)
		3. **MX** (mail exchanger)
		4. **SOA** (start of authority)
		5. **CNAME** (alias name)
		6. **TXT** (generic text, usato per public keys)

- **COME LO FA**
il resolver manda una richiesta al DNS. Il server o da la risposta o la inoltra ad un altro server, il successivo al quale la richiesta deve essere spedita. Viene usato UDP per un singolo nome o TCP per un gruppo di nomi. Sapere l'indirizzo root server e' sufficiente. Due tipi di query:
	1. Recursive Query: ritorna una risposta (usata dai RESOLVER)
	2. Iterative Query: ritorna un riferimento al prossimo server (usata dai SERVER)
	- **DNS QUERY**
		1. il client richiede www.unixwiz.net (A record, ovvero IP address) al nameserver dell'ISP
		2. il nameserver dell'ISP non e' authoritative, guarda negli sgabuzzini (local zone database, cache system)
		3. procede iterativamente:
			- ogni nameserver ha una lista dei 13 root server {a-m}.root-servers.net
			- il nameserver ne sceglie uno a caso tra i 13
			- manda la richiesta www.unixwiz.net a (esempio) b.root-servers.net
		4. il root-server non conosce il dominio, ridirige al GTLD (Global Top Level Domain) responsabile dei domini .net
		5. il nameserver manda quindi una richiesta con www.unixwiz.net al nameserver .net che pero' non conosce l'indirizzo del sito web, e ridirige verso il server DNS di unixwiz.net
		6. il nameserver manda quindi www.unixwiz.net al nameserver unixwiz.net, che risponde con l'IP address del webserver del dominio.
	- **DNS INVERSE QUERY (in-addr.arpa)**
	e' usato per mappare un indirizzo IP in un hostname; in-addr.arpa e' un top-level domain. Viene mandata una richiesta rovesciando l'indirizzo IP. Esempio
	WHOIS	85.15.32.12?
	DNS QUERY: 12.32.15.85.in-addr.arpa
	In questo modo, verra' risolta iterativamente partendo dal server .arpa, fino a in-addr, per poi scendere man mano nella gerarchia degli IP: 85 -> 15 -> 32 -> 12.

- **INTERESSANTE**
non sempre viene riportato il flag AUTHORITATIVE, perche' la vera risposta AUTHORITATIVE l'ha ricevuta il nameserver dell'ISP a cui abbiamo fatto richiesta. Per rendere piu' performante il servizio DNS vengono usati due principi: Spatial Locality (i computer locali sono piu' interrogati di quelli remoti) e Temporal Locality (lo stesso set di domini viene ripetutamente interrogato). Se questi principi valgono, si sfrutta un meccanismo di CACHE.
- **ATTACCO**
	- **Cache poisoning**
	ogni query ha un **queryID** che viene generato a ogni richiesta iterativa. In attesa di risposta, provo a iniettare una risposta UDP cercando di guessare il queryID, perche' il server accettera' una risposta come valida solo se matcha con questo field.
		1. mando una richiesta **DNS Query** al nameserver della vittima.
		2. so la richiesta che mandera' la vittima, es. ns1.bankofsteve.com. Spedisco tanti pacchetti **DNS response** con incluso l'IP del web server falso
		3. root/GTLD servers rispondon con il referral per ns1.bankofsteve.com
		4. il nameserver vittima chiede a ns1.bankofsteve.com l'ip di www.bankofsteve.com e usa un queryID 1000+1.
		5. il vero nameserver ritorna la risposta corretta con queryID 1000+1. Ma se l'attaccante ha fatto match con il queryID prima, la risposta e' ignorata
		6. col falso IP address iniettato in cache, si ritorna la risposta avvelenata ogni volta che viene fatta richiesta in futuro. Questi step vanno compiuti velocemente per guessare il queryID prima che il vero nameserver risponda. Serve una buona finestra di attacco.
	- **Authoritative record (Dan Kaminsky)**
		1. tramite un client, mando **DNS query** con un nome a caso nel dominio del target, all'authoritative nameserver della zona, tipo www.bankofsteve.com, inviando una richiesta del tipo www.12345678.bankofsteve.com (o qualsiasi altra cosa non in cache).
		2. tramite un server dns messo in piedi, mentre il nameserver vittima inizia le query iterative, provo a guessare il **queryID** della richiesta, inserendo un mio indirizzo IP come glue record per la zona www.bankofsteve.com.
		3. se guesso il queryID, non solo sono l'authority per 12345678, ma con gli altri campi inseriti sotto (che evitano bailwick) divento l'authority per tutta la zona www.bankofsteve.com!
	- **DNS rebinding**
	Il browser ha una sua politica predefinita, detta **SOP (Same Origin Policy)**, che in breve dice che un applicazione scaricata (tipo javascript) puo' connettersi solamente al server dal quale e' stato scaricato.
		1. Creo il dominio attacker.org
		2. Lego il nome a 2 IP address (proprio e vittima). Nel DNS resolver dell'attaccante, inserisco un TTL breve in modo che venga flushato dopo pochi secondi dalla richiesta della vittima.
		3. Il client scarica (apre pagina da browser) l'applet da attacker.org e nel mentre, l'associazione attacker.org <-> IP salta dal DNS, e l'attaccante inserisce una nuova entry per associare attacker.org <-> IP del target.
		4. L'applet che ha scaricato il client ora potra' connettersi anche al sito target. Per esempio, posso fare richieste / lanciare attacchi nella rete locale se faccio rebinding su 192.168._._. Posso far si che lo script mandi comandi, richieste GET/POST a server o IoT locali o nel web.
	- **[DoS] tcp depletion attack**
	Inondo il nameserver di richieste DNS su TCP. Il nameserver, dato che e' TCP, allochera' tante risorse quanto le richieste, esaurendole e mettendo fuori servizio il DNS per ulteriori risposte
	- **[DoS (Degradation)] NXDOMAIN cache exhaustion**
	Inondo il nameserver di richieste DNS per nomi irrisolvibili, che non esistono. Per ognuna di queste, mettera' in cache (risorsa preziosa) le risposte di errore NXDOMAIN (Non-eXistent Domain), riempendola di roba inutile. Il servizio si degrada
	- **Pharming**
	Tramite del codice javascript da far eseguire sul browser della macchina, mando una richiesta al router di cambiare configurazione di default per il DNS, ovvero gli chiedo di cambiare indirizzo per la risoluzione, inviando un IP di un DNS personale malizioso.
