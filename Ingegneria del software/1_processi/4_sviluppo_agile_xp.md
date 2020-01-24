### metodi agile (non e' un modello)
Funziona bene con poche persone (10). "Cerchiamo di rendere il luogo di lavoro un bell'ambiente dove si lavora e ci si diverte", per non fare scappare la gente.
mentre i precedenti metodi nascono in ambito accademico/industriale, questi metodi agile nascono dal basso, dai programmatori a disagio che vogliono una soluzione ai loro problemi ricorrenti. Persone diverse hanno elaborato idee simili e comuni, si sonno uniti: https://agilemanifesto.org/. Hanno trovato una buona ricetta dove i difetti di un ingrediente vengono compensati da un altro, e' un ottimo equilibrio. Gli ingredienti erano gia' presenti, sono stati amalgamati insieme.

Danno valore a:
- persone invece che al processo
- software funzionante invece che documentazione
	- misura di progresso del software sono le funzioni
- devo collaborare a fianco col cliente, win win ma senza illusione. Il cliente fa parte del team, infatti viene richiesto che un cliente rimanga a fianco durante lo sviluppo del software.
- rispondere ai cambiamenti invece che seguire un piano (impossibile congelare i requisiti)
- valore del team, che si **auto organizzano**
- coraggio, automiglioramento
	- bisogna saper comunicare in ambiente lavorativo
	- retrospettive: ci si ritrova e si parla di quello che e' stato fatto, per far emergere problemi, proporre soluzioni e predisporre soluzioni (evoluzione del processo stesso)
- problemi:
	- trovare soluzioni affidabili (non e' perfetto, non funziona sempre, non e' la soluzione a tutti i problemi)
		- non c'e' uno studio scientifico / esperimento di tutto
- Libro: Meyer: Agile (buono brutto cattivo). Non e' un libro solo sull'agile, ma analizza e critica concetti metodologici, su come parlare di un processo

#### 1. Lean Software
Nasce dalla Toyota, per **ridurre lo spreco**. Produco su ordinazione invece che sprecare, evita problemi di stoccaggio. Nel software:
- ritardare le scelte che ti bloccano
- iterazioni molto brevi
- autoorganizzazione

#### 2. Kanbam (lavagna)
**Ridurre il lavoro in esecuzione**. Si ha una lavagna dove tutto e' segnato
- minimizzare i context switch
- fare una cosa alla volta
	- non passo al prossimo lavoro finche' non finisco all'attuale
		- problema di dipendenza da altri componenti: devo fermarmi (servono task da mettere in coda)

#### 3. Scrum (mischia del rugby)
Si fa uno sprint tutti insieme per raggiungere un obiettivo in certi momenti. Come se si congelasse il mondo. E' un modo per rispondere alla volatilita' dei requisiti. Quindi **congelo i requisiti per un breve tempo/iterazione**, poi li risblocco. Voglio avere la garanzia di non essere rotto le scatole per TOT settimane. Mi faccio pagare a tempo, altrimenti vado in perdita. Ci si concentra sulla cosa piu' importante che e' piu' difficile che cambi, quindi sul core, per poi andare verso l'esterno, per rendere piu' improbabile l'incertezza. Sono le idee vaghe quelle che cambieranno quasi sicuramente, e saranno quelle sul quale mi concentrero' piu' tardi

#### 4. Crystal
**Comunicazione osmotica**: Il problema del lavoro nei team e' riuscirsi a coordinare. Il metodo usato fino ad ora e' erigere confini (modularizzazione, sottoinsiemi), comunicazione per separazione. Le singole persone devono avere conoscenza di tutto il software, devono lavorare come un uno. Sanno tutto, hanno gli stessi obiettivi, hanno la visione di insieme. Non lo posso fare su un team numeroso, ma su un team ristretto e affiatato. E' un ambiente di lavoro molto coeso (se si e' simpatici), molta condivisione. Tipo: azienda software con biliardo, piscina, videogames.

