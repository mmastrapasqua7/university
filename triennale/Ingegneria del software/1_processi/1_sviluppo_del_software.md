### Problemi del software
- **numero e tipi di persone:** e' un problema di comunicazione perche' il programmatore non e' cliente del software. I clienti possono dare per scontato delle conoscenze che noi informatici non sappiamo
- **dimensione del software:**
	- ampiezza: quanto e' grande il software
	- tempo: quanto ci ho messo a farlo (tempo-uomo). Non e' lineare, nel senso che non ci metto meno tempo se impiego piu' persone. Tempo di comunicazione, sincronizzazione. (ATM: 150 anni/uomo, SHUTTLE: 22k anni/uomo)
- **soft:** e' facile da modificare. Un cambiamento puo' storpiare l'intero progetto. Evoluzione e versioni. E' un problema gestire tutti i dialetti, tutte le modifiche di piccole variazioni e poterle evolvere parallelamente. Tante coniugazioni difficili da gestire

### Processo di sviluppo di un software
processo che mi porta a un software (prodotto) di **QUALITA'**
- **QUALITA' DI UN SOFTWARE (cos'e' la qualita del software?)** che il software funzioni, sia bello, mi faccia diventare ricco
	- che **funzioni** (proprieta' esterna, visibile al cliente):
		- che funziona (**correttezza**): quello che ci e' stato richiesto di fare. Ci vengono dati dei requisiti (bisogni, richieste del cliente) che vengono tradotti nelle specifiche. Un software e' corretto se corrisponde alle specifiche. (right things vs. things right)
		- che mi posso fidare (**affidabilita'**): rispecchia le aspettative del cliente? Il cliente ha avuto cio' che voleva? Si fida? Va tutto misurato rispetto al cliente, che e' il termine di paragone
		> *un software puo' essere non corretto ma affidabile*
		>> esempio: riserva benzina: piu' riserva di quanto specificato, sempre affidabile ma non corretto

		- che non fa male: qualsiasi cosa succeda non va in uno stato insicuro (**safety**). Mentre per **robustezza** vuol dire che va oltre le specifiche: cose non previste vengono anticipate (gestione errori, input inaspettati ecc...). Attenzione: deviare dalle specifiche puo' fare bene o anche malissimo. Bella immagine vs. cazzi amari. Mirare alla soddisfazione del cliente, attenti agli avari.
		> LAW 1: assenza di requisiti e' la prima fonte di fallimento dei progetti

	- che sia **bello** (proprieta' esterna): puo essere sia interno che esterno.
		- che sia facile e intuitivo (**usabilita'**): bisogna stabilire la categoria di utenti a cui andra' il software. Adattabilita' a metodi di interazione diversi. Come sapere qual'e il piu' usabile? Test: do dei task da svolgere a 2 team usando 2 o piu' versioni diverse. Vedo il rate di successo, il tempo, frequenza errori, eye tracking
		> LAW 26: l'usabilita' e' quantificabile

		- che sia veloce (**efficienza**): tempo, uso risorse. 3 approcci per misurare la velocita':
			- empirica, profiling (trovo collo bottiglia)
			- complessita' algoritmo
			- simulazione (vedo le code)
		- che sia **pulito**: anche dopo la manutenzione e l'aggiornamento deve rimanere tale
			- verificabilita': quando e' tutto ordinato. E' facile da testare e verificarne la correttezza.

	- che mi faccia **diventare ricco**:
		- **riusabilita' componenti**: non reinventare la ruota, fare una cosa una volta ma riutilizzarlo per futuri progetti o clienti diversi
			- maggiore affidabilita': viene testato nel tempo, sia dal cliente sia dall'azienda. Si vede come invecchia (bene o male). Ma servono delle CONDIZIONI DI RIUTILIZZO
		> LAW 15: riuso del software riduce fasi temporali e incrementa produttivita' e qualita'

		> ATTENZIONE: Arian 5 (software riutilizzato dall'Arian 4)

		- semplificare **interventi post-consegna**:
			- **manutenibilita'**: per questa proprieta' serve anche la proprieta' dell'**accessibilita'**: deve essere abbastanza modulare da permettermi di aprire solo pochi componenti e non tutto l'intero software
				- **riparabilita'**: correggere gli errori
				- **evolvibilita'**: facilita' di adattamento a situazioni diverse da quelle di partenza
				- **adattamento a nuove situazioni**: nuove requisiti/specifiche
				> LAW 27: un sistema cambiera'.

				> LAW 27: un sistema che evolve incrementa la complessita', a meno di uno sforzo esplicito (refactoring)

- **QUALITA' DI UN PROCESSO DI SVILUPPO (cos'e' la qualita' di un processo? come deve essere un processo?)**
	- resistenza agli imprevisti (**robustezza**):
		- il cliente non sa come approcciarsi all'automazione, campo nuovo, non sa cosa vuole. Serve sapersi adattare col tempo (motivazione dietro AGILE) ai continui cambiamenti da parte degli interessati riguardo i requisiti richiesti. Cambio idea ogni settimana
		- il capo o un dipendente si licenzia
	- velocita' (**produttivita'**): il tempo degli sviluppatori che pago deve essere sfruttato al massimo nel modo migliore (strumenti a disposizione, burocrazia, chiarezza...). Non basta dire LoC/h.
	- cogliere l'attimo (**tempismo**): arrivare al momento giusto a un'idea e' meglio che averla sviluppata perfettamente ma non in tempo (dopo gli altri). Esempio: bando pubblico per compilatore Ada-Lang. La gente apprezza la parte consegnata, anche se incompleta, e poi la miglioro e la completo
	> *done is better than perfect*

---

L'ingegneria del software nasce perche', nel corso del tempo, viene riconosciuto il fatto che produrre software ha bisogno di linee guida e disciplina, proprio come in tutte le branche di ingegneria. In particolare, viene riconosciuto che:
- produrre software non e' solo scrivere codice
- bisogna risolvere il piu' grande dei problemi: **comunicazione** con chi non e' informatico
- bisogna essere **rigorosi**. Attenzione: non formale, e' una cosa diversa. Non e' certo ne provato che i metodi formali durante la progettazione eliminino gli errori di progettazione. Anche perche' piu' tardi correggo un errore durante la fase di sviluppo, piu' costosa sara' l'operazione in termini di tempo (quindi economico)
- tanti aspetti da considerare, uno alla volta. Tante cose possono essere sviluppate in tempi diversi da persone diverse. Tipo eccezioni, ottimizzazioni, aspetti diversi del problema. Questo porta anche alla pluralita' dei linguaggi e pluralita' dei diagrammi (uml, diverse viste dello stesso software, statiche o dinamiche)
