# Reti di petri P/T

Sono simili a 2 diagrammi gia visti: activity diagram e finite state diagram (superstati e stati finiti). La differenza e' che, mentre questi 2 sono monolitici, ovvero considerano il sistema come un tutt'uno, nelle reti di petri lo stato e' una composizione di tanti stati parziali, mentre le transizioni non operano piu' su uno stato globale ma si limita a variarne una parte. C'e' una versione base e poi sono state estese, tanti dialetti.

Non e' deterministica, nel senso che posso decidere io quale far scattare per primo, non c'e' un ordine. Tipico dei sistemi concorrenti. Se si vuole sincronizzazione bisogna introdurla nella rete con gli elementi

## Componenti
- Posti
- Transizioni
- Archi: Posti-Transizioni, Transizioni-Posti
- Token: Gettoni

### Formalmente (parte statica)
Una rete di petri e' definita dalla quintupla **<P, T, F, W, Mo>**:
- P: insieme dei posti
- T: insieme delle transazioni
- F: relazione di flusso (sottoinsieme dei prodotti cartesiani (P x T) unione (T X P))
- W: peso del flusso, associa un peso a ogni flusso, W: F -> N - {0}
- M: assegnamento di un numero naturale (gettoni) a un posto P. Marcatura iniziale Mo: P -> N (gettoni nel posto/nei posti di partenza)

**PRESET**
l'insieme dei Posti **o** Transizioni in ingresso in un nodo (che puo' essere un Posto o una Transizione)
- Pre(a) = {d ∈ (P v T) | <d, a> ∈ F}

**POSTSET**
l'insieme dei Posti **o** Transizioni in uscita in uscita da un nodo (che puo' essere un Posto o una Transizione)
- Post(a) = {d ∈ (P v T) | <a, d> ∈ F}

> NB: Una rete di petri e' tale se c'e' almeno un elemento tra posti e transizioni, ovvero: l'unione tra P e T deve essere diversa dall'insieme vuoto
> NB: l'intersezione tra P e T e' l'insieme vuoto

