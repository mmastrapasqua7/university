# Encryption

Il server può essere **honest-but-curious**. Non bisogna dargli accesso alle risorse. Si usa l'encryption applicato a livello di **tupla** per impacchettare i **dati sensibili**.

Problema: come faccio a fare le query in modo efficace ed efficiente e senza aprire porta a inferenze?

- **Keyword-based searches on encrypted data**: tecniche di crittografia specifiche
- **Homomorphic encryption**: supporta operazioni direttamente sul crittato
- **Encryption schemas**: critto in base alle query che devo farci su
- **Onion encryption**: diversi layer di encryption, ognuno per una specifica operazione
- **Indexes**: attacco **metadati** ai dati per poterli acquisire e per eseguire query

## Indexes

Sostituisco i valori degli attributi non sensibili (non cifrati) con degli indici

### Tipi

#### Direct (1:1)

PRO:
- = query
- semplice
CONTRO:
- plaintext uguali hanno indici uguali, plaintext, inference attacks

#### Bucket (n:1)

Come il direct, ma sta volta faccio collisione

PRO
- = query
- no plaintext uguali per la collisione
CONTRO
- tuple spurie
- inference attacks

##### Partition-based

Prendo il dominio di un attributo, lo partiziono, e assegno a ogni partizione un indice. Faccio quindi del mapping in base al valore.

PRO:
- =, <, >, <=, >= query
	- Attribute op Attribute
	- Attribute op Value

###### Mapping

La funzione di mapping deve avere delle proprietà. $Map_{cond}()$
Se il mapping è order preserving, la query è più facile da formulare, altrimenti devo controllare dov'è il valore nella partizione in casi di query > o <

###### Query execution

Ogni query $Q$ deve essere divisa in
- $Q_S$: query da eseguire sul server
- $Q_C$: query da eseguire dal client sul risultato di $Q_S$ per filtrare fuori le tuple spurie, ovvero quelle che non appartengono alla query (ricorda: n:1, non è un mapping 1:1)

Devo fare exploit della funzione $Map_{cond}()$. Obbiettivo: il server deve accollarsi il massimo del lavoro

##### Hash-based

one-way hash function ma con collisione frequente per aumentare i bucket. **Non supporta query range** perchè gli hash non sono continui, sono random. Il meccanismo di query è lo stesso del partition-based

#### Flattened (1:n)

PRO:
- meno esposizione alle inferenze
CONTRO:
- vulnerabile a osservazioni dinamiche

### Query

#### Interval-based

- tecniche di indicizzazione order-preserving espone a inferenze.
- tecniche di indicizzazione non order-preserving non espongono a inferenze ma non fanno query interval-based

#### B+tree

Idea: B+tree? Si ma del B+tree del server non ce ne facciamo nulla, degradazione performance.

Soluzioni:
- cifro ogni nodo del tutto lato server, mi tengo in chiaro lato client. Poco senso
- attraverso l'albero lato client

### Searchable encryption

#### Order Preserving Encryption Schema (OPES)

Prende in input una distribuzione di valori di indice e applica una trasformazione order-preserving

PRO:
- niente tuple spurie
- comparazioni direttamente sul cifrato
CONTRO:
- inference

#### Order Preserving Encryptionwith Splitting and Scaling (OPESS)

#### Fully Homomorphic Encryption Schema

- Troppo costoso e non pratico in applicazioni DBMS

### Inference Exposure

Conflitto nel design degli indici
- esecuzione di query efficaci
- problemi di linking ed inference attacks

Misuriamo il livello di esposizione tramite il **coefficiente di esposizione $\epsilon$**.

Dipende dal **metodo di indicizzazione adottato**
- **Direct encryption**
- **Hashing**

e dalla **conoscenza a priori dell'intruso**

- **Freq+DB^k**
	- conosco la distribuzione delle frequenze dei plaintext nel database originale
	- ho il database cifrato
	
	Posso:
	- **plaintext content**: determinare l'esistenza di certe tuple nel db originale
	- **indexing function**: determinare la corrispondenza tra plaintext e indice

- **DB+DB^k**
	- conosco il database in plaintext
	- conosco il database cifrato
	
	Posso:
	- **indexing function**: determinare la corrispondenza tra plaintext e indice

#### Direct Encryption - Freq+DB^k

corrispondenza tra indice e plaintext in base al numero di occorrenze

Protezione:
- voglio che i valori con lo stesso numero di occorrenze siano indistinguibili

L'esposizione dei valori in una classe di equivalenza $C$ è $\frac{1}{|C|}$

esempio:
- a, b, c, d, f, f: {a, b, c, d} sono nella stessa classe di equivalenza, hanno la stessa frequenza (1), mentre {f} è una classe di equivalenza a parte, compare 2 volte e non c'è nessun altro che compare 2 volte: f è esposto a livello 1, a,b,c,d sono esposti 1/4

#### Direct Encryption - DB+DB^k

Computo la 3-colored Row-Column-Value graph. **Il grafo del db cifrato e del db plaintext è uguale**

- 1 vertex di colore column per ogni attributo
- 1 vertex di colore row per ogni tupla
- 1 vertex per ogni **distinto** valore in una colonna
- 1 arco che connette ogni valore alla colonna e alla riga a cui appartiene

L'inferenza è calcolata sull'automorfismo

#### Hashing exposure - Freq+DB^k

Hash ha un collision factor, boh

#### Hashing exposure - DB+DB^k

l'RCV non è uguale da db cifrato a plaintext per via della collisione. Il numero di nodi è uguale, ma il problema è trovare il matching corretto.

### Bloom filter

**Set membership** alla base dell'indicizzazione
- $n$ elementi
- vettore di $l$ bit
- $h$ funzioni hash indipendenti e diverse che danno come risultato un indice da 1 a $l$

PRO:
- 10 bit per ogni elemento, errore dell'1%
- efficienza spazio
CONTRO:
- può avere falsi positivi
- non posso rimuovere elementi

#### Inserimento di x:

Set 1 nel vettore di $l$ agl indici $H_1(x), H_2(x), ..., H_h(x)$

#### Ricerca di x

Vedo se agli indici $H_1(x), H_2(x), ..., H_h(x)$ il bit è settato a 1

