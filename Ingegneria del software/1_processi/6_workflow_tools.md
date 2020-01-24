#### Scenari
git puo' essere usato in diverse maniere, e' molto flessibile.
- **solo**
	- lo uso per conto mio, per tutti i miei progettini, per fare backup, per tutti i documenti
- **partner**
	- abbiamo un punto centralizzato su cui fare riferimento. Tipo coffee shop: ci vediamo al bar e ci scambiamo le idee. Per avere una nomenclatura ufficiale (versione, hash ecc...) viene usato git per automatizzare la cosa.
- **centralizzato**
	- abbiamo un repository centrale
- **centralizzaato con local commits**
- **decentralizzato con shared mainline**
- **decentralizzato con "guardiano"**
	- controllo del commit, o da un umano, o automatico (viene ricontrollato lo stato, vengono rieseguiti tutti i test, viene lanciato su macchine diverse, viene rifiutato o accettato automaticamente con segnalazione)
- **gerarchico**
	- tipo linux, dove Torvalds e' in cima alla piramide e gerarchicamente, partendo dal basso, le modifiche richieste arrivano all'autore in passaggi successivi (sviluppatori, sviluppatori fidati, cocapi, capo)

#### Possibili workflow di git
git e' un coltellino svizzero, non c'e' scritto come deve essere usato
- piccolo (per coordinare 20, 30 persone massimo)
	- **gitflow** (git wrapper)

	ha costruito dei comandi di alto livello per disciplinarre lo sviluppo, mi forzano. Differenzia i tipi di branch, ha nuove operazioni guidate e traccia anche i remote. E' una versione molto piu' disciplinata di git. Ogni branch ha un suo compito, e' differenziato dall'altro. Ogni volta che faccio una **feature** devo partire da una fase (branch) **develop**: non posso innestare feature su feature. Ogni feature parte dal ramo develop, si apre e si richiude, e poi si passa alla prossima. Il ramo della **release** congela le feature per pubblicarle ufficialmente.

- grande:
	- **pull request**

	sono dei siti su cui ci si collega per fare lavori a coppie. Non esiste il comando git fork, e' qualcosa del sito web di hosting, come la pull-request. L'idea e' di sottoporre qualcosa di nuovo (figlio) e voglio sottoporla al master (padre). Ovvero io, sviluppatore, voglio contribuire. Allora forko il progetto e contribuisco. Per sottoporre la mia richiesta faccio una pull-request. Ha vita solo sul sito di hosting. Si possono aprire delle discussioni. E' meglio fare piu' pull request che una pull request con 300 commit. **Rendere noto, discutere, e applicare la modifica**. Sono importanti anche i build automation, che ogni volta che viene proposta una modifica da una pull request vengono rilanciati tutti i test.

	- **gerrit**

	Ci sono dei team talmente grandi che non puo' essere gestita da un'unica persona, non puo' esserci una sola persona dietro migliaia di pull request ogni giorno, tra modifiche e patch. L'idea di gerrit e' una **peer review**, ovvero viene distribuita la moderazione. Non e' facile perche' bisogna trovare delle persone fidate. Per questo motivo viene introdotto il concetto di **voto**, dove si vota per decidere, e si approva solo se si e' raggiunta una maggioranza o un tot di persone. Posso avere gruppi diversi che testano precise cose, come interfaccia, come pulizia, architettura ecc... Definisco le categorie votanti e voti per ogni categoria. Gerrit ha bisogno di **2 server git**.
		1. server git dove si fetcha, versione ufficiale (pull)
		2. server git dove vengono effettuati i test di integrazione per le nuove proposte, aka pull request (push)

	Ogni cambiamento deve essere contenuto in un singolo commit, non piu' in una pull request. L'idea e' di minimizzare la granularita' delle singole richieste di modifica. L'idea e' puramente di efficienza, ovvero se faccio modifiche per piccoli step, l'architettura sotto non dovrebbe cambiare tra un test e l'altro. **commit = change**. Commit fatto su un ramo virtuale. Non e' piu' un commit in senso storico, un cammino, ma ogni commit (change) ha un changeID per tracciare la lista dei cambiamenti.
		- Code Review: recensisce il codice
		- Verifier: controlla la semantica, perche' sono passati i test, se il cambiamento e' significativo

	Se intanto che sto integrando un change ne arriva un altro e viene integrato, devo riprovare a fare tutti i test e le review. Se qualcosa va in conflitto devo chiedere all'autore del change di rivedere il suo change per sopperire ai problemi della nuova versione. Non compila piu' = responsabilita' dell'autore.

