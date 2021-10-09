### Unified Process (UP)
Processo industriale, modello di sviluppo. (Rational UP, commerciale). Sono gli stessi guru che hanno fatto UML, e si sono dilagati nello scrivere anche un modello di processo di sviluppo.
Viene definito **sia sequenziale** (4 fasi svolte in sequenza), **sia iterativo** (ogni fase svolta in maniera iterativa), **sia incrementale** (rilasci successivi). Assurdo? Mira a far parlare di se, a vendersi. Nella vista generale infatti si puo' notare come molte fasi si sovrappongano, altre si ripetano e altre sono costanti. Le nuove fasi hanno nomi diversi per avere la liberta' di ridefinire quello che vorrei fare. Infatti non e' piu' una sequenza di fasi ma un workflow, non piu' separazioni tra attivita', ma cose da fare.
- FASI
	- **inception**: capire il problema, definirlo
	- **elaboration**: dettagliarlo, studiarlo nei particolarli
	- **construction**: costruzione
	- **transition**: integrazionne, installazione

E' una sorta del fallimennto dell'isolazione tra fasi. Non si riesce a separare delle fasi, come ad esempio i requisiti che evolvono, per cui questo processo va incontro a questa realta', ovvero che la fase di requisiti continua, anche se meno intensamente, anche dopo inception. Limita ma non vieta.
- SUGGERIMENTI (BEST PARCTICES)
	- sviluppare iterativamente
	- gestire i requisiti
	- usare architetture basate sui componenti
		- riuso dei componenti gia' esistenti e' una pratica vincente
	- creare modelli visivi del software
		- sono logorroici ma piu' estrosi, e' un guadagno a fine progetto
		- UML
	- verificare qualita' del software
		- approccio ingegneristico
	- controllare modifiche del software
		- essere capaci di tracciare l'evoluzione del software

- USE CASE DRIVEN (NON USER STORY DI XP/AGILE)
	- la definizione e negoziazione dei requisiti
		- use case UML, con casi eccezionali, input output, casistiche reali. Danno uno schema da seguire. Dal cliente allo sviluppatore
	- definizione dei test di accettazione
		- devi riprendere in mano questi USE CASE, che ti dice cosa deve testare, ti fai guidare da quello che e' stato definito concordatamente col cliente.
	- pianificazione dei rilasci
		- sempre le USE STORY mi guidano
	- le USE CASE sono in linguaggio naturale (flessibilita', documenti in evoluzione)
		- mi aiutano a ridefinire i requisiti. Va a dettagliare una USE CASE nei suoi sottocomponenti, quindi puo', da un concetto, specificare in modo dettagliato i suoi sottocomponenti coinvolti. Quando la USE CASE passa dal cliente allo sviluppatore, va a dettagliare il linguaggio naturale del cliente (esempio: il sistema. Cos'e' il sistema? Lo sviluppatore da un contesto informatico per tradurlo)

- CENTRATO SULL'ARCHITETTURA
	- La definizione dell'architettura applicativa e' riconosciuta come fase fondamentale
		- bisogna mettere al centro questa fase in tutto il processo, e' design oriented.
	- il suo consodilamento avviene solo dopo sperimentazioni della sua fattibilita'
	- la stima dei costi, tempi e rischi

- UP
	- e' considerato un framework di modelli, adattabile a varie situazioni
	- ne esiste una versione estesa: Enterprise
		- vengono aggiunte due fasi: **Production** (tutto quello che deve essere fatto una volta in produzione) e **Retirement** (dismissione, operazione di migrazione dati ecc...) che tengono conto dell'attivita' dopo la consegna
		- vengono aggiunte alcune attivita'