#### 5. E(X)treme (P)rogramming
**Incrementa e semplifica**: guida verso un design piu' semplice. E' un'attivita' di progettazione, di design. Voglio che mi porti verso la semplicita'. Questa **semplicita' deve emergere**. I test scritti vengono lasciati, e saranno utili quando modifichero' il software, nel test di integrazione/sistema. E' utile anche perche' mi metto nell'ottica del cliente. E' difficile trovare un punto di aggancio di un nuovo software, perche' non e' stato pensato per essere testato, mentre se sviluppo tramite il test, e' gia' stato fatto, pensato per essere testato parte per parte. Esistono figure professionali per dire come rendere testabile il software durante lo sviluppo, cambia il design del progetto al fine di essere testabile.
- **TEST-DRIVEN DEVELOPMENT (TDD)**: sviluppo guidato dal testing, dai comportamenti. Non promette il design migliore, ma il piu' semplice.
	- **TEST-FIRST**
		- Prima scrivo un test di un codice che non esiste. **DESCRIVI IL TUO OBIETTIVO**
	- **BABY-STEP**
		- Poi faccio il codice per raggiungere la mia soluzione.

	1. Scrivo test che fallisce
	1. Fallo passare, **velocemente**
	1. Refactor, rifattorizzazione, riscrivi/cambia/riprogetta il codice senza cambiare gli aspetti esterni (i risultati), quindi migliora a parita' di funzionalita'

	Prima aggiungo una nuova feature e poi la miglioro. Per feature intendo una piccola funzionalita' (2-10 min). Tipo codice che si ripete (aggiungo funzione), strutture dati che hanno comportamenti comuni (creo classe/interfaccia)
	Kata: ripetere le stesse cose leggermente diverse, buon allenamento mentale (dalle arti marziali). Ho un continuo feedback.

### Extreme Programming
- portata
	- la quantita' di funzionalita' che si vogliono implementare
		- delicata perche' mutevole, ed e' uno dei problemi principali per cui si dedica l'XP (volatilita' dei requisiti)
- tempo
	- difficile da stimare, tempo da dedicare al progetto
- qualita'
	- manutenibilita', correttezza
- costo
	- le risorse finanziarie allocabili

Quello che dice l'XP e' che non e' possibile accontentare tutte e 4 le variabili, per cui ci si occupa di puntare a 3 variabili e la 4a va calcolata in base a quello, sono correlate e interdipendenti. Non esiste una formula precisa che da risultati precisi, sono stime. **Qualita' e' la costante**, massima qualita', e' la priorita' a cui non posso abbassarmi. Non c'e' nessuna garanzia su quello che riesco a darti, perche' le cose cambiano, evolvono continuamente. Difficile vendere il tempo perche' non sai quanto effettivamente ci metterai. Infatti nei contratti di solito si parla di prodotto finito. Si lavora insieme al cliente per andare nella direzione giusta. **Collaborazione invece che contrattazione**.

- PRINCIPI
	- feedback rapido
		- consegno qualcosa ma voglio sapere se e' quello che il cliente voleva
	- presumere la semplicita'
		- nell'ingegneria del software classica, design for change: devo predisporre il mio software al cambiamento, devo tenerlo a mente durante la progettazione, perche' il costo delle modifiche aumentera' all'aumentare dell'avanzamento del progetto (esponenzialmente, secondo esperimenti). I cambiamenti possibili sono infiniti. Ma nella realta' tutti gli agganci creati per le modifiche non vengono mai usati, perche' il cliente ne vorra' tutt'altre. E' pericoloso basarsi su un'idea mentale senza basi empiriche.
		- **non progettare presumendo un cambiamento in futuro**, per il riuso, perche' secondo XP il costo di cambiamenti e' una curva logaritmica, non esponenziale. Questo perche' secondo XP, con tutta la disciplina acquisita (design semplice, organizzazione, codice snello e semplice) che non era assodata nel 1970, e' uguale fare un cambiamento prima o dopo.
			- Leprechauns, analizzo' i progetti e si accorse che il campione era piccolo e i progetti molto piccoli.
		- introduzione errori: a ogni momento di possibile inserimento degli errori corrisponde una sua curva specifica, non cresce tutto uguale ed esponenzialmente.
	- accettare il cambiamento, ovvero che il cliente cambia requisiti e richieste personali. Tra le soluzioni equivalenti, scelgo quella che mi lascia piu' strade aperte
	- modifica incrementale
		- le modifiche vanno effettuate a piccoli stadi
			- si applica al progetto, piano di lavoro, team...
		- il piu' grande degli errori nei team di sviluppo e' aggiungere una persona (assumere un nuovo sviluppatore). Invece che produrre di piu', cala la produttivita' perche' ho persone schierate a insegnare al nuovo arrivato. **non cambiare team durante lo sviluppo**
	- lavoro di qualita'
		- punto di vista psicologico: se voglio che il programmatore diventi uno fidato che sviluppi bene, devo coccolarlo, deve essere soddisfatto di quello che fa e di dove lavora

