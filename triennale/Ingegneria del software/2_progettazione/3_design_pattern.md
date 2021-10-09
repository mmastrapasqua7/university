#### Design Pattern
a livello di design, sono soluzioni a problemi ricorrenti che forniscono un'architettura vincente. Strumento concettuale che cattura la soluzione di una famiglia di problemi. Descrive il tipo di problema e la soluzione concettuale. Non e' specifica di nessun linguaggio.

#### Anti-Pattern
la denuncia di una soluzione sbagliata (che sembrava ragionevole) ad un problema, ovvero una cattiva soluzione

#### Idioma
pattern valido per un determinato linguaggio o paradigma di programmazione. E' una soluzione piu' azzeccata.

#### Meta Pattern
Come e' fatto un pattern?
- **Hook Method** (aggancio, uncino) metodo astratto che determina il comportamento specifico nelle sottoclassi
	- e' un punto caldo in cui si puo' intervenire per personalizzare, adattare lo schema
- **Template Method** metodo che coordina generalmente piu' hook method.
	- e' l'elemento freddo, l'elemento di invariabilita' del pattern

Come si relazionano hook e template?
- **Unification** stessa classe
- **Separation** classi separate
- **Connection or recursive connection** sono relazionate

## Gang of four (GoF) (23 design pattern)
Hanno stipulato dei pattern dopo la loro lunghissima esperienza in campo di sviluppo software. Sono stati pubblicati, si sono affermati.

Pattern divisi in **3 cateogrie**
- **CREAZIONALI** (creazione oggetti)
- **COMPORTAMENTALI** (interazione oggetti)
	- **Observer**

		update: parte calda (hook)
		notifyObservers: parte fredda (template)

		- problema

			relazione uno a molti con connessione lasca. Dipendenza da stato di un altro oggetto. Tanti osservatori, un osservato. Dinamicita': non e' deciso a compile time, durante il runtime si aggiungono observer e observed. A fronte di cambiamenti di stato cambia il comportamento.

			**NB**: In entrambe le modalita' (PUSH/PULL) c'e' sempre una dipendenza tra Observer e Observable. Questo perche', nel caso di PUSH, devo sapere in che ordine sono gli argomenti e di che tipo sono.

			- **modalita' PUSH**

				Quando l'observed cambia il suo stato, oltre a notificare del cambiamento, gli passa il dato aggiornato di quell'update. Problema: se l'aggiornamento non ti interessa oppure pesa (tanti giga)

			- **modalita' PULL**

				Quando l'observed cambia il suo stato, manda solo la notifica a tutti gli observer, senza dato. Se l'observer e' interessato all'aggiornamento, allora chiede esplicitamente il dato, tramite un getter, all'observed.
				- Problema: e' un pattern generico, non specifica il tipo di dato.
					- Soluzione1:
				- Problema: l'observer non conosce l'observed, ergo per fare la modalita' pull devo passare un riferimento di me stesso (observed) all'observer.
					- Soluzione1: update(this)
					- Soluzione2: cambio uml, dipendenza tra classi concrete per conoscere dei metodi (getState(), getTemp()...). Java adotta questa soluzione, ovvero ha due metodi notifyObservers: senza argomento e con Object arg. In questo modo posso passare un riferimento di me stesso all'observer per usare i metodi specifici dell'observed. C'e' una **dipendenza** tra due classi concrete. Cattivo design

			- **modalita' HYBRID**

				Quando l'observed cambia il suo stato, oltre a notificare del cambiamento, passa il dato piu' comune (quello piu' richiesto statisticamente). E' carico dell'observer chiedere qualcosa di piu' specifico o altri dati all'observed.

			- **Java version**

				Da vedere PDF.

	- **Strategy**
	- **Adapter**

		Comodo quando bisogna lavorare su codice di altri, su codice legacy e roba del genere. In questo modo si isolano i confini sconosciuti e ci si interfaccia con qualcosa che si conosce. 2 strategie:

		- **Object Adapter**

			Associazione. L'adapter sta implementando solamente l'interfaccia nuova, la parte vecchia la sta nascondendo. Il cliente infatti vuole usare quella nuova interfaccia. Creo il TargetInterface che il cliente vuole usare. Adapter lo implementa e la richiesta la rimappa su un oggetto da cui dipende: l'Adaptee (vecchio oggetto). Posso adattare una gerarchia di oggetti, quindi basta uno.

		- **Class Adapter**

			Generalizzazione (legacy). L'Adapter eredita dall'Adaptee, non lo contiene come nel caso di Object Adapter. Puo' rispondere sia ai vecchi metodi, sia ai nuovi metodi. E' sia un oggetto vecchio che un oggetto nuovo (adatto al porting, roba legacy). Sto ereditando da una specifica classe, per cui la gerarchia di Adaptee e' a me sconosciuta. Non conosco i figli, solo la classe padre.

- **STRUTTURALI** (composizione di classi e oggetti)
	- **Decorator (Wrapper)** (recursive connection in metapattern)

		- problema

			Aggiungere nuove funzionalita' o decorazioni dinamicamente. Non posso creare n! classi con tutte le combinazioni possibili di decorazioni, ma devo inventarmi un nuovo approccio.

			E' piu' snello a livello di numero di classi, ed e' facile da estendere, infatti rispetta l'Open Close Principle (aggiungo classi, non modifico quelle presenti)
