## ciclo di vita
Bisogna stabilire l'ordine in cui devono essere svolte le attivita' elencate precedentemente. La prima soluzione intuitiva e' quella di farle nell'ordine in cui le ho elencate. Questo e' il cosiddetto:

### modello
- ti prescrive come agire, fa delle semplificazioni.
- ti descrive come affrontare alcuni aspetti della produzione del software. Possono essere usati anche per scopi didattici per rimarcare certi aspetti (es. modello a cascata)

### modello a cascata
Posso solo scendere, passare a fase successiva, come l'acqua che scorre solo in una direzione (forzata). Nasce nella guerra fredda, dove si sviluppano grossi software militari. Software SAGE rimasto in servizio 30 anni (difesa missilistica aerea). In questo modello il punto focale e' la **documentazione**: mezzo di comunicazione. Anche se in realta' non e' davvero rigido
- e' una famiglia di processi che hanno in comune sequenzialita' rigida senza retroazioni
- ho un semielaborato pronto dopo ogni fase, che sara' il punto di partenza nello step successivo. C'e' anche suddivisione ruoli/responsabilita' nel tempo, data la "catena di montaggio"
- le varie fasi comunicano attraverso semilavorati
- e' possibile fare monitoring progressi e pianificazione di tempi
	- a senso unico
- problemi
	- **rigidita'** non puoi capire l'errore finche' non lo commetti (wicked problem). Per sopperire al problema e' stato inventato il modello a **prototipazione**
		- non posso tornare indietro se mi accorgo di un errore, di un requisito non specificato, di un errore non rilevato. Non possono esistere deviazioni. **monodirezionale**. Bisogna tenere a mente che la comunicazione e' diversa tra le varie parti, per cui e' impossibile che fin dall'inizio tutti concordino e abbiano la stessa visione del sistema
			- una volta i clienti erano i programmatori stessi, per cui sapevano cosa volevano fin dall'inizio
	- **congelamento prodotti**:
		- si fanno stime ma le tecnologie possono cambiare
	- **monoliticita'**:
		- tutta la pianificazione e' orientata al rilascio singolo. Tipo la tesi: serve costanemente confrontarsi col professore invece che fare un rilascio singolo. Nel modello a cascata non si puo' fare: una volta "firmato il contratto", nulla si puo' modificare
	- **manutenzione** fatta solo su codice
		- e' considerata un eccezione: il prodotto e' finito, non puo' essere modificato, non e' pianificato. Il progetto e' congelato
		- dato: **70% dei costi in questa fase**. Grossa perdita
		- disallineamento documentazione/codice per colpa delle patch