FIGURE IN GIOCO
- manager (e/o cliente)
	- responsabili di decidere la portata del progetto, decide cosa viene sviluppato in ogni iterazione
		- cosa fare prima del prossimo rilascio
	- priorita' delle funzionalita' (dettate dal cliente), ovvero valore delle funzionalita', fare prima quelle che interessano al cliente
	- date di rilascio (2 settimane, ma non sempre) e' un perido corto: freeze and develop. Ogni tot si congelano i requisiti. Buon compromesso per la soddisfazione tra cliente e sviluppatori. Abbastanza lungo per consegnare qualcosa, non troppo corto per collassare
- tecnico
	- ha la responsabilita' di decidere
	- deve fare le stime dei tempi delle singole funzionalita'. Questo perche' deve essere lo sviluppatore stesso a sapere (dato che e' il suo lavoro ed ha esperienza) quanto ci vuole a fare tot cose. Responsabilita' del team. Toglie attriti, stress.
	- conseguenze di scelte tecnologiche
	- processo: liberta' di scelta di cosa fare
	- pianificazione dettagliata: quello che devo fare prima, tutto autogestito secondo scelte (sempre responsabilizzazione)

DIRITTO
- manager e customer
	- sapere cosa puo' essere fatto, in quanto tempo e con quale costo
	- vedere progressi nel sistema, provati dal superamento di test decisi dal cliente.
	- cambiare idea, cambiare funzionalita' o priorita' (ogni 2 sett.)
- degli sviluppatori
	- requisiti chiari, dichiarazione della priorita' (**storie d'uso**), chiedo degli esempi d'uso al cliente, cosi' riesco a dedurre senza che il cliente specifichi tutto
	- dire quanto serve a implementare una cosa.
		- e' il team in accordo che decide le stime di quanto ci si mette a fare una cosa.

APPROCCIO:
miscelazione di ingredienti, che sono come molle coese tra di loro, come una sfera. Ha un suo equilibrio, per cui ne collassa ne esplode.

