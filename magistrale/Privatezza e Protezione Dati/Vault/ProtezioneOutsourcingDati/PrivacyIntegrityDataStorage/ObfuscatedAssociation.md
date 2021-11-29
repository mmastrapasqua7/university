# Publishing Obfuscated Assocations

**Le associazioni sensibili** devono essere protette ma cercando un modo di far eseguire comunque query. Esempio: vorrei proteggere il consumatore dall'assocazione di cosa a comprato, ma vorrei sapere la media di acquisti, che fo?

## Anonymizing Bipartite Graph

Tipologie di query che voglio fare
- **Type 0**: tipologia grafo (numero medio di prodotti comprati dai clienti)
- **Type 1**: condizioni su un solo lato (numero medio di prodotti acquistati da un gruppo Y)
- **Type 2**: condizioni da entrambi i lati (numero medio di prodotti X acquistati da un gruppo Y)

Devo preservare la privacy dell'associazione 1:1 specifica tra prodotto e cliente

Potrei lasciare il grafo cosi com'è ma togliendo i label ai nodi:
- creo gruppetti di bidimensione $(k, l)$ dove si intende che i clienti devono essere $\ge k$ e i prodotti $\ge l$. Gruppi non intersecati

Diamo degli alias ai prodotti e ai clienti, e l'associazione la pubblichiamo sotto forma di alias.

Perchè mettere i grouppi se già tutti hanno un alias? È per avere una sorta di k-anonymity per raggruppare dei clienti. Invece di non sapere nulla, introduco un'incertezza grande quanto il gruppo. Questo mi permette di fare certe query. **Il raggruppamento mi da utilità** oltre il type 0 di query. I gruppi mi supportano query con condizioni a destra, sinistra e entrambi i lati (type 1, type 2)

**Più piccolo è il gruppo, più è utile per le query, più espongo le associazioni**
- Se faccio le cose bene, ho una protezione delle associazioni pari al prodotto di $k \times l$

- **safe (k, l) groupings**: nodi in un gruppo V non devono essere connessi a uno stesso nodo W

Attenzione: quando si fanno i gruppetti, la cosa critica non solo è scartare tuple per fare safe grouping, ma la difficoltà maggiore è l'utilità che devo valutare se l'ho fatta bene per rispondere alle query dei tipi 0, 1, 2. Se faccio male i gruppi non riesco più a rispondere.

### Fragments and Loose associations

I frammenti possono essere usati per proteggere le associazioni sensibili. Per rendere più **utili** queste release posso fare associazione in forma **sanitizzata**
- **Loose associations**: associazione tra gruppi di valori invece che di valori specifici

Abbiamo già discusso attributi sensibili e associazioni sensibili. Ora abbiamo una nuova richiesta: **visibility requirements**

#### Visibility requirements

Formule booleane monotoniche sugli attributi che rappresentano viste sui dati. Permettono di estrimere diversi requisiti
- **visibile attributes**
- **visible associations**
- **alternative views**

Può essere applicata per soddisfare entrambi i constraints di confidenzialità e visibilità. Quello che faccio è pubblicare a parti esterne solamente frammenti che
- **non includono** attributi sensibili e associazioni sensibili
- **includono** gli attributi richiesto o le associazioni (devo soffisfare **tutti i requisiti**, anche utilizzando più di un frammento)

#### Correct and minimal fragmentation

Una frammentazione è **corretta** se e:
- ogni confidential constraint è soddisfatti da tutti i frammenti
- ogni visibility requirement è soddisfatto **da almeno 1 frammento**
- i frammenti non hanno attributi in comune

Una frammentazione è **minima** se
- il numero di frammenti è minimo

Problema NP-Hard (ma va). Uso un SAT solver, che è proprio identico, ovvero faccio traduzione dei constraint in formule booleane. Faccio iterazioni e a ogni iterazione aggiungo un frammento

#### Publishing

Dati 2 frammenti $F_l$ e $F_r$, un'associazione loose tra questi due
- partiziona le tuple in gruppi all'interno dei frammenti
- do informazioni dell'associazione a livello di gruppi
- non permetto di ricostruire il db originale
- do più utilità

### Grouping

#### Grouping o k-grouping

Dato un frammento $F_i$, un **k-grouping** partiziona le tuple in gruppi $\ge k$. Dopodichè a ogni tupla in un gruppo è assegnato un group identifier groupID

