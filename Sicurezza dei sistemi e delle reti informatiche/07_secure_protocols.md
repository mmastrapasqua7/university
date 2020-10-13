# SECURED PROTOCOLS
## S-BGP
- **COSA FA**
estensione di BGP per proteggere da UPDATE errati o maliziosi, basato su PKI. Due componenti nuove: AA (Address Attestations), RA (Route Attestations) per verificare che l'AS di origine e' autorizzata ad annunciare un blocco IP e che possa propagare una rotta vicina in un UPDATE.
- **COME LO FA**
Per validare l'integrita' di un UPDATE prima di firmarlo e riannunciarlo, un AS deve:
	1. generare un RA per il prefisso **x** indicando B come il prossimo hop per quella rotta
	2. spedire l'UPDATE, includendo RA e B
	3. B deve validare la firma nel RA usando la chiave pubblica di A.
	4. B verifica AA per prefisso **x** controllando che A sia il vero possessore di quel prefisso.
	5. B verifica che B e' il prossimo hop in RA.
	6. B genera due nuovi RA per i suoi peers C e D, includendo ogni RA in un diverso UPDATE, inoltrando due UPDATE a C e D.
- **PROBLEMI**
	1. Ha bisogno di registri completi
	2. Serve un PKI per le chiavi pubblice di ogni AS.
	3. Operazioni crittografiche rallentano UPDATE (jitter)
	4. Diffusione (farlo eseguire da tutti i router)
	5. Tutti gli ISP si devono accordare per usare questa nuova soluzione (competizione lo impedisce)
	6. Nessun incentivo economico
	7. Nessun beneficio se usato singolarmente (come IPv6)

## SO-BGP (Secure Origin BGP)
- **COSA FA**
tradeoff tra sicurezza e overhead, migliore di S-BGP.
La PKI gestisce tre tipi di certificati:
	1. il primo lega una chiave pubblica a ogni SO-BGP router.
	2. il secondo fornisce dettagli sulla politica dell'AS.
	3. il terzo e' simil S-BGP, AA (Address Attestations)

## DNSSEC (DNS Security Extension, RFC 4033)
- **COSA FA**: garantisce l'integrita' e l'autenticita' dei dati
- **FONDAMENTI CRITTOGRAFICI**
	1. Public Key cryptography
	2. Public Key Infrastructure (PKI)
	2. HMAC (Integrity and Auth Checks)
	3. Chain of Trust
	Parto dalla radice e attraverso tutta la gerarchia di risoluzione. A ogni hop (livello) la firma a livello superiore e' verificata con la chiave pubblica
- **COME LO FA**
	1. Ogni ZONE owner ha una coppia di chiavi (pubblica e privata) col quale firma i dati della sua zona, producendo una firma digitale per ogni set di record (zone)
	2. L'owner mette la chiave pubblica nella sua zona
	3. La chiave pubblica e' utilizzata per verificare la firma, quindi l'autenticita' dei dati da parte dei resolvers
	4. I resolver autenticano le firme DNS dalla radice (root) alla foglia (leaf) che sarebbe la zona contenente il nome.
- **FIELD**
	- **DO (DNSSEC OK)**
	- **AD (Authenticated Data)**
	E' un field che viene settato in risposta dal resolver che indica che tutto il processo crittografico di verifica (firme digitali, chain of trust) e' andato a buon fine e che tutti i dati in risposta sono autentici.
	- **CD (Checking Disabled)**
	Indica che le richieste in attesa (pending, non-authenticated data) e' accettabile in risposta. Per esempio, puo' essere fatto se l'host vuole verificare da se tutta la chain of trust e tutte le validazioni crittografiche.
- **DNSKEYS**
	- **KSK (Key Signing Key)**
	Chiave per firmare altre chiavi (crittografia forte, chiave grande, tenuta offline e certificata da una radice parente, tipo trusted root)
	- **ZSK (Zone Signing Key)**
	Chiave per firmare tutti i dati della ZONE (crittografia debole, chiave piccola per computazioni veloci e quindi meno overhead. Puo' essere cambiata senza coordinazione con la parent zone)
	- **DS (Delegation Signer)**
	Appare nella parent zone e contiene l'hash della chiave pubblica del figlio, ovvero del prossimo

## IPSEC (IP Security Extension, RFC 2401)
- **COSA FA**: garantisce l'integrita', l'autenticita', la confidenzialita' e il non ripudio dei dati. Non e' un protocollo, ma una **collezione di protocolli**
- **PROTEZIONE**: ip spoofing, sniffing
- **PROTOCOLLI**
	- **IKE (Internet Key Exchange, RFC 2409)**
	UDP:500, per negoziare i parametri di sicurezza e stabilire chiavi
	- **ESP (Encapsulating Security Payload, RFC 2406)**
	IP:50, per cifrare, autenticare e rendere sicuri i dati
	- **AH (Authentication Header, RFC 2402)**
	IP:51, per autenticare e rendere sicuri i dati. Protegge contro IP spoofing, usa un SEQn di 32 bit (molto meglio di 16 bit: 65K vs 4M), HMAC
	- **IPPC (IP Payload Compression, RFC 3137)**
- **ABSTRACT**
	- i dati vengono firmati dal sender e la firma viene verificata dal ricevente
	- modifica ai dati rilevata dalla verifica della firma
- **MODALITA'**
	1. **Transport Mode**
	IPSec header inserito dopo un pacchetto IP. Ottimo per la comunicazione end-to-end e per le dimensioni pacchetto. CRYPTOGRAPHIC_ENDPOINT == COMMUNICATION_ENDPOINT, ovvero le entita' che generano/processano IPSec header coincidono con il sorgente e destinatario di un IP packet
	2. **Tunnel Mode**
	l'IP header viene cifrato e diventa parte dati di un nuovo header, l'IPSec header. Si usa spesso in IPSec site-to-site VPN. CRYPTOGRAPHIC_ENDPOINT != COMMUNICATION_ENDPOINT, ovvero almeno un crypto_end non e' un com_end. Usato da routers, firewalls, VPN users per formare una **VPN (Virtual Private Network)**
