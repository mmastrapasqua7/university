# Verifica e Convalida

- **PERCORSO SOFTWARE**
	- requisiti
		- convalida: test di usabilita', feedback utente
	- software specs
		- verifica: test(ing) unita', code inspection, static analysis
	- system

## Terminologia
- **CONVALIDA**: confronto del software con i requisiti (informali) posti dal committente

- **VERIFICA**: confronto del software con le specifiche (formali) prodotte dall'analista. E' un grosso problema fare verifica di correttezza, perche' e' un compito prettamente umano non automatizzabile.

	**esempio**
	> Se premo un bottone, l'ascensore arriva in poco tempo

	Non posso verificarlo, ma posso convalidarlo.

	> Se un utente preme il bottone al piano x, l'ascensore arriva al piano x in 30 secondi

	Posso verificarlo

- **MALFUNZIONAMENTO (GUASTO, FAILURE)**: funzionamento non corretto di un programma. E' legato al **funzionamento** del programma e **non al suo codice**

	**esempio**

	```c
	int raddoppia(int number) {
		int risultato = number * number
		return risultato
	}
	```
	> invocando la funzione raddoppia() con parametro 3, ottenere il valore 9 e' malfunzionamento del programma

- **DIFETTO (ANOMALIA, FAULT)**: la parte di codice che contiene un problema per cui si generera' un malfunzionamento. E' legato al **codice** ed e' condizione necessaria (non sufficiente) per il verificarsi del malfunzionamento. Crea uno stato inconsistente, ma non e' detto che venga a galla, ma puo' creare reazione a catena (si propaga).
> il difetto si trova nella riga di assegnamento. Perche' non e' sufficiente: se chiamo la funzione raddoppia() con parametro 2, non vi e' nessun malfunzionamento.

- **ERRORE** e' la **causa** di un anomalia. In genere si tratta di un errore umano (concettuale, battitura, scarsa conoscenza linguaggio programmazione)

	**esempio**
	- battitura (+ invece che \*)
	- concettuale (non so cosa vuol dire raddoppia)
	- padronanza del linguaggio

	Nell'Arian V, l'errore era di aver ereditato del software che ha sempre funzionato per gli Arian precedenti, ma non e' stato mai piu' ritestato per il nuovo razzo piu' grosso. Infatti, il difetto era una conversione da tipo a tipo che causava overflow in certe condizioni.

## Tecniche
**STATICHE**
- Metodi formali
- Analisi Data Flow
- Modelli statici

Usate per gli elementi che non sono stati dell'esecuzione. La complessita' dell'analisi statica sara' proporzionale alla dimensione di queste parti statiche (classi, righe di codice, grandezza grafico ecc...). Elementi sintattici (non in evoluzione)

**DINAMICHE**
- Testing
	- trovare un malfunzionamento
- Debugging
	- a partire dal malfunzionamento, cerco di trovare il difetto che lo genera, correggendo l'errore

Molto laboriosa: (quasi) infiniti stati possibili. Non posso testarli tutti. Mando in esecuzione il programma portandolo in stati diversi, controllando il suo corretto funzionamento (testing). In caso di malfunzionamenti, incomincio la fase di debugging.

## Testing
si prefigge di **rilevare malfunzionamenti** o fornire fiducia nel prodotto (test di accettazione), tipo che non ho trovato malfunzionamenti a fronte di corner case o casi definiti dall'utente.
- White Box
	- conosco il codice
- Black Box
	- non conosco il codice (oppure non lo guardo)
- Grey Box
	- via di mezzo: conosco alcune cose, come qualche comportamento, configurazioni, framework usati o versioni software.

## Debugging
si prefigge di localizzare le anomalie che causano malfunzionamenti gia' rilevati in precedenza (tipo fase di testing)
- approccio incrementale

	limito la parte in cui ricerco il difetto. Faccio partire un programma e crasha. Cosa devo fare? Tolgo funzioni, metodi, chiamate. Elimino ulteriormente finche' non trovo la causa del crash

- produzione degli stati intermedi dell'esecuzione del programma

	Guardando sempre piu' in dettaglio nella stacktrace (esempio), vado fino al primo stato inconsistente
