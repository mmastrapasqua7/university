# Object Oriented Concepts
-  E' un modo di pensare, di progettare, di programmare. Non per forza devo usare un linguaggio OO, perche' tanto la macchina non capisce nulla oltre al binario, e' una questione umana. Per capire il problema ci ragiono sopra a oggetti, poi lo implemento.
- **Non risolve da solo i problemi**. E' basato su pochi concetti. Bisogna saperli dominare perche' dalla semplicita' e' facile sforare nel complesso.
- E' uno degli approcci possibili, non sempre il migliore in ogni situazione

## Prima
### Programmazione modulare
Ha studiato le relazioni tra moduli, per ricavare informazioni e consigli su come progettare un sistema a moduli
- **PRINCIPI**
	- **Abstraction** faccio qualcosa, gli do un nome e lo uso sotto quel nome. E' la capacita' di disegnare una scatola intorno a una parte del sistema. Encapsulation e Information Hiding sono la possibilita' di rendere la scatola opaca
	- **Encapsulation** faccio qualcosa, gli do un nome e restringo l'accesso diretto ai componenti di questa cosa. Viene controllato che veramente non ci guardo dentro. La cosa piu' stupida da fare e' nascondere gli attributi e definire un metodo Get (GETTER) per scaricarlo. In questo modo e' inutile. Bisogna pensare veramente chi deve fare una data operazione, e quindi delegare a qualcun altro (altro modulo, altra classe) a fare direttamente l'operazione.
	- **Information Hiding** cerco di nascondere una parte del codice, solitamente i dettagli implementativi, per evitare dipendenze col resto del mondo. Tramite questo, al cambiare dell'implementazione non dovro' modificare il resto

- **RELAZIONI**
	- sono esprimibili matematicamente (coppie ordinate di elementi)
		- USE, IS_COMPONENT_OF
	- sono rappresentabili graficamente
- **TIPI DI MODULI**
	- procedurale (singole procedure o librerie)
	- data pool (dati comuni)
	- abstract object: ho un SINGOLO oggetto, SINGOLA ISTANZA, e non un tipo per farci quello che voglio
		- vengono messe insieme procedure e dati. Invece che darti singoli pezzi, ti do un oggetto e metodi per poterti permettere di lavorare su un astrazione, facile interazione.
	- abstract data type:
		- viene definito un template, un modello per produrre in serie piu' abstract object
	- generic
		- template parametrici rispetto al tipo (tipo ArrayList<Type>), ovvero usabili con qualsiasi tipo sottostante

## Dopo
### Object Orientation
Si basa sul concetto di Abstract Data Type
- le **Classi**

