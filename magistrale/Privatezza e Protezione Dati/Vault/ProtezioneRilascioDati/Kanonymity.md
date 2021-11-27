# K-anonymity

Approccio che sfrutta la generalizzazione e la soppressione per proteggere le identità dei rispondenti, ovvero identity disclosure 

*il rilascio dei dati dovrebbe essere indistinguibilmente relazionato con non meno di un certo numero k di rispondenti*

L'attenzione è posta ai quasi-identifiers 

- condizione sufficiente: ogni quasi-identifiers deve apparire almeno **k volte** nella tabella, dove per quasi-identifiers

La soppressione riduce l'ammontare di generalizzazione richiesta per soddisfare il k-anonymity constraint

## Gerarchie

### Domain generalization hierarchy

$D_i \le_D D_j$ i valori nel dominio $D_j$ sono una generalizzazione (quindi dominano) dai valori nel dominio $D_i$

$DGH_d = (Dom, \le_D)$ **domain generalization hierarchy**

Nel caso di tuple, come i quasi-identifiers, fatta di $DT = (D_1, ..., D_n)$, la loro gerarchia di generalizzazione è il prodotto cartesiano: $DGH_{DT} = DGH_{D_1} \times ... \times DGH_{D_n}$

### Value generalization hierarchy

è un albero

## K-minimal generalization with suppression

Devo definire:
- **MaxSup** ovvero massima soppressione che voglio, in % o in \#
- **k** numero di rispondenti per ogni n-upla di quasi-identifiers

### Preferred generalization

- **minimum absolute distance**: smallest total number of generalization steps
- **minimum relative distance**: smallest total number of **relative** generalization steps: $\frac{1}{2} \gt \frac{1}{3}$
- **maximum distribution**: max distinct tuples
- **minimum suppression**: max cardinality


### Solutions

NP-hard problem, il tempo computazionale è esponenziale al numero di attributi che compone il quasi-identifier in input, quindi cardinalità di QI

#### Attribute Generalization - Tuple Suppression algorithms (AG_TS & AG_)

##### Binary search

1. Soluzioni ad altezza h/2: esiste?
	1. Si: ripeti step 1 con input albero \[0, h/2\] (cerca in h/4)
	2. No: ripeti step 1 con input albero \[h/2, Max\] (cerca in 3h/4)
2. Fine: altezza minima dove c'è un distance vector che soddisfa k-anonymity

Usa **distance vector matrix**

##### K-Optimize

Preparazione
1. Ordina i valori di attributi in QI nei loro rispettivi domini
2. Usa **integer index** dando un numero a ogni valore attributo in ordine
3. Parti dalla radice vuota
4. Crea ogni figlio come padre + valore di index+1 tale per cui il risultato è un set ordinato
5. A ogni nodo associa un **costo** che riflette **l'information loss associato alla generalizzazione o soppressione**
6. Ripeti fino alla fine

**Pruning**
1. Leggi nodo, computa il **costo**
2. Se il costo è sopra il lower bound, taglia l'intero sottoalbero

Questo perchè più vado sotto, più c'è dettaglio, meno k-anonymity ho. Se non riesco a rispettare il mio lower bound sopra, più vado sotto più è peggio

##### Incognito Algorithm

**bottom-up approach**

1. Per ogni attributo in QI
2. Controlla se soddisfa k-anonymity
3. Tutti quelli che non lo soddisfano vengono il livello di generalizzazione vengono eliminati, tutti quelli che rimangono si fanno tutte le combinazioni a gruppi di 2
4. Controlla se soddisfano k-anonymity
5. Tutti quelli che... vengono eliminati, quelli che rimangono faccio combinazioni a gruppi di 3
6. ...
7. All'iterazione |QI| ritorna il risultato

#### Cell Generalization - Cell Suppression algorithms (CG_ & \_CS)

##### Mondrian multidimensional

- Ogni attributo in QI è una dimensione
- Ogni tupla è un punto nello spazio dimensionale
- Ogni tupla uguale è un numero nello spazio, invece che un punto (**multiplicity**)

1. **Splitting**: partiziona lo spazio multidimensionale in modo che ogni area della partizione contiene k-occorrenze
2. Ogni punto presente in una partizione di dimensione k diventa un **valore generalizzato unico**
3. Le tuple corrispondenti vengono sostituite

è un algoritmo flessibile, multidimensionale, supporta recoding a livello locale e globale, partizionamento stretto e rilassato (overlapping di partizioni) e diverse metriche

# K-anonymity revisited (Cell Generalization CG_)

le k-occorrenze per tuple sono sufficienti ma **non necessarie**
- per ogni sequenza di n-valori di QI nella tabella originale ci sono almeno k-tuple che contengono valori generalizzati della sequenza di n-valori nella tabella generalizzata
- per ogni sequenza di n-valori di QI nella tabella generalizzata ci sono almeno k-tuple nella tabella originale che contengono una sequenza di valori per cui gli n-valori sono una generalizzazione

# K-anonymity in other applications

## Social network (graphs)

### Neighborhood attack

Dato un grafo re-identificato G' dato da un grafo di una rete sociale G, viene fatto exploit della conoscenza dei vicini degli utenti u per reidentificare il vertice che rappresenta u

Ogni vertice in G non può essere re-identificato in G' con una confidenza più grande di $\frac{1}{k}$
- Aggiungo fake vertex

## Location based (geographical)

Per proteggere l'identità di persone in una location considerando location in cui ci sono almeno k-individui
- Allargo l'area per comprendere almeno k-1 utenti (**k-anonymity**)
- Proteggo la locazione dell'utente, sorta di soppressione, offuscando l'area o diminuendo la precisione (**location privacy**)
- proteggo le traiettorie percorse (**trajectory privacy**)


