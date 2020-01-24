# Testing
Tecnica ottimistica: puo' rilevare la presenza di malfunzionamenti ma non puo' provare la loro assenza

### FORMALE

- P(d) = esecuzione del programma 'P' sul dato 'd'
- D = dominio dei dati
- ok(P, d) = correttezza dell'esecuzione del programma 'P' sul dato 'd'
- P e' corretto se ∀ d ∈ D ok(P, d)

Attenzione: non sempre vero, per esempio quando un metodo agisce su un oggetto non e' un vero parametro.

- T = sottoinsieme del dominio 'D'
- t = elemento di T, detto caso di test
- esecuzione test = esecuzione di tutti i casi di test 't' del test 'T'
- ok(P, T) ⇔ ∀ t ∈ T ok(P, t)

- successo(T, P)
	- un test T ha successo se rileva uno o piu' malfunzionamenti presenti nel programma P
	- un test ha successo quando rileva un difetto prima ignoto
		- malfunzionamento nel programma dovuto ad un difetto non ancora individuato
- passare o superare test
	- un test che ha insuccesso...
	- cioe' il programma ha successo

- T e' **ideale** per P se e solo se
	- ok(P, T) ⇒ ok(P, D)
		- se l'insuccesso del test implica la correttezza del programma

- E' impossibile trovare un test ideale (E. Dijkastra). Troppi dati da testare
	- **criterio di selezione del test** che approssimi il test ideale. Cerco test significativi.
		- prendo tipologie molto diverse di dati accettabili in input.