Definisce nuove relazioni
- **Generalizzazione** (tramite meccanismo di ereditarieta')
	- anche detta Specializzazione
- **Aggregazione** (IS_PART_OF)

Definisce nuovi concetti e principi
- **Polimorfismo**
- **Binding Dinamico** (sono legati tra loro, anche se sono aspetti diversi. Possono esserci entrambi oppure no)

Vengono definiti linguaggi di specifica di progettazione e programmazione

#### Classi
Permettono di definire un insieme di oggetti che condividono
- comportamenti (metodi)
- conoscenze (attributi)

Sono il progetto di costruzione di un oggetto
- eventualmente incompleti (classi astratte)

Permettono di definire l'interfaccia della classe (separazione tra implementazione e interfaccia)
- information hiding e encapsulation

#### Polimorfismo
Permette di usare un oggetto di tipo A (appartenente a una classe CA) ovunque possa essere usato un oggetto appartenente alla classe da cui CA eredita. Non e' simmetrica.
- l'ereditarieta' non e' solamente un metodo di riuso del codice
	- gli oggetti della classe A possono essere visti come oggetti appartenenti alla classe CA, ovvero
	- A e' un sottotipo di CA
		- ma non viceversa

#### Binding Dinamico
Collegamento dinamico fa in modo che, nel caso in cui un metodo sia stato ridefinito, comunque venga sempre eseguita l'implementazione corretta di un metodo. Guardando il codice a runtime, dinamicamente, decido l'implementazione da chiamare.
- non puo' essere fatto staticamente

Mi permette di scrivere codice che richiama altro codice che non e' ancora stato scritto. La maggior parte dei pattern sfruttano questo concetto.

##### Come uso Polimorfismo e Binding Dinamico?
- Non ridefinire un metodo svuotandolo
- Liskov Substitution Principle
	- Sia q(X) una proprieta' provabile da oggetti X di tipo T, allora q(Y) deve esssere provabile per oggetti Y di tipo S dove S e' un sottotipo di T.
		- L'overriding non puo' essere completamente libero
- Design by Contract
	- definisce delle condizioni, delle precondizioni da soddisfare per le invocazioni
		- (PRECONDIZIONI + ESECUZIONE_METODO ===> POSTCONDIZIONI) (implica)
	- bisogna porsi la domanda: funziona il mio metodo figlio, ridefinito, per tutte le condizioni per cui funziona il metodo padre?

### Critiche all'OO
Design principle: Composition over inheritance. Non sempre l'ereditarieta' e' il mezzo migliore, esistono infatti altri approcci, tra i quali uno molto potente come la composizione (sul quale Golang si basa).

- Problemi OO:
	- non posso mettere delle politiche su chi mi puo' estendere, non posso vietare a nessuno di estendere una classe.
		- protected: il suo potere svanisce dato che non ho il controllo dei figli

- **Duck Saga**
	- Se modifico la classe base con un metodo, tutte le modifiche vengono ereditate da tutte le classi figlie, che la estendono. Esempio: Anatra. Se aggiungo alla classe base Anatra il fatto di poter volare, ci potrebbe essere una classe AnatraDiGomma che eredita' il fatto di saper volare. Controsenso.

	**Possibili Soluzioni**

		- Override
			- problema: viola il principio di Liskov: non posso togliere la capacita' a un oggetto, altrimenti non posso considerarla un sottotipo
		- Interfacce
			- divido le capacita': creo le interfacce flyable, quackable, duck. A ogni Anatra concreta faccio implementare tutte le interfacce.
				- problema: devo ridefinire i metodi (come fly()) in ogni singola classe. Riscrivo codice, duplicato.
		- Decorator
			- problema: eccessivo

	**Soluzione definitiva**

		- Strategy Pattern


## Come usare l'OO e i diagrammi UML

### S.O.L.I.D (principi)

Principi che devo rispettare per un buon software e per usare bene gli strumenti dell'Object Oriented.

- **( S ) - Single responsability**

	Ogni classe dovrebbe avere un singolo incarico, una sola cosa da fare, una sola ragione per cambiare. Le cose devono essere coese, quindi a ognuno la sua singola responsabilita'.

- **( O ) - Open close**

	Aperto alle estensioni e ai cambiamenti, Chiuso alle modifiche di architettura, interne. Toccare il meno possibile le classi gia' esistenti ma avere la possibilita' di crearne di nuove.

- **( L ) - Liskov sobstitution**

	Polimorfismo.

- **( I ) - Interface segregation**

	Single responsability applicato alle interfacce: fare interfacce specifiche per ruoli o entita', e non buttare tutto dentro un'interfaccia.

- **( D ) - Dependency inversion**

	Debo dipendere da cose astratte, non da classi concrete.

	- I moduli ad alto livello, ovvero astratti, non devono dipendere da moduli a basso livello, ovvero nel dettaglio. Entrambi dovrebbero dipendere dall'astrazione.
	- L'astrazione non dovrebbe dipendere dai dettagli. I dettagli dovrebbero dipendere dall'astrazione.

### Design principle
- Composition over inheritance
- Identifica gli aspetti della tua applicazione che variano e separale dalle parti statiche che non cambiano
- Programma sulle interfacce, non sulle implementazioni

# Bootstrap
## Modello dei dati (Trovare le classi utili)
Rappresenta da un punto di vista statico e strutturale l'organizzazione logica dei dati da elaborare.
- Vengono identificate le classi del nostro sistema
- E' un processo iterativo, incrementale e creativo
	- **identificazione dei pattern**
		- DESIGN PATTERN: soluzioni architetturali che svolgono un certo compito, risolvendo delle complicazioni. Entra a far parte della comunicazione in fase di progetto.

### Quali classi?
Classifichiamo le classi in tre tipi. Puo' essere specialmente utile all'inizio
- Entity
	- caratterizzano dominio applicativo
	- corrispondono alle strutture dati gestite dal sistema
- Control
	- gestiscono eventi del sistema, logica applicativa
- Boundary
	- rappresentano le classi che gestiscono l'intefaccia utente

### Da quali partire?
Esistono alcuni approcci (tecniche) standard
- **estrazione nomi**

	si basa sui requisiti, come frasi, commenti esplicativi scritti negli Use Cases. Vengono estratti tutti i sostantivi o frasi sostantivizzate. Si considerano tutti i candidati, si eliminano le ripetizioni e infine si selezionano i migliori, ovvero si estraggono meccanicamente.

	- criteri di sfoltimento:

		{ACCETTATE, RIFIUTATE, DUBBIO} (bianco, nero, grigio)

		- ridondanza: sinonimi, nomi diversi per lo stesso concetto. Attenzione: se il committente ha usato 2 parole diverse per lo stesso concetto, forse c'e' una ragione (concetto diverso, o generalizzazione. Esempio: prestito, prestito a breve termine)
		- nomi generici, vaghezza
			- elementi
		- nomi di eventi, operazioni
			- (esempio: prestito e' un'azione, non un oggetto)
		- metalinguaggio
			- sistema, regole
		- oggetti esterni al sistema
			- libreria, settimana
		- attributi
			- nome del membro
		- raffinamenti
			- ricerca di generalizzazioni
			- riconsiderare termini scartati

- **Common Class Types**

	basato sulla teoria della classificazione. Si pensa per tipi di oggetti:
	- concetti
	- cose reali
	- ruoli e persone
	- eventi
	- organizzazioni
	- posti

	E' piu' un controllo finale che una fase di progettazione. **Controllo post-estrazione**

- **CRC cards**
	- Piu' che identificare le classi e' utile per
		- verificare le classi (identificate con altri metodi) e
		- supportare l'identificazione di attributi e operazioni

	- Si parte da scenari d'uso
		- Si deve mantenere un linugaggio domain-oriented. E' presente il cliente (XP)
		- evitare frasario troppo object oriented

	Esempio CRC:
	- responsabilities
	- collaboration

- **Conoscenza dei pattern**

	Puo' aiutare nella fase di modellazione
	- rende piu' facile riconoscere situazioni comuni
	- fornisce direttamente delle soluzioni

- MISTI: almeno informalmente.
- OCL

	Linguaggio dei vincoli sugli oggetti, ovvero vincoli da scrivere su UML: ovvero come mutua esclusione (XOR) tra oggetti.
