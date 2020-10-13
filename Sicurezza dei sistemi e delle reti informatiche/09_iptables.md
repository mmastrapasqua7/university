## NETFILTER
e' il componente del kernel linux che intercetta e manipola i pacchetti. Implementa le funzionalita' di rete avanzate (NAT, stateful filtering etc...). E' estendibile e contiene diverse estensioni per applicazioni. Questo modulo viene gestito tramite i comandi **iptables** (**ip6tables** per IPv6). Supporta anche **deep packet inspection** per analisi su protocolli, anche livello applicativo (layer 7). Netfilter e' diviso in **tabelle**, ognuna contenente delle ACL dette **chain**, che contengono a loro volta delle **rules**.
(FILTRO, TARGET)

**TABELLE**
- **FILTER**
usata per filtrare i pacchetti
	- **CHAIN**
		- **INPUT** pacchetti destinati al sistema
		- **FORWARD** pacchetti in arrivo destinati ad altri sistemi (router)
		- **OUTPUT** pacchetti generati localmente
- **NAT**
usata per traduzione degli indirizzi. In caso di connessione session-oriented (TPC) la regola viene applicata al primo pacchetto. I restanti appartenenti alla sessione sono liberi.
	- **CHAIN**
		- **PREROUTING** pacchetti in ingresso, pre-routing, usato per fare DNAT
		- **POSTROUTING** pacchetti in uscita, post-routing, usato per fare SNAT
		- **OUTPUT** pacchetti generati localmente, usato per fare DNAT
- **MANGLE**
applica politiche avanzate sui pacchetti (QoS)
	- **CHAIN**
		- **PREROUTING** tutti i pacchetti in ingresso
		- **INPUT** pacchetti destinati al sistema
		- **FORWARD** tutti i pacchetti in ingresso, destinati ad altri sistemi
		- **OUTPUT** pacchetti generati localmente
		- **POSTROUTING** pacchetti in uscita, dopo il routing ma prima dell'inoltro
- **RAW**
filtraggio stateless (evita il tracciamento della connessione, meno risorse perche' stateless)
	- **CHAIN**
		- **PREROUTING**
		- **OUTPUT**


## IPTABLES
```
# iptables -t [table] [option] [chain] [filtro] -j [target]
```

**OPTIONS**
- **-A (append)** aggiunge in coda una regola
- **-D (delete)** cancella regola dalla tabella
- **-R (replace)** modifica regola esistente nella posizione specificata
- **-I (insert)** inserisce regola nella posizione specificata
- **-L (list)** visualizza regole
- **-F (flush)**  pulisce le catene, cancellando ogni regola
- **-N (new chain)** crea nuova catena
- **-X (delete chain)** cancella catena esistente
- **-P (policy)** definisce politica di default {deny, permit}
- **-E (rename)** rinomina catena

**MATCH**
- **-p (protocol)**
- **-s (ip source)**
- **-d (ip destination)**
- **-i (input interface)**
- **-o (output interface)**
- **-sport (source port)**
- **-dport (destination port)**
- **--tcp-flags {SYN, FIN, ACK SYN, RST}**
- **--icmp-type**
- **-m (extension)**
	- **-m multiport --port (set di porte)**
	- **-m owner --cmd-owner (pacchetti da connessioni create dal processo)**
	- **-m state --state {NEW, RELATED, ESTABLISHED}**
- **-j CHAIN(jump)** passaggio tra catene

**TARGET (-j)**
- **ACCEPT** il pacchetto puo' transitare
- **DROP, REJECT** il pacchetto e' scartato (quiet) o rifiutato (verbose)
- **QUEUE**
- **RETURN**
- **LOG** non interrompe l'attraversamento della catena, ma logga il pacchetto per debugging e analisi. Se non specificato, i log vengono salvati in /var/log/messages.
	- **--log-level #** livello di logging secondo le logiche di syslog
	- **--log-prefix string** stringa da mettere come prefisso a ogni log, utile per la lettura
	- **--log-tcp-sequence**
	- **--log-tcp-options**
	- **--log-ip-options** header ip
	- **--log-uid** uid del processo che ha generato il pacchetto