### Parte dinamica (la rete evolve)
#### Abilitazione transazione (scatto, fire)
Una transizione si dice abilitata, cioe' che puo' scattare (NON PER FORZA SCATTA, DECIDO IO), se ho sufficienti gettoni in tutti i posti in ingresso (se non specificato, almeno 1) (**condizione necessaria non sufficiente: devo farla scattare io**).
- t ∈ T e' abilitata in M ⇔ ∀ p ∈ Pre(t)   M(p) >= W(<p, t>)
	- si scrive anche: M [ t >
- lo scatto di t in M produce M'
	- M [ t > M'

#### Transizione scatta
Nello scattare, una transizione **consuma** (non sposta) i gettoni, e ne vengono **creati di nuovi** per ognuno dei posti in uscita.

Lo scatto di una transazione t in una marcatura M produce una nuova marcatura M'
- ∀ p ∈ Pre(t) - Post(t) ====> M'(p) = M(p) - W(<p, t>)
- ∀ p ∈ Post(t) - Pre(t) ====> M'(p) = M(p) - W(<t, p>)
- ∀ p ∈ (Post(t) ^ Pre(t)) ====> M'(p) = M(p) - W(<p, t>) + W(<t, p>)
- ∀ p ∈ P - (Pre(t) v  Post(t)) ====> M'(p) = M(p)

### Relazioni
#### Sequenza
t1 ∈ T e' in sequenza con t2 ∈ T in una marcatura M ⇔ M [ t > ^ ¬M [ t2 > ^ M [ t1 t2 >
- t1 e' abilitata in M
- t2 non e' abilitata in M
- ma t2 viene abilitata dallo scatto di t1 in M

#### Conflitto
(t1, t2) sono potenzialmente in conflitto
- **strutturale** ⇔ Pre(t1) ^ Pre(t2) != O (insieme vuoto)
	- tradotto: ho dei posti in comune in ingresso
- **effettivo** in una marcatura M ⇔ M [ t1 > ^ M [ t2 > ^ esiste p ∈ (Pre(t1) ^ Pre(t2)) | (M(p) < W(<p, t1>) + W(<p, t2>))
	- tradotto: esiste un posto in ingresso comune ad entrambe le transizioni e non ho abbastanza gettoni per farle scattare tutte e due, ma ne ho abbastanza per farne scattare solamente una
	- il conflitto strutturale e' una condizione necessaria ma non sufficiente per un conflitto effettivo.

**ATTENZIONE**
Variazione errata del conflitto effettivo:
- M [ t1 > ^ M [ t2 > ^ ¬M [ t1 t2 >
Non vuol dire la stessa cosa: questa prende in considerazione anche il PostSet (mentre il conflitto strutturale prende in considerazione solo il PreSet). NESSUNO CI VIETA CHE UN POSTO SIA CONTEMPORANEAMENTE NEL PRESET E NEL POSTSET (SIA INGRESSO CHE USCITA)

#### Concorrenza
(t1, t2) sono in concorrenza
- **strutturale** ⇔ Pre(t1) ^ Pre(t2) = O (insieme vuoto)
	- tradotto: non sono in conflitto strutturale (mutalmente esclusive)
- **effettivo** in una marcatura M ⇔ M [ t1 > ^ M [ t2 > ^ ∀ p ∈ (Pre(t1) ^ Pre(t2)) | (M(p) >= W(<p, t1>) + W(<p, t2>))
	- tradotto: t1 e t2 sono abilitate in M
	- tutti i posti in ingresso ad entrambe hanno abbastanza gettoni da farle scattare entrambe
	- la concorrenza strutturale non e' condizione necessaria ne sufficiente
	- questa concorrenza effettiva e' la negazione del conflitto effetivo

### Insieme di raggiungibilita'
L'insieme piu' piccolo di marcature tale che, a partire da una marcatura M
- M ∈ R(P/T, M)
- (M' ∈ R(P/T, M) ^ eiste t ∈ T | M' [ t > M'') ⇒ M'' ∈ R(P/T, M)
> P/T: posti/transizioni, rete

Questo insieme, anche se il piu' piccolo, puo' essere anche infinito!!!

### Limitatezza
Una rete P/T con marcatura M si dice limitata ⇔ esiste k ∈ N | ∀ M' ∈ R(P/T, M) ∀ p ∈ P M'(p) <= k
- tradotto: Per ogni marcatura Mnuova raggiungibile da una marcatura M, per ogni posto p della rete, la marcatura Mnuova del posto p il valore di gettoni e' inferiore a un numero k naturale,
	- ovvero: In tutti i posti della rete non supero mai un numero di gettoni k finito
	- quindi: e' possibile fissare un limite al numero di gettoni nella rete

Se la rete e' limitata allora
- l'insieme di raggiungibilita' e' finito
- e' possibile definire un automa a stati finiti corrispondente
	- gli stati sono le possibili marcature dell'insieme di raggiungibilita'

### Vitalita' di una transazione
Una transazione t in una marcatura M e' viva a
- **grado 0**
	- non e' abilitata in nessuna marcatura appartenente all'insieme di raggiungibilita' (e' morta)
- **grado 1**
	- esiste almeno una marcatura raggiungibile in cui e' abilitata
- **grado 2**
	- per ogni numero naturale n esiste almeno una sequenza ammissibile di scatti in cui la transizione scatta n-volte
- **grado 3**
	- esiste una sequenza di scatti ammissibile in cui scatta infinite volte (grande a piacere e' diverso da infinita)
- **grado 4**
	- in qualunque marcatura raggiungibile, esiste una sequenza ammissibile in cui scatta (e' viva)

**Una rete si dice viva** se tutte le sue transizioni sono vive (di grado 4)

# Estensioni reti di petri
## Capacita' dei posti
Estensione delle reti di petri in cui viene fissato a priori il numero massimo di gettoni che ci possono essere in un posto
- posso forzare la limitatezza della rete

E' un estensione base: Per simulare la capacita' di un posto nelle reti di petri classiche, basta aggiungere un posto complementare, dove il numero di token presente nella marcatura iniziale e' uguale al numero di gettoni massimi su quel posto nella rete capacitiva. Quindi non aggiungo ne tolgo nulla: e' solo una semplificazione

### Posto complementare
- un posto pc e' complementare di p se e solo se ∀ t ∈ T (esiste <p, t> ∈ F ⇔ esiste <t, pc> ∈ F W(<p,t>) = W(<t,pc>))
- per le reti pure (un posto non puo' essere pre e post condizione): ∀ t ∈ T (esiste <t,p> ∈ F ⇔ esiste <pc, t> ∈ F W(<pc,t>) = W(<t, pc>))

## Archi inibitori
Arco negato: dicono che non ci deve essere un token perche' la transizione sia abilitata.

**Attenzione**: DEVONO ESSERE ESATTAMENTE 0. E' comoda sintatticamente, e' facilmente rimappabile in una rete classica ma a una condizione: il posto che collego con l'arco inibitore sia limitato. Non mi interessa nell'intera rete, mi basta quel singolo posto
- in caso di rete limitata in quel posto non cambia potenza
- in caso di rete non limitata in quel posto aumenta potenza

Non sono considerate da tutti come estensione elegante ed in linea con lo spirito delle reti di petri: non posso fare alcune delle analisi, non posso dimostrare determinate proprieta'.

## Eliminazione pesi archi (W)
- Primo approccio (per rete classica)
	- Aggiungo P0bis e T0bis, ma non sono generati atomicamente perche' non e' deterministica.
	- Posto globale: Se non ho gettoni il resto della rete non si muove
	- esce fuori un casino allucinante

Conclusioni: il peso degli archi e' una forma sintatticamente potente e utile

## Rete Condizioni Eventi (C/E) (QUESTA E' PAZZIA)
Una rete viene detta C/E se
- tutti gli archi hanno peso 1
- tutti i posti hanno capacita' 1

Se i posti (Condizioni) in ingresso a t contengono un token, allora la transazione t (Evento) puo' scattare

Condizioni/Eventi perche' ogni posto diventa una variabile booleana (solo due stati, due marcature: 0,1 per ogni posto)

**TEOREMA**: una rete P/T limitata ha una corrispondenza nella classe C/E

## Rete Conservativa
Data una funzione di pesi H:
- H: P -> N - {0}

Una rete P/T con marcatura M si dice conservativa rispetto a tale funzione ⇔ ∀ M' ∈ R(P/T, M), la sommatoria pesata delle marcature su ogni posto secondo questa funzione H e' uguale alla sommatoria pesata delle marcature raggiungibili M' secondo questa funzione H

**CONSERVATIVA ⇒ LIMITATEZZA**

## Rete Strettamente Conservativa
Una rete P/T conservativa rispetto alla funzione che assegna pesi tutti uguali a 1 si dice strettamente conservativa
- il numero di token nella rete non cambia mai
- il numero di token consumato dallo scatto di una transizione e' uguale al numero di token generati dallo stesso
**ATTENZIONE**: Le transizioni morte: posso sbilanciarmi, ovvero cambiare il numero di gettoni nella rete, ma se una transizione morta mi congela dei token e il numero di quelli attivi invece e' sempre lo stesso, e' comunque strettamente conservativa