- un k-grouping è **minimale** se massimizza il numero di gruppi, quindi minimizza la dimensione di essi
- ($k_l$, $k_r$) denota un raggruppamento tra due istanze $f_l$ e $f_r$ di $F_l$ o $F_r$
- un ($k_l$, $k_r$) è **minimale** se entrambi i $k_l$ e $k_r$ raggruppamenti sono minimali

#### Group association

Un'associazione ($k_l$, $k_r$)-grouping induce una **group association** A tra i gruppi in $f_l$ e $f_r$
- Una group association A è un insieme di coppie di groupID tale per cui A ha la stessa cardinalità della relazione originale
- C'è una funzione biettiva che mappa la relazione oroginale e A che associa ogni tupla nella relazione originale con una coppia ($groupID_l(l)$, $groupID_r(r)$)

#### Group association protection

Attenzione: **devo controllare le occorrenze di stessi valori** quando faccio grouping

##### Alikeness

Due tuple si dicono **alike** rispetto a un constraint $c$ se
- $c$ è coperto dai due frammenti in $F_l$ e $F_r$

Detto in parole povere: se c'è un attributo nei constraint il cui valore è uguale e i cui attributi del constraint sono presenti si a destra sia a sinistra

#### k-loose association

Una group association è **k-loose** se ogni tupla nel gruppo di associazione A corrisponde indistinguibilmente ad almeno k-distinct assocazioni tra le tuple nei frammenti

Un raggruppamento ($k_l$, $k_r$) induce a un **minimal** group association se
- A è **k-loose**
- Non esiste nessun'altro raggruppamento che induce al k-loose tale per cui la cardinalità è minore

#### Proprietà eterogenee

C'è una corrispondenza tra $k_l$, $k_r$ raggruppamento e il grado di k-looseness indotto dalla group association
- ($k_l$, $k_r$)-grouping non può indurre a una k-loose associazione per $k \gt k_l \times k_r$
- il valore $k \le k_l \times k_r$ dipende da come sono identificati i gruppi

se un ($k_l$, $k_r$)-grouping soddisfa le proprietà di eterogeneità, allora la group association indotta è k-loose con $k = k_l \times k_r$
- **group heterogeneity**
- **association heterogeneity**
- **deep heterogeneity**

##### Group heterogeneity

**Nessun gruppo** può vere tuple alike rispetto a un constraint coperto da entrambi i lati
- **diversità intragruppo**

##### Association heterogeneity

**Nessun gruppo** può essere associato 2 volte allo stesso gruppo, o meglio la group association non può contenere doppioni
- ci devono essere almeno $k_l \times k_r$ tuple per ogni tupla, una sorta di k-anonimity con $k = k_l \times k_r$. Quindi ogni tupla in un gruppo all'interno di un frammento può essere associata con almeno k tuple nell'altro frammento, dove k è la numerosità del suo gruppo con la numerosità del gruppo di destra

##### Deep heterogeneity

**Nessun gruppo** può essere associato con 2 gruppi che contengono tuple **alike**
- tutte le coppie $k_l \times k_r$ nella group association a cui ogni tupla corrisponde contiene diversi valori di attributo riguardanti i constraint

#### Flat grouping vs Sparse grouping

$k_l \times k_r$-grouping è
- **Flat** se $k_l$ oppure $k_r$ è uguale a 1
- **Sparse** se $k_l$ e $k_r$ sono diversi da 1

Il flat grouping ricattura il **k-anonymity** e allo stesso tempo **l-diversity** ma lavora sulle associazioni e valori di attributi non generalizzati

Sparse grouping garantisce **grande applicabilità** rispetto al flat **MA** con lo stesso livello di protezione

#### Privacy vs Utility

La pubblicazione di associazioni loose incrementa l'utilità
- rende possibile valutare query in modo più preciso rispetto ai frammenti
- l'incremento di utilità si traduce in una maggior esposizione delle informazioni, quindi minor privacy

#### Association exposure

L'esposizione di associazioni sensibili dato un constraint $c$ coperti dai frammenti $F_l$ e $F_r$ può essere espressa sotto forma di probabilità che l'associazione sia mantenuta anche nella tabella originale
- Può essere calcolata come la probabilità che l'associazione sensibile appaia nella tabella originale
	- Dato $f_l$, $f_r$ e A
	- Dato $f_l$, $f_r$

All'aumentare di 