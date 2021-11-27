# Fragmentation ed encryption

L'encryption è troppo ingombrante. Spesso il problema è **l'associazione** tra valori ciò che è davvero sensibile, invece dei valori. Invece di cifrare, **rompo l'associazione**

Posso usare **encryption** e **data fragmentation**

## Confidentiality constraints

Sono un insieme di attributi il quale la joint visibility deve essere protetta

- **Sensitive attributes**: il **valore** non deve essere visibile, singleton constraints
- **Sensitive associations**: **l'associazione** tra i valori non deve essere visibile, non-singleton constraints

### Data fragmentation

#### Non-communicating pair of servers

Splitto le informazioni su 2 server indipendenti che non possono comunicare. Cifro solo quello che è richiesto cifrare e che anche con lo splitting finirebbe per fare un associazione.

Dato un confidentiality constraint $\mathscr{C}$ su R decompongo R come
- $R_1$ ed $R_2$ che includono dei tupleID unici per non perdere nulla
- $R_1 \lor R_2 = R$
- $E$ insieme di attributi cifrati che è sottoinsieme di $R_1$ ed $R_2$
- per ogni constraint $c \in \mathscr{C}, c \notin (R_1 - E) \land c \notin (R_2 - E)$

##### Query execution

Posso prendere $R_1$ ed $R_2$ e poi fare la mia query, ma è troppo costoso. Cerco di dividere la query sui due server $S_1$ ed $S_2$ (**push down selections and projections**)

###### Optimal decomposition

- ottimizzo il workload $W$ (BAD)
- **affinity matrix**
	- $M_{i,j}$ costo di frammentazione degli attributi $i$ e $j$
	- $M_{i,i}$ costo di cifrare l'attributo i su entrambi i frammenti
	- goal: Minimizzare il costo

**hypergraph coloring problem**, è NP-Hard

#### Multiple non-linkable fragments

L'assunzione dei server non comunicanti è troppo forte, teoricamente impossibile. Quello che posso fare è permettere più di 2 **non-linkable** fragments

La frammentazione di R è un insieme di frammenti $\mathscr{F} = \{F_1, ..., F_m\}$ dove ogni $F_i$ è un sottoinsieme proprio in R. Una frammentazione $\mathscr{F}$ soddisfa $\mathscr{C}$ se e solo se
- ogni frammento individuale soddisfa i costraint
- i frammenti **non hanno attributi in comune**

Ogni frammenti $F_i$ è mappato in un **frammento fisico** che contiene
- tutti gli attributi di F in chiaro
- tutti gli altri attributi  di R cifrati con salt per ogni encryption

Quindi abbiamo che ogni blobbone crittato contiene tutti gli attributi di R cifrati. Per fare le query devo dividere in:
- $Q^3$ seleziono salt ed enc dove la malattia è gastrite o asma
- $Q'$ seleziono ssn, name da Decrypt($Q^3$, Key) dove job è doctor

##### Optimization

Trovare la frammentazione che mi rende l'esecuzione di query efficienti in base a diversi criteri
- Numero di frammenti
- Affinità tra attributi
- Workload delle query

###### Minimal number of fragments

Problema NP-Hard, = heuristic FTW.

Euristica: una definizione di minimale:
- $\mathscr{F}$ è **minimale** se ogni frammento in esso combinato viola almeno 1 constraint

###### Maximum affinity

Preserva l'associazione tra attributi ma usa un'**affinity matrix** che rappresenta i vantaggi di avere coppie di attributi nello stesso fragment. NP-Hard problem, bella zi.

Euristica: combino iterativamente frammenti con la massima affinità che non violano nessun confidentiality constraint

###### Query workload

Minimizzo il costo di esecuzione delle query. NP-Hard ancora.

Euristica: sfrutto la monotonicità della funzione del costo della query rispetto alle dominanze nelle relazioni tra frammenti, oppure traversal di uno spanning tree