#### Build automation tool
- come proteggersi da checkin di una versione non funzionante?

	Nel modello classico, si possono fare commit di qualcosa di errato, che non compila o che non supera i test. Questi tool permettono di prevenire tale cosa, ovvero viene accettato un commit solamente se e' tutto corretto. Nel mio local space puo' essere corretto, ma se lascio qualcosa nel push, ovvero se non permetto al repo di avere tutto quello che ho fatto, chi fa i successivi pull crasha.

	- automatizza ricompilazione e testing
	- molti tool disponibili
		- ```$ make```

		tool di basso livello, definisce una serie di dipendenze. Problema: se cambia il progetto, il nome del file o qualsiasi altra cosa, devo ricambiare il make per ricompilare tutto. Molto debole. Machine oriented: i path sono hard-wired. E' troppo dipendente dalla macchina (ricerca dipendenze). Ragiona sulla data di compilazione, sulle parti compilate. In questo modo, a ogni integrazione di codice nuovo, non mi tocca ricompilare ogni singola cosa del mio progetto, ma target specifici. Mi permette di creare delle regole.
			- Differenze tra macchina e macchina (hanno x libreria con y funzione)
			- Automake, autoconf, imake

		Il loro intento era quello di dichiarare le dipendenze.

		- Ant

		Targettato per progetti Java. La gestione delle dipendenze non era affidabile, tutto il resto era buono. Nasce per il progetto Tomcat, scritto in Java per progetti Java. Fa un update automatico per le dipendenze.
			- non solo compilazione: Test e deploy.
			- in formato XML (poco leggibile ma descrittivo)
			- contiene un project
				- da costruire, testare e installare
			- grandi progetto possono essere composti
				- ogni subproject ha il suo build file
					- ogni progetto contiene piu' target
						- compiling, deploy
					- i target possono avere dipendenze da altri

		- Maven

		Tool complesso ma molto potente. Specifica l'esatta versione delle librerie e in generale delle dipendenze. Fa l'autofetch. L'idea e' quella di avere programmi indipendenti, infatti riscarica le dipendenze nelle directory anche se presenti nel pc. Non e' molto efficiente, ma assicura l'isolamento.

		- Gradle

		Ci da una nuova sintassi (un DSL) per permetterci di operare secondo un nostro linguaggio.
			- Groovy language
			- plugin: aggiungono dei plugin per aggiungere delle sintassi, dei modi di comunicare col programma. Esempio: compilatore java. L'abilita' di fare cose, come compilare il codice java, viene aggiunto tramite plugin (plugin: java). Esempio: jacoco per il test di copertura delle righe di codice.
			- dipendenze: specifico una precisa versione o un >=.

		L'idea e' quella di avere una convenzione, ovvero quello che non specifico ha un comportamento di default. Se non dico nulla assume che tutti i file sono contenuti nella cartella dove lo eseguo. E' molto leggibile.


Nei progetti opensource esiste la night compilation, ovvero viene ricompilato tutto il progetto a mezzanotte per avere la certezza di avere una versione fresh. Posso lanciare parallelamente test su macchine diverse (windows, linux) oppure posso distrubire il carico dei singoli test su piu' macchine.

#### Bug tracking systems
tiene traccia e gestisce tutte le segnalazioni sui difetti di un software. Ha un database dei bug, ha un mezzo di comunicazione per la segnalazione degli stessi, ed e' anche uno strumento per assegnare compiti.
- Vengono coordinati gli sforzi per la soluzione del bug: una volta comunicato il bug, viene continuata la conversazione, dicendo quando e' stata presa in carico, se sono state assegnate risorse per la risoluzione, e la sua eventuale toppa. Non me ne faccio nulla se mi arriva una mail che dice "il mio programma ha crashato".
- Nella segnalazione del bug devono essere sottomesse delle informazioni riguardo l'esecuzione che ha portato al bug/crash, tipo variabili di ambiente, screenshot, dump ecc...
- Limitare il contesto di esecuzione in modo di sapere a quali file assegnare la colpa, e quindi quali file devo aprire per primi per cercare gli errori.

	- Mantis

	Si possono chiudere degli issue perche' possono essere dei duplicati, il problema puo' non essere replicabile. Stato bug: {open, closed}. Quando e' stato confermato un bug (open) lo assegno a qualcuno, oppure se e' opensource si aspetta, nella speranza che qualcuno lo prenda in carico. Alcuni di questi passaggi possono corrispondere a cose fatte sul repository: esempio commit "fixed #2456", ovvero segnala automaticamente che ho fixato un bug tramite bugID.

Ma e' semplice installare tutta questa roba? Non ce n'e' bisogno, perche' molti siti hanno questa feature di bugtracking e discussione. Continuous integration and report
