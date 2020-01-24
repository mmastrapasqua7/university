# Tecniche di analisi
Devo definire delle tecniche di analisi che mi permettono di rispondere alle domande che mi interessano

**Dinamiche**
- albero (grafo) delle marcature raggiungibili
- albero (grafo) della copertura delle marcature raggiungibili

**Statiche (Strutturali)**
Ragionano indipendentemente dall'evoluzione della rete (come nel software: indipendente dall'esecuzione e dagli stati a runtime)
- identificazione P-invarianti
- identificazione T-invarianti

> ESEMPI:
- posso raggiungere una determinata marcatura?
- e' possibile una certa sequenza di scatti?
- esiste uno stato di deadlock?
- la rete (o una transizione) e' viva?

## Tecniche Dinamiche
### Albero di raggiungibilita'
1. crea la radice corrispondente alla marcatura iniziale, etichetta il nodo come "nuovo"
	- assegnamento di gettone ai vari posti (numero di tokens)
1. finche' ho dei nodi etichettati come "nuovi", eseguo i seguenti passi
	1. seleziona una mrcatura M con etichetta "nuovo" e togli etichetta
	1. se M e' identificata ad una marcatura sul cammino dalla radice ad M, etichetta M come "duplicata" e passa ad un'altra (importante per non far esplodere albero)
	1. se nessuna transizione e' abilitata in M, etichetta la marcatura come "finale"
	1. finche' esistono transizioni abilitate in M esegui i seguenti passi per ogni transizione t abilitata in M:
		1. crea la marcatura M' prodotta dallo scatto di t
		1. crea un nodo corrispondente a M', aggiungi un arco da M a M' ed etichetta M' come "nuovo"

#### Limiti
- Potrei metterci tanto a scriverlo, perche' devo enumerare tutte le possibili marcature raggiungibili
	- se la rete non e' limitata le marcature sono infinite, quindi non puo' essere completato

#### Risposte
- non ci sa dire se una rete e' limitata
- se e' limitata
	- ci sa dire quasi tutto, e' la esplicitazione degli stati della rete (automa a stati finiti corrispondente)
	- possono essere facilmente troppi (crescita esponenziale)
		- anche se gli stati sono finiti, possono esplodere, essere tantissimi

#### Copribilita'
Diciamo che una marcatura M **copre** una marcatura M' (M' e' coperta da M) se e solo se per ogni posto della rete, la marcatura del posto e' >= alla marcatura nuova del posto