### Proprieta' criteri di selezione dei test
```c
int raddoppia(int number) {
	int risultato = number * number;
	return risultato;
}
```
- un criterio C si dice **affidabile** se dati T1 e T2 in base a C, allora
	- affidabile(C, P) ⇔ (∀ T1 ∈ C, ∀ T2 ∈ C successo(T1, P) ⇔ successo(T2, P))
		- ⇔ e' ridondante: basta un implica ⇒

	NON ESISTE UN CRITERIO CHE GARANTISCE AFFIDABILITA'
		- L'unico criterio affidabile che esiste e' il criterio con un singolo test T (uno o piu' casi di test). Quindi se T1 e T2 hanno successo, vuol dire che sono lo stesso test

- un criterio C si dice **valido** se, qualora P non sia corretto, allora
	- esiste almeno un test T selezionato in base al criterio C che ha successo per il programma P
	- valido(C, P) ⇔ (!ok(P, D) ⇒ (esiste T ∈ C && successo(T, P)))

	- **esempio**
		-  il criterio che seleziona solo sottoinsiemi di {0, 2} e' **affidabile** ma **non valido**
		- il criterio che seleziona solo sottoinsiemi di {0, 1, 2, 3, 4} e' **non affidabile** ma **valido**
		- in questo caso, un criterio **sia affidabile che valido** seleziona un sottoinsieme di tutti i numeri > 2.

		- **ATTENZIONE**: non mi basta che un criterio sia affidabile e/o valido, perche' non e' universale per tutti i programmi

- TEOREMA: se esistesse un C affidabile e valido, selezionerebbe solo **test ideali**
	- **NON ESISTE** un algoritmo che dato un programma arbitrario P mi generi un test ideale finito (criterio affidabile E valido)
		- il caso esaustivo del dominio non va considerato

### Altri criteri / approcci
- Approccio White-Box: Test Strutturale
	- gli errori si annidano negli angoli e si radunano ai confini
	- **errori logici** e **assunzioni corrette** sono inversamente proporzionali alla prossiblita' che un certo cammino venga esseguito
		- elaborazione normale tende ad essere meglio compresa
	- spesso si crede che un certo cammino logico sia eseguito solo raramente
	- gli errori di battitura

### Considerazioni
- Un caso di test per essere considerato **efficace** deve soddisfare 3 requisiti
	1. eseguire il comando che contiene il difetto
	1. l'esecuzione del comando contenete il difetto deve portare il sistema in uno stato incosistente (scorretto)
	1. lo stato scorretto deve propagarsi fino all'uscita del codice in esame, in modo da produrre un output diverso da quello atteso

## Test Strutturale (Flusso di Controllo)
### Criteri di copertura
A ogni criterio e' possibile associare una misura di copertura
- possibilita' di valutare la bonta' di un particolare test
- criterio di adeguatezza (terminazione di attivita' di testing): soglia sopra il quale il test viene ritenuto ragionevole
- misura espressa come percentuale di copertura

#### Copertura dei comandi
Per rilevare un errore in un particolare comando bisogna eseguire tale comando almeno una volta (condizione necessaria non sufficiente)

- un test T soddisfa ... se e solo se ogni comando eseguibile del programma e' eseguito in corrispondenza di almeno un caso di test 't' contenuto in T

- % CoperturaComandi = (comandi_eseguiti / comandi_eseguibili) * 100

Il criterio di copertura dei comandi non e' affidabile ma e' valido. **ATTENZIONE**: la copertura dei comandi lascia scoperta ancora una cosa, ovvero che a fronte di diramazioni (if) non considera gli archi, ovvero le diramazioni, cioe' tutti i percorsi possibili del flusso, ma considera solo l'esecuzione di ogni linea.

#### Copertura delle decisioni
- Un test T soddisfa ... se e solo se ogni arco del grafo di controllo del programma e' percorso almeno una volta in corrispondenza di almeno un dato di test 't' contenuto in 'T'.
- implica automaticamente che soddisfa il criterio di copertura dei comandi

- % CoperturaDecisioni = archi_percorsi / archi_percorribili * 100

**ATTENZIONE**: non tengo in considerazione le condizioni, ovvero che la copertura e' basata sugli archi, non sulle singole condizioni presenti nelle diramazioni (if).

#### Copertura delle condizioni
- Un test T soddisfa ... se e solo se ogni singola condizione che compare nelle decisioni del programma assumono valore sia vero che falso per diversi dati di test in T.

- **non ha** nessuna relazione di inclusione con la copertura delle decisioni ne dei comandi

#### Copertura delle decisioni e condizioni
Entrambi i criteri veri

#### Copertura delle condizioni composte (IMPRATICABILE, TROPPI TEST)
- Un test T soddisfa ... se e solo se ogni possibile composizione delle condizioni base vale sia vero che falso per diversi dati in T ({vero vero} {vero falso} {falso vero} {falso falso})

- implica automaticamente che soddisfa i criteri precedenti

## Problema
crescita molto veloce del numero di casi di test al crescere del numero delle condizioni base. Potrebbero esistere combinazioni non fattibili (condizioni base non indipendenti)
- Puo' essere d'aiuto in certi casi condiserare cortocircuitazione della valutazione delle condizioni

### Condizioni/Decisioni Modificate
Si da importanza nella selezione delle combinazioni al fatto che la modifica di una singola condizione base porti a modificare la decisione. Devono esistere per ogni condizione base due casi di test che modificano il valore di una sola condizione base e che modificano il valore della decisione

- e' dimostrabile che se ho N condizioni ho N+1 casi di test (crescita lineare, a differenza delle condizioni composte, esponenziale 2^N)
- implica copertura decisioni e condizioni, + significative e - combinazioni

## Altri criteri
I criteri visti finora non considerano i cicli e possono essere soddisfatti da test che percorrono ogni ciclo al massimo 1 volta. Servono altri criteri per considerare i cicli iterativi
- Euristica: molti errori si verificano durante le fasi di iterazione successive alla prima (tipo outOfBound).

### Copertura dei cammini (SPESSO IMPRATICABILE)
- Un test T soddisfa ... se e solo se ogni cammino del grafo di controllo del programma viene percorso per almeno un dato di test in T

C = n_cammini_percorsi / n_cammini_percorribili

- molto generale, spesso impraticabile
	- vengono fatte approssimazioni o limitazioni

### N-Copertura  dei cicli
viene limitato il numero massimo di percorrenze dei cicli
- se e solo se ogni cammino del grafo conenente **al massimo** un numero di iterazioni di ogni ciclo non superiore a N viene percorso per almeno un dato di test
- limiti
	- non so il valore ottimale di N
	- crescita rapida dei casi di test necessari al crescere di N

##### Livello 2
Copertura di livello N=2
- si basa su precondizioni, postcondizioni, invarianti
- un ciclo eseguito
	- 0 volte vuol dire che le postcondizioni devono essere gia' valide
	- 1 volta vuol dire che le postcondizioni devono essere valide al verificarsi della condizione di uscita
	- piu' di 1 volta testa la condizione in cui l'invariante di ciclo piu' le condizioni di uscita implicano le condizioni di uscita

## Test Strutturale (Flusso di Dati) (non e' una tecnica di testing)
### Analisi Statica
esamina un insieme finito di elementi (istruzioni del programma) contrariamente all'analisi dinamica (insieme degli stati e delle esecuzioni)
- non fa esplodere il numero di casi da esaminare
- non considera evoluzioni runtime delle variabili
- meno costosa del testing
 - da applicare sempre

**Esempio**: puntatore non inizializzato
- Verifica dinamica (es. testing)
	- facile per una particolare esecuzione
	- ma impossibile sapere se questo valga in generale

- Verifica statica (data flow)
	- tre possibili risultati: si, no, forse

#### Analisi statica in compilazione
La sua efficacia e' dipendente dal linguaggio utilizzato e dal compilatore impiegato
- analisi lessicale
- analisi sintattica
- controllo dei tipi (forte, medio, debole)
- analisi flusso dei dati

Fare un'analisi di questo genere permette di identificare un buon criterio di selezione.

### Analisi Data Flow
Staticamente e' possibile identificare il tipo di operazione su una variabile eseguito da un comando
- **(d)efinizione**: se il comando assegna un valore alla variabile
- **(u)so**: se il comando richiede il valore di una variabile (lettura)
	- p-uso: nel predicato di una condizione
	- c-uso: nel calcolo di un valore
- **(a)nnullamento**: se al termine dell'esecuzione dell'istruzione il valore della variabile cambia significativamente

Posso rappresentare l'evoluzione di una variabile tramite questi flag. Esempio

```c
// CODICE SBAGLIATO
void swap(int *x1, int *x2) {
	int x; 		
	x2 = x;		
	x2 = x1; 	  
	x1 = x;

	// x  -> auua
	// x1 -> dud
	// x2 -> ddd
}
```

**ANOMALIE**

Non sono regole assolute, ma alcuni compilatori alzano degli warning.

- **\*au\***
	- x viene usata 2 volte prima di essere stata inizializzata
- **\*d**
	- x1 viene (ri)definita e mai piu' usata
- **\*da\***
	- x2 viene definita piu' volte senza essere usata

In caso di un iterazione (esempio ciclo while), di fronte a un operazione del tipo ```a = a - b``` scrivero' prima ```a -> u``` e poi ```a -> d```

**SEQUENZE**

P(p, a) indica la sequenza ottenuta per la variabile a eseguendo il cammino p.
Esempio: ```P([1,2,3,4,5], a) = a d ud u a```

Per rappresentare P in caso di cicli di iterazione e decisioni uso **espressioni regolari:**

- |
	- alternative
- [ ]
	- opzionalita' (0..1)
- \*
	- cicli (0..n volte)
- \+
	- cicli (1..n volte)

Esempio:
```c
void main() {
	float a, b, x, y;
	read(x);
	read(y);
	a = x;
	b = y;

	while (a != b) {
		if (a > b) {
			a = a - b;
		} else {
			b = b - a;
		}
	}

	write(a)
}
```

variabile a:
- a d
- a d u( while )* u a
- a d u( u if )* u a
- a d u( u ( u d | u ) )* u a
- a d u( u ( u d | u) u)* u a

### Criterio di selezione DF (Data Flow)
dopo aver eseguito l'istruzione che definisce o assegna il valore, andarla ad usare. Stimolare le definizioni-uso.
- basare la selezione dei casi di test sulle sequenze definizione-uso delle variabili
	- un ciclo viene ripetuto un numero maggiore di volte se questo consente di eseguire un DU non ancora esaminate
	- permette di stabilire quanti cicli fare
- du(x, i) e' l'insieme dei nodi j tali per cui
	- esiste un cammino libero da ulteriori definizioni di x da i a j
- def(i) e' l'insieme delle variabili x che sono definite nel nodo i

#### Criterio selezione DF (Definizione Uso)
Un test T soddisfa ... se e solo se per ogni nodo i e ogni variabile x appartenente a def(i), T include un cammino libero da definizioni da i ad almeno uno degli elementi di du(i, x)
- Bisogna usarli in maniera tale che non ci siano altre definizioni nel mezzo

Esempio:
```c
void main() {
	float a, b, x, y;
	read(x);
	read(y);
	a = x;           // def1
	b = y;

	while (a != b) { // p-u
		if (a > b) {   // p-u
			a = a - b;   // def2 // c-u
		} else {
			b = b - a;   // c-u
		}
	}

	write(a) // c-u
}
```

p-u = uso in predicativo (condizioni)
c-u = uso in comando

Sia la definizione in def1 sia in def2 crea insiemi equivalenti. Basta un'unica iterazione (unico caso di test)

Selezioni i test per la variabile a (esempio) e faccio dei casi di test per cui percorro dei cammini d,u e d,u. Devo coprire almeno un uso dopo ogni definizione

#### Criterio copertura usi (include il precedente)
Un test T soddisfa... se e solo se per ogni nodo i e ogni variabile x appartenente a def(i), T include un cammino libero da definizioni da i ad ogni elemento di du(i, x)
- almeno 2 iterazioni
	- il debugging parte da quando c'e' un malfunzionamento noto e riproducibile.
- e' meglio avere test piu' piccoli che coprono piccole parti di codice. In questo modo so gia' dove andare a concentrarmi per cercare il malfunzionamento. Esecuzione piu' breve, quindi con esecuzione passo passo arrivo subito al problema. Piu' mirati.

#### Criterio copertura cammini DU (Definizione Uso)
Esistono diversi cammini che soddisfano il criterio di copertura usi. In questo criterio, devo selezionarli tutti. (include il precedente) IMPRATICABILE

### Oltre le variabili
FILE
- (a)pertura
- (c)hiusura
- (l)ettura
- (s)crittura

REGOLE?
- l (e s e c) deve essere preceduta da a senza c intermedie
- a deve essere seguita da c prima di altra a
- legame tipo apertura ed operazioni

### Cosa cambia con Object Oriented?
Nei linguaggi procedurali il programma e' composto da funzioni e procedure che si chiamano a vicenda scambiandosi dati tramite i parametri
- variabili globali deprecate

Nei linguaggi OO, gli oggetti hanno legati metodi, ma anche uno stato. Infatti i metodi hanno side-effects sugli oggetti (Esempio: lista vuota, pop() varia a seconda se la lista e' vuota o non vuota).
- i metodi non possono essere sempre testati isolatamente

Cosa e' un'unita' testabile?
- dalla procedura ci si sposta alla classe

### Testing ed ereditarieta'
- basta testare un metodo una volta?
	- devo ritestare i metodi di classi padre e classi figlio
	- quello stesso metodo viene ereditato da una sottoclasse e va ritestato nel nuovo contesto
	- esempio: se specializzo una classe, mi devo aspettare che i test della classe padre siano validi anche per le classi specializzate (liskov)
- come testare le classi astratte?
	- testare una classe prima che sia completa
	- si possono prevedere delle dummy implementation dei metodi astratti

### OO e late binding (dynamic binding)
- complica la determinazione dei criteri di copertura perche' non si possono piu' stabilire staticamente tutti i cammini

### Class Testing
- isoliamo una classe
	- costruiamo classi stub per renderla eseguibile indipendentemente dal contesto
		- esempio: non ho tutti i moduli che mi servono, deve ancora essere sviluppato un componente da cui dipende la mia classe
	- implemento metodi astratti (stub)
	- aggiungiamo una funzione che permetta di estrarre ed esaminare lo stato dell'oggetto
		- per bypassare l'incapsulamento (togliere information hiding)
			- attenzione: sono sicuro di ricordarmi di togliere i vari metodi/funzioni getter per estrarre informazioni private quando mandero' il mio codice in produzione?
	- costruire una classe driver che permetta di istanziare oggetti e chiamare i metodi secondo un criterio di copertura scelto
		- quale?

#### Copertura della classe
- Abbiamo detto che dobbiamo considerare lo stato dell'oggetto
- Abbiamo una definizione "statica" di cosa e' lo stato dell'oggetto?
	- potrebbe esistere nella documentazione una rappresentazione come macchina a stati dell'oggetto che ci dice
		- gli stati
		- le transazioni (chiamate che cambiano lo stato)

##### Criterio di copertura
- Abbiamo un diagramma, possiamo:
	- coprire tutti i nodi
		- coprire tutti gli stati di un oggetto
	- coprire tutti gli archi
		- tutti i metodi per ogni stato
	- coprire tutte le coppie I/O
		- tutti i cammini del grafo

##### Problema
- Potrebbe non esiste una rappresentazione in macchina a stati finiti (esplosione di stati)
	- mediante tecniche di reverse engineering posso estrarre informazioni dal codice
	- non puo' essere fatta nemmeno automaticamente in tutte le volte

##### Cosa possiamo fare?
- un altro criterio di copertura
	- la persona che sviluppa il codice e' quella meno adatta per fare il testing
	- introduciamo deliberatamente n-errori dentro il codice prima di mandare il programma a chi lo deve testare (BEEBUGGING), cosi' che possano spuntare anche errori non intromessi manualmente
		- ha un obiettivo stabilito
	- esempio: come nella settimana enigmistica: se c'e scritto che ci sono 10 differenze tra due immagini (errori), sono incentivato a trovarne, altrimenti posso gettare la spugna subito se non so quanti ce ne sono o se ci sono. Fattore psicologico (incentivo)

### Analisi mutazionale
Viene generato un insieme di programmi II simili al programma P in esame, su di essi vengono eseguiti gli stessi test T previsti per il programma P originale.
- se P e' corretto, allora i programmi II devono essere sbagliati
	- per almeno un caso di test, devono produrre un risultato diverso

**DOPPIO USO**
- Criterio di selezione
	- per ogni programma P' in II, T deve contenere almeno un t che produca per P' un risultato diverso da P
- Criterio di valutazione di un test
	- la bonta' e' data dal numero di programmi in II che vengono distinti da P in base a T

**GENERAZIONE MUTANTI**
Quanto differiscono i programmi in II da P? Quanti sono?

IDEALE
- differenze minime
- un mutante per ogni possibile difetto
	- virtualmente infiniti

**OPERATORI MUTANTI**
E' una funzione che, dato P, mi genera uno o piu' mutanti. I piu' semplici effettuano modifiche sintattiche che comportino modifiche semantiche conseguenti
- NON errori di compilazione

ESEMPI:
- Si distinguono rispetto all'oggetto su cui operano
	- costanti, variabili
		- scambio le loro occorrenze
	- operatori ed espressioni del programma
		- trasformo operazioni da true a false
	- sui comandi del programma
		- trasformo if in while, while in if...
	- possono essere specifici di alcuni tipi di applicazioni
		- sistemi concorrenti
			- primitive di sincronizzazione
		- sistemi Object Oriented
			- interfacce dei moduli

**CONSIDERAZIONI**
- Problema: prolifera il numero di esecuzioni da effettuare per completare un test. Oltre il numero di test, qui aumenta il numero di programmi da testare (mutanti).
	- puo' essere automatizzata la generazione, l'esecuzione e il controllo di tali test
		- estraggo un caso di test t da T a random (random e' un criterio di selezione),
	- Problema: non posso dire se e' corretto, mi dice solo se ci sono differenze, che e' diverso!
- Problema: l'equivalenza di due programmi e' un problema non decidibile (non esiste algoritmo automatico)
	- Ma chi testa e' un umano, per cui e' in grado di fare un analisi formale/logica
