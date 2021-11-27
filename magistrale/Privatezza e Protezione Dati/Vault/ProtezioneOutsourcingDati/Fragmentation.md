# Fragmentation

## [[ObfuscatedAssociation]]

## Keep a few

Dico che il server è parzialmente trusted ma tengo un po' di informazione lato client.

- Ho uno schema con attributi $R(A_1, ..., A_n)$
- Ho dei confidentiality constraints $\mathscr{C} = \{c_1, ..., c_m\}$

Devo fare una frammentazione a due, $\mathscr{F} = F_O, F_S$ dove $F_O$ è il frammento dell'owner e $F_S$ il frammento del server. La frammentazione è **corretta** se:
- $F_O \lor F_S$ è uguale a $R$ per completezza
- Per ogni confidentiality constraint $c$ non deve essere salvato sul server, quindi $\notin F_S$
- $F_O \land F_S = \emptyset$ quindi zero ridondanza

Possono avere tupleID per non perdere il join senza perdita di info

### Query evaluation strategies

Devo fare traduzione in 2 query per server e owner
- $C_0$ sono le condizioni su attributi salvati in $F_O$
- $C_S$ sono le condizioni su attributi salvati in $F_S$
- $C_{SO}$ sono le condizioni su attributi salvati da entrambi i lati

2 strategie
- **Server-Client**
	- S: valuto $C_S$ sul server e prelevo lato client
	- C: faccio il join di $C_S$ e $F_O$ sul client
	- C: valuto $C_O$ e $C_{SO}$
- **Client-Server**
	- C: valuto $C_O$ e mando il tupleID delle tuple risultanti al server 
	- S: join scarto le tuple in $F_S$, valuto $C_S$ e ritorno il risultato al client
	- C: join del risultato con $F_O$ e valuto $C_{SO}$

### Protezione

- **Il server conosce o inferisce la query**
	- **Client-Server non va bene**: leaks di informazione perchè il server può inferire che alcune tuple sono associate con valori che soddisfano $C_O$
- **Il server NON conosce e NON può inferire la query**
	- Non ci sono problemi per entrambi, posso adottare strategie di ottimizzazione

#### Inferenze

Se è presente **data dependencies**:
- gli attributi e associazioni sensibili possono essere esposte indirettamente
- i frammenti possono essere indirettamente linkabili

Esempio:
- Dalla cura risalgo alla malattia
- Dalla malattia potrei risalire al lavoro
- Dall'assicurazione e dal premio potrei risalire al lavoro

Per difendermi devo fare in modo che i frammenti **non contengano** attributi e associazioni sensibili **direttamente e indirettamente**

### Minimal fragmentation

GOAL: minimizzare il lavoro sull'owner

Una frammentazione $\mathscr{F}$ è minima se e solo se
- $\mathscr{F}$ è corretta
- Non esiste nessun'altra frammentazione corretta con workload minore

Posso usare diverse **metriche**:
- **Storage**
	- minor numero di attributi in $F_O$ (**Min-Attr**)
		- si basa sulla cardinalità di $F_O$
	- minor dimensione degli attributi in $F_O$ (**Min-Size**)
		- Sommatoria del peso degli attributi
- **Computation/Traffic**
	- numero di query che deve fare l'owner (**Min-Query**)
		- basato sulla frequenza di ogni query, conosciuta a priori, e di attributi che compaiono nelle WHERE clausole
	- numero di condizioni in cui l'owner è coinvolto (**Min-Cond**)
		- ho un profilo completo della query, con tutte le operazioni e attributi coinvolti, voglio minimizzare la frequenza delle condizioni di ogni query, conosciuta a priori, che devo fare

#### Hitting set

Goal: minimizzare il numero di volte che mi serve $F_O$ ma tenendo conto che su $F_O$ voglio almeno un attributo per ogni constraint, per sicurezza.

Esistono diversi **criteri** basati su:
- **target**: tutti gli elementi (attributi, query, condizioni) per cui il problema di minimizzazione è definito
- **weight function**: associo a ogni elemento in target un peso
- **weight di insiemi di attributi**: somma dei pesi dei target che intersecano con l'hitting set

GOAL: computare l'hitting set degli attributi con peso minimo

**Weighted Minimum Target Hitting Set Problem (WMTHSP)**, NP-Hard

##### Soluzione euristica

Input: Attributi, Constraints, Target e Weight Function
Output: Set di attributi che devono comporre $F_O$. $F_S$ sarà derivato togliendo $F_O$ da $R$

Creo una mega Priority Queue (PQ) con un elemento E per ogni attributo
- E.A è l'attributo
- E.C è un puntatore a constraint non soddisfatti che contengono E.A
- E.T è un puntatore a target che non interesecano $\mathscr{H}$ che contengono E.A
- E.n_c è il numero totale di constraint in E.C
- E.w è il peso totale dei target puntati da T

**GOAL: PRIORITÀ A E.w/E.n_c**, ovvero elementi col ratio minore hanno priorità maggiore

###### Algoritmo:

finchè ci sono elementi in PQ e a questi elementi sono legati dei constraint
- estraggo un elemento E da PQ col ratio minure E.w/E.n_c
- inserisco E.A in $\mathscr{H}$
- per ogni constraint c in E.C rimuovo i puntatori a c da ogni elemento E' in PQ, aggiorno E'.n_c
- per ogni target puntato da E.T, rimuovi i puntatori a t da ogni elemento E' in PQ e aggiorno E'.w
- aggiusto PQ in base ai nuovi valori per E.w/E.n_c

Poi, per ogni attributi in $\mathscr{H}$
- se $\mathscr{H}$ \ {A} è un hitting set per $\mathscr{C}$, rimuovo A da $\mathscr{H}$

Come output avrò $\mathscr{H}$ che corrisponde a $F_O$, ovvero quello che l'owner deve tenere, e il restante, quello che resta nella coda PW, che sarà $F_S$ che dovrà tenersi il server