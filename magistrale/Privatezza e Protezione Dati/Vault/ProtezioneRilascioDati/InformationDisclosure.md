# Information disclosure

Si ha quando
- un rispondente viene identificato da un rilascio di dati (**identity disclosure**)
- informazioni sensibili riguardo un rispondente vengono rivelate (**attribute disclosure**)
- i dati rilasciati permettono la determinazione dei valori di alcune caratteristiche di un rispondente anche se non esiste un dato esplicito a dichiararlo (**inferential disclosure**)

## Protezioni

- [[Microdati#Information Disclosure]]
- [[Macrodati#Information Disclosure]]

## Fattori di rischio

### Aumentano il rischio

- **esistenza di valori molto visibili** (tipo alto guadagno o lavori inusuali)
- **possibilità di incrocio dei microdati con informazioni esterne** (chi possiede una combinazione di valori o caratteristiche uniche o molto rare, tipo lavoro da prete)
- **alto numero di attributi in comune tra tabella pubblicata e informazioni esterne accessibili**
- **accuratezza / risoluzione dei dati**
- **numero e ricchezza di dati esterni**

Il fatto che un individuo è dentro o fuori una tabella deve essere segreto, è un dato sensibile esso stesso

### Diminuiscono il rischio

- **subset / sample**
- **not always up-to-date informations**
	- i dati nel mentre possono essere cambiati e possono cambiare di anno in anno
- **natural noise**
- **different form of expression** (differenti unità di misura o modi diversi per dire la stessa cosa)

## Misura del rischio

- Probabilità che un rispondente è presente sia nella tabella sia in file esterni
- Probabilità che il valore nella tabella sia uguale a una tabella esterna, match
- Probabilità che un rispondente sia **unico nella popolazione**
	- $\implies$ unico anche nel sample

# Privacy

## Definitions

### Syntactic

Riguardo i valori numerici, il **grado di protezione**, ovvero grado di protezione rispetto a un numero, come numero di individui, numero di classi, ecc...

### Semantic
Soddisfazione di requisiti di privacy semantici riguardo il meccanismo di rilascio. Esempio: l'esclusione o l'inclusione di tuple deve essere invisibile

#### Differential privacy

Previene un avversario da individuare **la presenza o l'assenza** di un individuo nel dataset. E' una proprietà sul **meccanismo di rilascio dei dati**. La distribuzione dei valori deve essere indipendente dal fatto che sia presente o assente un individuo

- **Interactive scenario**: run-time evaluation
- **Non-interactive scenario**: pre-computed data

Si fa l'enforcement della differential privacy tramite introduzione di **random noise**, rumore randomico

## Confronto

k-anonymity
- PRO
	- real-world requirements
- CONTRO
	- protezione **non** completa

differential privacy
- PRO
	- garanzie di protezione migliori
- CONTRO
	- non facile da capire e da rinforzare, protezione **non** completa

Attenzione: differential privacy previene l'attaccante dal dire se è presente o meno nella tabella, ma non se vi ha partecipato o meno nella generazione delle statistiche (tizio con grande income sbilancia la media degli stipendi)

# Altri problemi di privacy

## Distribuzione dei valori sensibili

Le tuple non sono sensibili in se, ma la collezione si, esempio:
- militari: distribuzione dell'età, in base all'età inferisco il grado, in base al grado inferisco la locazione.