- **1. PLANNING GAME**
	- manager, client e sviluppatori si riuniscono per pianificare. Non sempre trovo un compromesso o una comunicazione buona. Bisogna vedere chi c'e' dall'altra parte. Vengono determinate le funzionalita' da inserire nel prossimo rilascio, combinando priorita' commerciali e valutazioni tecniche.
	- ogni richiesta ha un peso
	- fasi
		1. il cliente scrive delle user story su un pezzo di carta
			- CARTE (dal cliente):
				- identificatore
				- frase che dice lo scenario
				- test di accettazione
				- valore (priorita', importanza)
				- **criticita'** (aggiunta dal team)

			Gli sviluppatori guardano le carte e valutano quanto ci metterebbero a sviluppare tale use-case. Devono decidere in gruppo. Attenzione ai pericoli:
				- effetto ancora (meccanismo umano psicologico)
					- risolvo facendo la stima in modo indipendente, poi si girano le carte e si fa la media
				- comunicazione: bisogna ridurre: prendo i casi limite (stima piu' alta e piu bassa) e li si fa discutere, esponendo il perche' della loro stima cosi' scostante. Si ripete il processo di **poker**. In questo modo non si perde tempo, molto efficiente. Chiunque del team si deve vedere in quella misura, cioe' tutti devono potersi riconoscere nella stima

			Alla fine bisogna trovare una soluzione anche nei casi piu' ostili, come per esempio:
				- stime tutte differenti: si chiede al cliente perche'
				- stime tutte alte: si va verso lo **split della storia**. Ovvero vado dal cliente e la divido. Glielo dico al cliente per fargli capire il perche'. Questo corrisponde a un'altra **criticita'**. Bisogna segnalare al cliente queste cose che il cliente non coglie. **Le cose critiche vanno sviluppate subito**.

			**IL CLIENTE DECIDE QUALI SCHEDE VERRANNO IMPLEMENTATE ALLA PROSSIMA ITERAZIONE**

		1. versione semplicifata informale degli Use Case di UML
		1. si fanno 3 fasi cicliche
			1. esplorazione: scoprire cose nuove che potrebbe fare il sistema
			1. impegno: si decide quale sottoinsieme possibile dei requisiti da realizzare nella fase (in base alle stime, potenza di fuoco del team)
				- Non e' facile da misurare la potenza di fuoco, per esempio non so gli imprevisti, le interruzioni che rallentano
					- prassi: si ragiona in unita' di misura ideale (non 30 minuti, ma 30 minuti di sviluppo, **POMODORO**)
					- esempio Ferrari: a rotazione una persona del team si occupava (vittima sacrificale) di tutte le interruzioni come chiamate, email ecc... per non avere interruzioni
			1. gestione: si fanno delle correzioni sulle stime in base a esperienze pregresse. Si usa il **tracker** (che traccia di settimana in settimana, sceglie grafico, organizza dati) per capire la possibile evoluzione. Viene usato in ogni planning game per correggere gittata
				- identifica cose pericolose
				- ti dice l'andamento attuale del team

			Questa gestione viene ricalibrata anche in base al numero di storie svolte nell'iterazione precedente, per calibrare il prossimo tiro. Devo usare lo stesso metodo di pensiero (pomodori esempio). In questo modo mi automiglioro e vado a stimare molto meglio

- **2. BREVI CICLI DI RILASCIO**
	- per ridurre i rischi, la vita e lo sviluppo. In questo modo riesco a prendere la direzione giusta fin da subito, feedback rapido per non deviare. Ma devono essere **rilasci significativi, sensati**. Responsabilita' del management. Sono sicuro che le cose piu' importanti vengano consegnate.

- **3. METAFORA**
difetto dell'XP: non da una visione d'insieme, si concentra sulle singole storie e non sono chiare le dipendenze tra una e l'altra. Risposta XP: quando parliamo col cliente non usiamo un linguaggio tecnico, suggeriscono di usare una metafora/similitudine per descrivere il sistema. Faccio un mapping tra metafora e sistema. Permette inoltre di scoprire dei concetti, tipo concetto di tronco, tana del picchio: esiste qualcosa nella realta' che rappresenta questa?
Nella realta: Difficile, fatte malissimo. Dovrebbe fare da **vista aggregata**, per capire relazioni.

- **4. SEMPLICITA' DI PROGETTO**
Scrivi una volta sola le cose, niente ripetizioni (si ricollega al refactoring), poche classi, poche interfacce, pulito. KISS. La fatica che richiede e' molto minore rispetto ai progetti piu' complessi. E' piu' facile da capire, da mantenere, da aggiungere feature. Nel design for change (opposto) e' tutto stile plugin

- **5. TESTING**
Pervasivo. Il cliente deve specificare i test funzionali e di accettazione, per aumentare la loro fiducia nel programma. I programmatori scrivono i test di unita' perche' aumenta la fiducia nel codice. Diventano parte del programma stesso. Il fatto di poter dire che i test passano anche dopo aver effettuato delle modifiche ai miei moduli e a quelli altrui, mi da fiducia che non abbia bacato il software (non dimostrera' mai la correttezza, non vuol dire che ho fatto qualcosa di corretto, ma ne aumenta la fiducia). Si ha paura di rovinare quello che funziona.

- **6. REFACTORING**
Non bisogna aver paura di fare modifiche che semplifichino il progetto, o che rendano l'aggiunta di una funzionalita' piu' semplice. Cio che mi permette di mantenere pulito il software nonostante le modifiche e l'avanzare del tempo. Non devo dedicare tempo a capire come mettere mano al codice anche a distanza di anni e anni.

- **7. PROGRAMMAZIONE A COPPIE**
Non dimezza la produttivita' ma le persone che scrivono codice. Aiuta ad avere un controllo continuo del rispetto delle regole dell'XP. Le linee di codice del singolo vanno riviste e ritestate e controllate a fronte di errori. 2 persone scrivono codice come 1.5 persone. Alla fine e' risultato in piu' esperimenti che la produttivita' e' migliore nel pair programming. Ci si controlla a vicenda, ci si impone le regole (tipo scrittura pulita di codice). Ci si divide i ruoli. Come nel rally: uno guida, l'altro fa da navigatore. Puo' parallelamente pensare in avanti, pensare gia' al refactoring. Le coppie cambiano continuamente. E' piu' facile l'inserimento del personale, viene formato molto piu' velocemente, gli si toglie la responsabilita', lavorando di fianco a uno gia' nel processo impara molto di piu' e inizia a entrare nell'ottica. Sinergico.

- **8. PROPRIETA' COLLETTIVA** (ego-less programming)
In microsoft: a ognuno viene assognata la responsabilita' di tot righe di codice, lui sara' l'unico responsabile a toccare quelle determinate righe di codice. In XP: tutti sono responsabili e devono essere intercambiabili, possono cambiare tutto il codice che vogliono a patto che i test ripassino tutti. Non esiste un proprietario o un responsabile. Non e' tempo perso toccare codice di altre persone (refactoring). Coppie dinamiche: mi metto di fianco a qualcuno che nel breve termine ha toccato il codice.

- **9. INTEGRAZIONE CONTINUA**
lo sviluppo della storia finisce quando quel componente e' integrato nel sistema che sto per consegnare. Viene presa un'unica macchina con la versione attuale allo stato dell'arte del software, pronto per la prossima iterazione, sul quale bisogna essere responsabili della propria parte di codice. Bisogna essere responsabili del proprio codice. Una coppia alla volta finisce il proprio lavoro e va verso questa macchina a fare i test di integrazione per integrare quel pezzo di codice. Una coppia alla volta, sequenzializzazione del parallelo. Una singola macchina in mutua esclusione. In questo modo ho feedback rapido. Lo sviluppatore non e' piu' responsabile solo dei test di unita' ma anche dei test di integrazione.

- **10. SETTIMANA DI 40 ORE** (5 giorni x 8 ore)
La programmazione e' un lavoro faticoso, mi puo' rendere inefficiente lungo l'arco della settimana. Bisogna sempre essere svegli per poter fare questo lavoro, non esiste un momento di leggerezza o relax. Ogni volta che metto le mani su tastiera sono in una full-immersion. Non e' normale ne produttivo fare straordinari. Freschezza del team.

- **11. CLIENTE SUL POSTO**
Il cliente e' parte del team. Se il cliente lasciasse solo i requisiti nero su bianco, se trovo delle ambiguita' non posso chiedergli di persona i problemi, dovrei tartassarlo di chiamate. Il mezzo remoto non funziona. Se voglio fare velocemente la fase di raccolta e analisi requisiti, necessito di un diretto interessaato. Il committente lo vede come una risorsa strappata alla propria azienda. Fase di specifica leggera. Se il cliente fa parte del team, puo' vedere che il team lavora. Discorso di fiducia. C'e' un problema di rappresentazione di tutti gli stakeholders, chi usera' il software. Una persona deve saper tutto.

- **12. STANDARD DI CODIFICA**
Tipo per sintassi del codice. Convenzione sui nomi delle funzioni, nome dei parametri, numero, design pattern esplicitati, commenti. Steso modo di procedere. Enfatizza comunicazione, agevola refactoring.

FINE VERSIONE XP 1

- **13. JUST RULES**
Sono solo regole, non prenderle troppo sul serio, sono spunti di riflessione. Rischio di togliere ingredienti che fanno da molla o paraurti per un difetto di un altro ingrediente.

FINE XP 2

Ma il resto? Come vengono raggruppate le fasi importanti degli altri modelli?
- Requisiti
	- gli utenti fanno parte (lavorano con il) team di sviluppo
	- consegne incrementali e pianificazioni continue
- Design
	- una metafora come architettura del sistema
	- refactoring verso il design piu' semplice e migliore
	- semplicita'
- Codifica (programmazione)
	- a coppie
	- proprieta' collettiva
	- integrazioni continue
	- standard codifica
- Test
	- test di unita' continuo (test prima del codice, dell'implementazione)
	- test di integrazione dello sviluppatore
	- test funzionale scritto dal cliente

E la documentazione? Nope.

- le schede dei casi d'uso (scritte dai clienti)
	- linguaggio naturale
- schede di progrettazione
	- CRC (schede didattiche)

Ma la vera documentazione?

- nel codice. Devo scrivere codice cosi' chiaro che e' semplice e si capisce
	- gli standard semplificano la leggibilita'
	- **i TEST sono la vera documentazione del software (test di unita')**
		- quando scrivo un test prima del codice: Mi aspetto che chiamando questo ottengo questo. E' descrittivo, parla da se di cosa si aspetta del software
			- la differenza tra documentazione scritta (requisiti scritti) e domentazione nel codice (test) e' che il codice e' eseguibile, esiste sempre, mentre nella scritta, se non rispetto piu' la documentazione nessuno me lo dice, non posso saperlo, si crea discostamento.
- nelle persone
	- il cliente
	- compagno di pair programming

### Quando NON si puo' applicare XP
- qualunque ambiente che proibisce anche solo uno degli approcci dell'XP
	- barriere tecnologiche che mi impediscono di testare e avere feedback rapido (esempio, supercomputer che non ho a disposizione), ovvero **non posso eseguire i test velocemente, ritestare il sistema**
		- non posso avere un approccio incrementale (centrale nucleare). Ovvero programmi monolitici, atomici, che devono essere consegnati tutt'uno (viaggi spaziali esempio)
		- niente feedback rapido
	- barriere manageriali/burocratici
		- il team diviso per aspetti, a livello di piano e di edificio diverso (databesisti, progettisti, sistemisti ecc...)
		- team molto numeroso
		- necessita' della documentazione per certificazione o standardizzazione (ISO) tipo sicurezza. Per queste certificazioni serve la documentazione del processo
			- posso fare una use story che dice: scrivi la documentazione ad hoc del progetto
	- barriere fisico/logistico (non ho openspace)
		- spazi di lavoro divisi fisicamente.
	- troppi stakeholders, una persona sul posto non basta
	- sistemi realtime/simulazione: non posso testare sul posto di produzione

### Critiche (Meyer)
- svalutazione up-front (quello che faccio prima di partire), quindi mancanza di architettura generale di partenza. (PROF: Anche se: mi complico le strutture dati oltre quello che sarebbe ragionevole)
- sopravvalutazione user story (**si delega al singolo la generalizzazione**, ovvero l'interpretazione in progetto di una frase informale del cliente)
- mancata evidenziazione **dipendenze** tra user story
	- anche se nei team si puo' scrivere sulle user story: depends on...
	- quando ci sono delle interazioni strette tra una e l'altra
		- bisogna avere l'accortezza di non dare 2 story intersecate contemporaneamente a 2 persone diverse (conflitti)
- TDD porta a visione troppo ristretta
	- "ho trovato una soluzione che risolveva tutti i problemi, ho dovuto cancellare tutto quello che ho fatto prima"
	- puo' accadere. PROF: Ma anche se dovessi cambiare tutto, ho ancora i test, gia' scriti, che valideranno la soluzione nuova. Non e' tempo perso, ho una rete di salvezza
- Cross functional teams
	- Non esiste un team full-stack, che sappia affrontare tutti i problemi dal basso all'alto (che sa tutto), ma e' quello che vuole XP.
		- PROF: il piu' esperto prende le storie per cui e' esperto
		- PROF: e' una cosa storica
	- Negli ambienti specialistici e' vero, non puo' funzionare
- non tutto e' divisibile in step incrementali
