# FIREWALL
> Un firewall deve essere l'unico punto di contatto della rete interna con quella esterna

Solo il traffico autorizzato puo' attraversare il firewall, per cui esso stesso deve essere un sistema altamente sicuro. Per mettere un servizio dietro un firewall (sito web HTTP, FTP o altro) c'e' bisogno di una regola per permetterlo. Ma questo espone la rete privata al pubblico, annullando il potere del firewall. Per ovviare a questo, la rete viene suddivisa in 2 zone:

**SOTTORETI**
- **rete pubblica (DMZ, De-Militarized Zone)** tratto di rete visibile al mondo, in cui posso situare webserver, email, ftp ecc. In questo modo permetto l'accesso delle macchine a tutta la rete del mondo
- **rete privata** tratto di rete invisibile al mondo, nascosta.
per ogni sottorete si possono definire le **politiche di accesso**

**INTERFACCE DI RETE (Three-legged Architecture)**
- **internet**
- **rete privata**
- **rete pubblica (DMZ)**

**POLITICA**
- **default deny** tutti i servizi sono negati di default, eccetto quelli permessi specificati
- **default allow** tutti i servizi sono permessi, eccetto quelli negati specificati

**DIREZIONE**
- **ingress firewall**
	- collegamenti incoming, tipicamente servizi offerti all'esterno
- **egress firewall**
	- collegamenti outgoing, tipicamente attivita' personale

**IMPLEMENTAZIONE**
- **Static Packet Filtering (firewall stateless)**
- **Dynamic Packet Filtering (firewall statefull)**
- **Proxy Server**
	- **application gateway**
	- **circuit-level gateway**

## STATIC PACKET FILTERING (FIREWALL STATELESS)
Controllo del traffico basato sugli **header** dei pacchetti. I parametri degli header vengon confrontati con delle regole definite da una **ACL (Access Control List)**. Ogni pacchetto e' esaminato singolarmente e in modo indipendente.

**PRO**
- ottime prestazioni
- indipendente da applicazioni
- basso costo

**CONTRO**
- facile da fregare
- difficile supporto per porte allocate dinamicamente (tipo FTP)

## DYNAMIC PACKET FILTERING
ogni singola connessione viene registrata in una tabella (detta connection table o state table). Oltre ai parametri stateless, vengono registrati altri dati, come flag (syn, syn-ack), seqn, porte. Solamente il fatto di tener traccia delle connessioni aperte previene il **session hijacking**. Ogni pacchetto in ingresso viene verificato che appartenga a una connessione precedentemente aperta.

**PRO**
- previene session hijacking
- apre e chiude le porte su richiesta, in base a informazioni

**CONTRO**
- non veririca il contenuto dei pacchetti
- ancora problemi per porte allocate dinamicamente (tipo FTP)

## STATEFUL PACKET FILTERING (FIREWALL STATEFUL)
evoluzione del Dynamic ma "state-aware". Conserva le **informazioni di stato** a livello di trasporto e/o applicativo. Distingue le nuove connessioni da quelle gia' aperte, tiene traccia delle sessioni.

**PRO**
- state aware
- porte temporaneamente aperte
- basso overhead
- supporta tutti i servizi

**CONTRO**
- application-unaware
- permettono connessioni dirette dall'esterno verso gli host interni
- non garantiscono autenticazionie: stabilita la connessione tutto dipende dall'host vittima

## DEEP PACKET INSPECTION
firewall stateful + filtraggio applicativo, sa interpretare le applicazioni e analizzarne i pacchetti.

**PRO**
- application-aware
- puo' riconoscere malware (stringhe nei pacchetti)

**CONTRO**
- overhead (impatta sulle performance)

## PROXY
media le comunicazioni tra due host, disaccoppiandoli.

**TIPI**
- **Web Proxy**
- **Anonymizing Proxy**
- **Reverse Proxy** offusca cosa c'e dietro la rete, puo' essere usato da load balancer, acceleratore TLS, web accelerator, compressime, spoof-feeding
- **Proxy Firewall** opera a livello applicativo. Inizialmente soppiantati dagli stateful firewall, ora tornano di moda per contrastare vulnerabilita' applicative.

