# Privacy e integrità nelle query e nella computazione

Fino ad ora abbiamo affrontato il problema di **content confidentiality** rispetto al provider di terze parti. Ora ci occupiamo di accedere a questi dati

- **Access confidentiality**: il fatto che l'accesso mira a un certo dato deve essere confidenziale
	- **Private Information Retrieval (PIR)** (Troppo overhead, serve tirare giù l'intero database per farle in casa)
	- **Path ORAM**
		- CONTRO:
			- non supporta query range
			- non supporta accessi da client multipli
			- vulnerabile al fallimento lato client
	- **Ring ORAM**
		- CONTRO:
			- non supporta query range
			- non supporta accessi da client multipli
			- vulnerabile al fallimento lato client
	- **Shuffle Index**
- **Pattern confidentiality**: il fatto che 2 accessi mirano allo stesso dato deve essere confidenziale (non voglio far capire che 2 richieste di 2 utenti mirano allo stesso dato)

## Path Oram

### Server side

- Ho un albero binario strutturato su L livelli con N blocchi, l'altezza $L = log_2(N)$
- Ogni nodo nell'albero contiene Z **blocchi reali** paddati con **blocchi dummy**
- Ogni foglia $x$ definisce un path unico $P(x)$ da $x$ alla radice

### Client side

- Il client conserva un piccolo numero di blocchi in uno **stash**
- Il client conserva anche una mappa di posizione:
	- $x = position[a]$ vuol dire che un blocco identificato da $a$ è mappato alla foglia $x$-esima
		- Se il blocco $a$ esiste è da qualche parte nel path $P(x)$
	- La posizione del mapping cambia ogni volta che si accede a un blocco, perchè viene rimappato (1 accesso 1 remapping)

### Main Invariant

- Ogni blocco dunque, in ogni momento, è mappato in modo randomico a una foglia nell'albero.
- I blocchi unstashed sono posizionati in qualche bucket lungo il path della foglia mappata

### Operazioni

1. **Remap block**: dato $x$ posizione vecchia del blocco $a$, rimappa randomicamente la posizione di $a$ in una nuova posizione $x'$
2. **Read path**: leggi i nodi in $P(x)$ che contengono il blocco $a$. Se faccio un write, aggiorno i dati salvati per il blocco $a$
3. **Write path**: scrivo i nodi in $P(x)$ includendo blocchi aggiuntivi dallo stash che possono essere posizionati lungo il cammino.

- Esempio: ho a livello 4 le foglie di $a$ e $c$. Se voglio leggere $c$, allora:
	1. calcolo una nuova posizione per $c$ in modo da spostarlo una volta letto
	2. leggo l'intero cammino (ramo) che mi porta fino a $c$, quindi leggerò: (1) la radice, (2, 3) nodi, (4) foglia. Attenzione: Il server vede che leggo l'intero path, non sa cosa sto leggendo
	3. Una volta letto, guardo lo stash e vedo se ci sono blocchi che intersecano il path. Se si, li sposto in una nuova posizione

 Ogni volta che leggo un intero cammino, guardo lo stash e vedo se c'è qualcosa da mettere a posto e soprattutto se c'è spazio. Rimappo quello che ho nello stash lungo il cammino letto. In questo modo ogni volta che vado a leggere una cosa cambia cammino. Inoltre: **ogni volta che leggo, leggo l'intero cammino** e faccio finta di nulla se trovo il dato in cima, continuo fino alla foglia.
 
 ## Ring ORAM
 
 **Più efficiente** in termini di access e bandwidth. E' identico al Path ORAM ma:
 - ogni nodo ha S **blocchi dummy** addizionali
 - ogni nodo ha una piccola **mappa** degli offset dei suoi blocchi
 - ogni nodo a un **counter** associato

### Operazioni

1. **Remap** identico a Path ORAM
2. **Read path**: scarico solo 1 blocco per bucket
3. **Write path**: viene **fattorizzata**, tipo cache dirty che fa il writeback quando conviene

## Shuffle Index

- I dati vengono indicizzati tramite una chiave candidata $K$ e organizzati come un **B+tree** non concatenato (unchained)
- I dati vengono salvati nelle foglie in associazione al loro indice
- L'accesso ai dati (le ricerche) sono basate sul **valore dell'indice**

I puntatori tra nodi, a livello logico, corrispondono agli identificatori del nodo. Vengono identificati usando
- (id, n)
	- id: node identifier
	- n: node content

### Abstract level vs. Logical level

L'ordine tra identificatori non corrisponde necessariamente all'ordine in cui i nodi appaiono nella rappresentazione astratta. Ovvero: per noi il B+tree è ordinato a livello astratto, ma a livello logico sul disco non sono ordinati ma sparsi

### Logical level vs. Physical level

- Ogni nodo (id, n) a livello logico è cifrato sul server (**confidential content**)
- Un nodo (id, n) corrisponde a un blocco (id, b). Viene usato il salting, un valore $s$ per ogni ciratura

### Accesso ai dati

L'accesso ai dati è un processo iterativo tra il client e il server
- 1 iterazione per ogni livello di shuffle index, partendo dalla radice
- per ogni iterazione, il client
	- decifra il blocco
	- determina il prossimo blocco da leggere dal server nel livello successivo
- il processo termina finchè un blocco foglia è trovato

### Quello che il server sa

Il server riceve richieste per accedere a blocchi. Queste richieste vengono osservate e catalogate con $o_i$. Un'osservazione $o_i$ è una sequenza di blocchi $\{b_{i1}, ..., b_{ih}\}$

Il server può **inferire**
- il numero di blocchi $m$ e il loro identificatore
- l'altezza $h$ dello shuffle index
- il livello associato a ogni blocco

Data una sequenza $o_1, ..., o_z$ il server non deve esser capace di inferire:
- il contenuto dello shuffle index (content confidentiality)
- i dati al quale la richiesta punta, ovvero per ogni osservazione $o_i$ il server non deve sapere che punta a un nodo specifico (access confidentiality)
- non deve poter inferire che due osservazioni $o_i$, $o_j$ puntano allo stesso nodo (pattern confidentiality)

**l'encryption non basta, l'accesso e il pattern è rivelato**
- attacchi basati sulle frequenze permettono al server di ricostruire la corrispondenza plain-text e blocchi

Goal: distruggere l'associazione
- **cover searches**: confusione tra singoli accessi
- **cached searches**: confusione ad accessi sullo stesso valore/blocco
- **shuffling**: cambio dell'allocazione del nodo, confusione della corrispondenza

#### Cover searches

Introduce **confusione** sul target nascondendo il blocco richiesto in un gruppo di richieste di copertura. Il **num_cover** è il parametro di protezione

Ricerca di un blocco
- **block diversity**: da path diversi dal target
- **indistinguishable**: deve essere indistinguibile la richiesta vera da quella cover, e deve avere **frequenza credibile**


PRO:
- rompo associazione padre-figlio
- ogni foglia ha la stessa probabilità di accesso
CONTRO:
- relazione padre-figlio può essere attaccata con intersezione

#### Cached searches

il client mantiene una cache locale dei nodi nel path verso il target per contrastare gli attacchi a intersezione
- inizializzato con **num_cache** path disgiunti maneggiati con la policy LRU
- se un nodo è in cache, anche il parent è in cache (continuità)
- refresh a ogni accesso
- nodi cercati recentemente saranno trovati in cache
- se il target è in cache, vengono fatte solo cover searches
	- da osservazioni false al server
	- permette, grazie allo shuffling, di fare il refresh della cache

PRO:
- ottimo nel breve termine per quanto riguarda le intersezioni
CONTRO:
- non previene attacchi a intersesioni oltre la dimensione della cache
- una storia lunga delle osservazioni permette al server di ricostruire l'indice

#### Shuffling

- Lo Shuffling rompe la corrispondenza 1:1 tra blocco e nodo cambiando il contenuto tra i nodi e tra i blocchi. Richiede però **decifrazione & ricifrazione**
- il cipher text in un nodo cambia a ogni accesso, con diverso node-identifier e diverso salt
- il contenuto di tutti i blocchi letti nell'esecuzione di 1 accesso e i nodi in cache vengono scambiati
- i blocchi shuffle vengono riscritti sul server

**node shuffling a un livello richiede l'update dei parenti dei nodi**
- ovvero: se leggo un nodo shuffle al livello X, tutti quelli all'altezza X vengono scambiati tra di loro, e il parent, a livello X-1, più in alto, viene riscritto per essere aggiornato

##### Esecuzione dell'accesso e management dello shuffle index

Dato un valore $v$ target. Determinare (num_over+1)-valori di copertura e per ogni livello $l$ nello shuffle index:
- determinare gli identificatori dei blocchi lungo il path $v$ e lungo il cammino di ciascun cover value
- se il nodo nel path $v$ non è in cache livello $l$, vengono fatte $num_cover$ ricerche di copertura
- mando al server una richiesta per il blocchi con gli identificatori salvati prima e decifro il contenuto
- faccio lo shuffle dei nodi appena letti e nella cache a livello $l$
- aggiorno i puntatori dei parenti dei nodi shufflati
- aggirono la cache livello $l$ inserendo i nodi più recentemente letti nel path per $v$

PRO:
- **Degradazione da shuffling**: degrada le informazioni in possesso dal server riguardo la corrispondenza tra nodi e blocchi
- **Access confidentiality**: ogni volta che si fa un accesso, l'informazione riguardo lo specifico accesso viene diviso tra (num_cover+1) nodi e lo shuffling distrugge la corrispondenza nodo-blocco
- **Pattern confidentiality**: l'accesso separato in tanti step non si riconosce
	- **la cache**, insieme alle covers, protegge nel breve termine
	- **lo shuffling**, insieme alle covers, protegge nel lungo termine
- Più performante di Path ORAM
- Nessun altro approccio offre una tale protezione
CONTRO:
- tante letture e scritture per 1 solo blocco