Una marcatura M e' detta **copribile** a partire da una marcatura M' se esiste una marcatura M'' in R(M') che copre M

Sia M la marcatura minima per abilitare t (esattamente il numero di token necessari in ogni posto del Preset, il minimo necessario)
- la transizione t e' morta se e solo se M non e' copribile a partire dalla marcatura corrente
- altrimenti la transizione t e' almeno 1-viva

### Albero di copertura
1. crea la radice corrispondente alla marcatura iniziale, etichetta il nodo come "nuovo"
	- assegnamento di gettone ai vari posti (numero di tokens)
1. finche' ho dei nodi etichettati come "nuovi", eseguo i seguenti passi
	1. seleziona una mrcatura M con etichetta "nuovo" e togli etichetta
	1. se M e' identificata ad una marcatura sul cammino dalla radice ad M, etichetta M come "duplicata" e passa ad un'altra (importante per non far esplodere albero)
	1. se nessuna transizione e' abilitata in M, etichetta la marcatura come "finale"
	1. finche' esistono transizioni abilitate in M esegui i seguenti passi per ogni transizione t abilitata in M:
		1. crea la marcatura M' prodotta dallo scatto di t
		1. **se sul cammino dalla radice a M esiste una marcatura M'' coperta da M', aggiungi 'w' in tutte le posizioni corrispondenti a coperture proprie** (unica differenza con l'albero di raggiungibilita')
		1. crea un nodo corrispondente a M', aggiungi un arco da M a M' ed etichetta M' come "nuovo"
> Metto 'w' (omega) per indicare numero arbitrario di gettoni. E' l'unico controllo in piu' per vedere dove una marcatura puo' crescere arbitrariamente

#### Proprieta'
- una rete di petri e' limitata se non compare nemmeno un 'w' (omega) in nessun nodo dell'alberto di copertura
- una rete di petri e' binaria se nell'albero di copertura compaiono solo 0 e 1
- una transizione e' morta (0-viva) se non appare come etichetta di un arco dell'albero di copertura
- condizione necessaria affinche' una mrcatura M sia raggiungibile e' l'esistenza di un nodo etichettato con una marcatura che copre M (non e' sufficiente: mettendo omega 'w' **perdo dell'informazione**: Se voglio una marcatura M(p) = 50 e quell'omega nasconde il fatto che la marcatura arbitraria 'w' sono multipli di 3, la marcatura M(p) = 50 non sara' mai raggiungibile)
- non e' possibile decidere se una rete e' viva
	- ho perso informazione: un cammino non e' detto che sia ammissibile se e' percorribile. Perdo informazione rispetto all'albero di raggiungibilita'

#### Partendo da un albero di copertura posso tornare indietro alla rete di petri che l'ha generato? Se si non ho perso informazione, altrimenti ho perso informazione
- il peso di alcuni archi non posso saperlo, lo perdo nell'omega 'w'
- ma posso rappresentare almeno tutto quello che e' possibile che accada.
	- se c'e', puo' esserci (condizione necessaria non sufficiente)
	- se non c'e', sicuramente non c'e'

### Rappresentazione matriciale
e' possibile rappresentare (e anche definire) una reti di petri mediante delle matrici
- trasformazione automatica
- facilmente trattabile matematicamente

#### Componenti
- I archi in input alle transizioni
- O archi in output alle transizioni
- m marcatura dei posti

Devo assegnare un indice a ogni posto
- p: 1..|P| -> P
Devo assegnare un indice a ogni transizione
- t: 1..|T| -> T

##### 2 matrici I e O sono |P|x|T|
- ∀ <p(i), t(j)> ∈ F   I[i][j] = W(<p(i)>, t(j)>)
- ∀ <p(i), t(j)> !∈ F   I[i][j] = 0
- ∀ <t(j), p(i)> ∈ F   O[i][j] = W(<t(j)>, p(i)>)
- ∀ <t(j), p(i)> !∈ F   O[i][j] = 0

##### Per indicare il vettore colonna K di una matrice X useremo
- X[.][K]

##### Marcatura m e' un vettore colonna di dimensione |P|, si calcola a partire dalla funzione di marcatura
- m[i] = M(p(i))

##### Abilitazione di una transizione
la transazione j-esima e' abilitata in una marcatura espressa dal vettore m (m [ t j >)
- ⇔ I[.][j] <= m
	- elemento per elemento (m infatti e' |P|)

##### Scatto di una Transizione
Quando la transizione j-esima scatta in una marcatura m produce una nuova marcatura m' (m [ t j > m')
- m' = m - I[.][j] - O[.][j]

**NB**: Le matrici I e O sono indipendenti dalla marcatura, quindi posso creare una tabella di precalcolo (matrice di incidenza) per fare direttamente O-I e salvarlo

##### Matrice di incidenza C
- C = O - I
- risulta utile per ottimizzare lo scatto ma **non e' sufficiente per l'abilitazione**
	- in caso di una transizione che mette e toglie un gettone (arco bidirezionale p-t) nella matrice C ho uno 0, ma questo non vuol dire che nella realta' la transazione puo' scattare anche senza gettoni, e' un informazione che perdo
	- serve una condizione statica sufficiente per garantire che C sia significativa per l'abilitazione:
		- Pre(t) ^ Post(t) = O (insieme vuoto)
			- se le intersezioni sono tutte vuote si chiama **RETE PURA**

### Sequenza di scatti
- M [ t1 > M' and M' [ t2 > M'' => M [ t1 t2 > M''
- M [ Sn > Mn
- Mn = M + C*s
	- dove s e' il vettore di dimensione |T| contenente il numero di scatti per ogni transizione. Non e' altro che un numero che mi moltiplica C, un valore costante, per raggiungere una marcatura n-esima
	- s: tutte le sequenze ammissibili a partire da Mo (Marcatura Iniziale)

Tutto questo funziona se esiste una sequenza di scatti rappresentabile col vettore s, ovvero se ho informazioni sull'abilitazione della Matrice di incidenza C. Altrimenti rischio di passare per marcature negative e nemmeno me ne accorgo, anche se la sequenza finale Mn risultasse positiva. Attenzione.
> esempio: s = t1, t1, t4, t2, t3, .....
> una volta stabilita la sequenza s, calcolo il vettore di quante volte sono scattate  le transizioni:
> s = [(t1, 4), (t2, 3), (t3, 4), ...]
> s = [4, 3, 4, 3]
> |P|x|T| x |T| -> |P| (prodotto riga per colonna matriciale)
> al vettore di |P| che ottengo, devo sommargli la marcatura iniziale
> |M| + |P|ottenuta

## Tecniche statiche
Ricerca di invarianti all'interno della rete

### P-Invarianti
invarianti sui posti relativi alla marcatura. E' un vettore di pesi 'h' di dipensione |P|. E' il peso del numero dei gettoni, non il numero dei gettoni
- corrisponde alla nostra definizione di rete conservativa con la possibilita' che non tutti i pesi siano maggiori di zero
- il prodotto vettoriale h * m deve essere costante per qualunque marcatura raggiungibile
	- h*m = h*m'
- Voglio trovare gli h che mi rendono costante questo prodotto. Se m' e' raggiungibile allora c'e' una sequenza di scatti, e questo lo voglio vero per tutte le sequenze ammissibili, quindi per tutte le marcature raggiungibili
- m' = m + C*s
- h*m = h*m'
- h*m = h*m + h*Cs
- h*Cs = 0
	- deve valere per ogni s ammissibile
	- abbiamo tolto l'unica cosa che ci diceva la marcatura iniziale? NO: c'e' s, che e' sono tutte le sequenze ammissibili a partire da Mo (Marcatura iniziale)
	- e' una serie di sistemi da risolvere, per ogni vettore s (ogni sequenza ammissibile)
	- esplode il numero di s, e anche sapendo il numero esatto devo risolvere sistemi abnormi a multiincognita
Per semplificarmi la vita, calcolo solo h*C = 0, che e' un valore costante e piu' semplice da calcolare. Se trovo questa uguaglianza, di conseguenza anche h*C*s = 0 perche' h*C = 0 -> 0*s = 0
- h*C = 0
	- condizione sufficiente affinche' sia P-Invariante, **non necessaria**
		- perche' non necessaria: se trovo un vettore con tutti zeri e anche uno solo != 0, mi basta trovare una sola incognita nel vettore s che la annulli.
	- C e' costante
	- h sono le incognite
	- i valori che trovo hanno la caratteristica di annullarmi anche s
	- mi basta trovare le soluzioni di questo sistema lineare

Ci sono alcuni P-Invarianti che ci sono particolarmente utili: i **semipositivi** non hanno al loro interno dei valori negativi (N + {0}). Perche' significativi: mi obbliga nei posti in cui l'indice e' diverso da 0 ad essere limitati, ovvero non posso avere gettoni infiniti
- Una combinazione lineare di P-Invarianti e' anch'essa un P-Invariante
- Se un posto ha peso positivo in un P-Invariante semi-positivo, allora il posto e' limitato
- **Una rete P/T si dice ricoperta da P-Invarianti se per ogni posto esiste almeno un P-Invariante (semipositivo) il cui peso di tale posto sia positivo**
	- una rete copribile da P-Invarianti e' una rete limitata e conservativa

**algoritmo di farkas**

- h*M = h*Mo
- 1
	- lettoriPronti + lettoriAttivi = 4 (nuemro gettoni in lettoriPronti)
		- il numero di lettori nel sistema e' costante
- 2
	- scrittoriPronti + scrittoriAttivi = 2 (numero gettoni in scrittoriPronti)
		- il numero di scrittori nel sistema e' costante
-3
	- lettoriAttivi + Risorsa + 4 scrittoriAttivi = 4 (numero gettoni in risorsa)
		- se lettoriAttivi > 0 allora scrittoriAttivi = 0
		- se scrittoriAttivi > 0 allora lettoriAttivi = 0
		- scrittoriAttivi <= 1
		- lettoriAttivi <= 4 (numero gettoni in Risorsa)

Tutto questo puo' essere usanto anche a nostro favore in fase di progettazione (tipo non esplosione). Non solo come risultato, ma anche come base di partenza

#### Controllori con specifica a stati proibiti
- Transizioni osservate
- Transizioni controllate

##### Attenzione a cosa si puo' controllare
Non tutte le transizioni sono osservabili
-	 es. eventi che non sono rilevabili dal controllore, o troppo "costosi" da rilevare
non tutti gli eventi sono condizionabili
- es. una transizione che modella un guasto (questo non puo' essere impedibile dal controllore)

##### Quali vincoli esprimere?
Esprimiamo il comportamento desiderato (le proprieta') del nostro sistema dicendo che una combinazione lineare delle marcature non deve superare un certo valore
- fissiamo percio' delle P-invarianti "desiderati"
- L*M <= b

##### Esempio: mutua esclusione
- P1 + P3 <= 1
- aggiungiamo un posto Pc (Posto controllore) per raggiungere la condizione di P-Invariante, ovvero = e non <=
	- P1 + P3 + Pc = 1
	- dobbiamo aggiungere riga opportuna nella matrice di incidenza C
	- dobbiamo aggiungere riga opportuna a m

**Sintesi del controllore**
C = [Cs Cc]
- Cs = matrice incidenza sistema
- Cc = matrice incidenza controllore

Mo = [Mos Moc]
- Mos ...
- Moc ...

L*Ms + Mc = b
L*Ms + Mc = [L I]\*M = b

Ma allora vogliamo dire che [L I] e' un P-Invariante e quindi deve valere
- [L I] C = 0
- L*Cs + I*Cc = 0
- **Cc = -L*Cs**

Prendi il tuo vettori dei vincoli L (matrice dei vincoli), moltiplica per la matrice di incidenza del sistema e hai ottenuto cosa devi scrivere nella parte del controllore

- L*Mos + Moc = b
- Moc = b - L*Mos

### T-Invarianti
invarianti su sequenze di scatto (vincoli)
- cicliche (cioe' che possono essere ripetute)
- che riportano nella condizione iniziale

- m' = m + C*s
- m' = m
- soluzioni sistema:
	- C*s = 0

**Se una rete e' limitata e viva allora deve essere copribile da T-Invarianti**
- Quindi se una rete non e' copribile da T-Invarianti allora e' possibile che non sia limitata o che non sia viva (mutalmente escludibili)