### - modello a V
dialetto del modello a cascata: ordinamento uguale, ma aggiunge il controllo qualita' (frecce verso l'alto). Ho un mapping tra fasi e test, ovvero a ogni fase (ogni attivita') faccio associare un test
- verifica (funziona, things right)
- convalida (e' quello che dovevo fare, right things)

Si cerca un feedback da parte dell'utente, bisogna coinvolgere il cliente per rivedere gli elaborati fatti.
- review, rivisita
	- tutti i test vengono fatti matchare in ordine inverso: test di unita' controlla attivita' di codifica, test di sistema...

#### riflessione sul modello a cascata: possibile variante

### modello iterativo
- singola retroazione: una fase puo' apportare modifiche alla fase precedente. Posso tornare indietro arbitrariamente. Ma non e' facile: una volta spostato un team di sviluppatori da una fase all'altra non so se sara' libero per ritornare indietro. Allocazione risorse. Faccio quindi tante iterazioni ma anche qui c'e' la **monoliticita**: ci si concentra sulla consegna
- svantaggi:
	- stressa la modularizzazione e l'identificazione di sottosistemi e si ripete coding e integrazione

### modello a fontana (altamente iterativo)
**niente piu' monoliticita'**. Non butto via tutto e ricomincio da zero, ma ritorno da zero per ripartire dalla fase iniziale di requisiti: questo e' per effettuare un controllo piu' pulito sulla visione d'insieme, per vedere le conseguenze di una modifica su tutte le attivita. "Modello a cascata da capo". **Mi ripongo le domande dall'inizio, ma NON rifaccio tutto da capo**. Arrivato alla consegna, esistono due fasi:
- manutenzione
- evoluzione.
Queste fasi fanno parte del modello, per la prima volta. Il progetto e' senza fine, so che dovro ritornarci. Se smetto queste due fasi il programma muore.

### sviluppo incrementale
Bisogna prevedere fin dall'inizio di consegnare qualcosa di non completo ma che almeno **deve avere senso**. Differisce dalla logica classica di prodotto finito. Al cliente arrivano versioni differenti via via migliorate. Non facile, ma ho
- vantaggi:
	- feedback dall'utente
	- ho qualcosa da consegnare anche in anticipo
 	- ho flessibilita' nello sforare
	- la manutenzione diventa riciclo

Si parla di incrementale quando nelle iterazioni viene inclusa la consegna
- svantaggi (problemi)
	- viene complicata la pianificazione
	- il monitoring e' difficile: non posso sapere lo stato attuale
	- bisogna pianificare le iterazioni, anche per dare qualcosa al cliente, cioe' qualche data di scadenza di qualcosa
	- bisogna rimettere mano a cio' che e' stato fatto, per cui non riesco a convergere verso la fine
	- quanto dura un'interazione? Rischio di voler mettere troppo nella prima versione
	- overhead per le troppe interazioni. Non e' vero che finita un iterazione ne inizia un'altra: possono sovrapporsi (**overlapping**)
		- non ho tempo di feedback

### modello prototipale
per sopperire i wicked problem: non puoi conoscere il problema finche' non lo incontri.
- vantaggi
	- prototipo pubblico
 		- capire meglio i requisiti, anche per capire i feedback dell'utente o all'estremo far compiere delle scelte al cliente stesso
	- prototipo privato
		- tipo se devo testare un nuovo linguaggio, progetto pilota, per avere diverse scelte nella soluzione del problema, tool nuovi
			- progetto pilota: serve internamente
			- testbed: ripeto sempre in diverse situazioni, mi permette di concentrarmi su problemi specifici
> LAW 3: la prototipazione riduce significativamente i requisiti e gli errori di progettazione, specialmente nell'interfaccia utente

- svantaggi (pericoli)
	- il prototipo e' usa e getta ma il cliente se ne innamora: se al cliente piace il prototipo e vuole solo delle modifiche aggiunte, devo portarmi dietro tutte le cattive scelte fatte per avere solamente una base. Mi porto la zavorra di un cattivo progetto con delle cattive scelte di progettazione (dato che il prototipo e' solo a scopo di prova) e la grande entropia mi fa fallire.

### modello flipper (provocatorio)
inizialmente conosco la direzione, ma poi navigo nel buio, qualunque step successivo e' possibile, ma non ho la gestione dell'effetto domino possibile. Non vengono imposti vincoli temporali (random). Non misurabile.

### modello trasformazionale (cleanroom)
si ragiona su rappresentazioni formali del problema, ovvero sapere esattamente cosa vogliamo in partenza (la centrale nucleare non esplode). Trasformo queste specifiche in qualcosa di piu' dettagliato, ma sempre formale (raffinazioni). Non posso dimostrare la correttezza dell'intero, quindi da concetti semplici formalmente corretti li porto piu' avanti. Ho sicurezza in partenza. Non applicabile per forza a tutto, ma a una parte (sottoinsieme)
- A ogni passo, rendo la mia specifica piu' concreta, attraverso trasformazioni automatiche e controllate
- Il formale **mi guida** nella trasformazione, mi limita, ma almeno mi garantisce che il raffinamento produce qualcosa che e' comunque corretto
- partendo dal formale ottengo un **prototipo**
- differisce dal finale per efficienza e correttezza
- passi di trasformazione (riusabili)(formalmente dimostrabili corretti) mi portano verso la versione finale. Non posso permettermi di mandare in produzione qualcosa di sbagliato. Non esiste una prova o un "primo approccio". (Esempio: compilatore C, indimostrabile una volta finito). Testing difficile per sistemi real time.

1. analisi e verifica
1. ottimizzazione

Fondamentale: **versioning**.

### modello a spirale (metamodello)
Guidato all'analisi dei **rischi**. Porsi delle domande. Esempio: anche se inizialmente perdo soldi, posso giocarmela sul lungo termine: se mi guadagno un cliente, successivamente avro' la sua attenzione.
Andamento a **spirale**: man mano che il progetto va avanti, io ho speso dei soldi e ho impiegato risorse. C'e' un momento in cui rivaluto i rischi e decido se andare avanti o fallire. Mi fermo e ragione: posso andare avanti? Vado avanti?

Fasi che si ripetono a spirale:
- determinazione obiettivi, alternative e vincoli
- valutazione alternative, identificazione rischi
- sviluppo e verifica
- pianificazione fase successiva

### - modello win win (evoluzione spirale)
7 zone: sono state ampliate le fasi di valutazione rischi: anche solamente scrivere il contratto e' una fase rischiosa, perche' potenzialmente firmo il mio fallimento. Bisogna contrattarre bene, anche quando la comunicazione coi clienti non e' pacifica. Win Win: entrambe le parti vincono (hanno l'illusione), tutti sono contenti

### modello COTS (Component Off The Shelf)
Partire da quello che il mercato propone (preesistente) e creare il sistema a partire da quei moduli pretestati. Aggregazione del sistema. Apre nuovi
- problemi (nuovi)
	- classificazione dei moduli (il buono e il cattivo): posso avere una grossa scelta, tra implementazione e licenze (assistenza o meno)
	- retrieval dei moduli: ho delle richieste specifiche sui moduli, difficili da mettere in qualche filtro per cercarli (scritto in ..., con tot ...)

- progettazione per componenti
	- requisiti
	- componenti
	- ridefinizione requisit in base a quello che trovo gia' disponibile
	- progettazione sistema: parti gia' svolte, parti assenti da sviluppare da zero, e soprattutto colla per componenti, da adattare alle esigenze
	- sviluppo e integrazione