## APPLICATION-LEVEL GATEWAY
cascata di proxy che esaminano contenuto pacchetti a livello applicativo. Spesso richiede modifica lato client. Ha anche funzioni di autenticazione ed e' il **massimo della sicurezza** (protegge contro overflow, attacchi verso il target).

**PRO**
- server piu' protetti
- autenticazione
- analisi e log

**CONTRO**
- ritardo supporto nuove app
- consumo di risorse
- overhead
- espone SO del firewall

## CIRCUIT-LEVEL GATEWAY
Crea circuito a livello di trasporto tra client e server

**PRO**
- server piu' protetti
- isola da attacchi TCP handshake
- autenticazione

## BASTION HOST
e' un computer che viene messo tra la rete internet e una rete privata. E' un computer altamente sicuro, col minimo software, pulito di tutti i demoni e i moduli inutili per minimizzare la superficie di attacco. E' ridotto all'osso e supersicuro. E' il punto critico del sistema che media l'accesso alla rete privata. Spesso usato come proxy server.

## SOCKS
standard per **circuit-level gateway**. E' un protocollo a layer 5 (session). Anche conosciuto come **AFT (Authenticated Firewall Traversal)**. 

## STEALTH FIREWALL
firewall senza indirizzo di rete che lavora in modalita' promiscua, ovvero tutto il traffico che fisicamente raggiunge l'interfaccia di rete viene passato alla CPU, senza nessun drop per MAC diverso, filtri o altro.

## Network Address Translation (NAT)
non pensato originariamente per la sicurezza, ma ha un'ottima proprieta': mascherare gli indirizzi della rete interna, nascondendoli.

**CONTRO**
- overhead dovuto alla ricomputazione del checksum IP/TCP
- distrugge il concetto principale di connessione point-to-point

# Access Control List (ACL)
regole di filtraggio statico dei pacchetti in transito. I criteri di confronto sono **TOP-DOWN**, ovvero la prima regola che viene verificata produce la decisione sul pacchetto. Per ogni pacchetto in ingresso, viene cercato un match tra le regole in ordine **sequenziale** dall'alto verso il basso. Se nessuna viene matchata, viene applicata la regola default.

**STRATEGIE**
- **default permit**
- **default deny**

## CISCO ACL
- **STANDARD ACL** filtra **solo IP sorgente**

	- **Struttura**
	```
	access-list [number] [action] [ip_source] <wildcard> <any>
	...
	access-list [number] {permit, deny} any
	```
	NB: Se non viene specificato, cisco mette automaticamente tutto a "deny any"

	- **numero** 0-99
	- **azione** {permit, deny}
	- **source** IP source
	- **wildcard** negated netmask, 0 consider, 1 ignore
		- esempio: voglio controllare 192.168.1.0/24, non mi interessano gli host ma la rete, per cui: 0.0.0.255

	- **RETI PRIVATE: INDIRIZZI IP DA BLOCCARE DI DEFAULT (RFC 1918)**
	```
	# INGRESS ACL
	access-list 42 deny 10.0.0.0 0.255.255.255
	access-list 42 deny 127.0.0.0 0.255.255.255
	access-list 42 deny 172.16.0.0 0.15.255.255
	access-list 42 deny 192.168.0.0 0.0.255.255
	access-list 43 permit any
	```

- **EXTENDED ACL** numerate da 100-199, filtra **IP src, IP dst, protocol, port, ICMP code**

	- **Struttura**
	```
	access-list [number] [action] [type] [ip_source] <wildcard> <options> [ip_dest] <wildcard> <log>
	...
	access-list [number] {permit, deny} any
	```

	- **numero** 100-199
	- **azione** {permit, deny}
	- **source** IP source
	- **destination** IP destination
	- **type** IP, UDP, TCP
	- **option**
		- porte TCP/UDP
		- codice ICMP
		- **TCP STATE**
			- ESTABLISHED
	- **log** scrive un messaggio di log per ogni pacchetto verificato dalla regola
	- **logic operators**
		- eq (equal)
		- neq (not equal)
		- gt (greater than)
		- lt (less than)

**ACL INTERFACES**
```
ip access-group [ACL number] {in, out}
```

- **in** il router applica prima l'ACL e poi effettua il routing
- **out** il router effettua il routing e applica l'ACL (se non specificato, di default viene messo out)
