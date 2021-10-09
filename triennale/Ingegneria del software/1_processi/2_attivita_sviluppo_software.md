### Attivita' (qualcosa che devo fare, NON IN ORDINE)
- identificazione
	- precedenze temporali
	- soggetti diversi
- porsi delle domande
	- cosa devo fare adesso
	- fino a quando?

**1. Studio di fattibilita'**

Viene fatto per evitare di buttare soldi nel cesso. Infatti un progetto puo' essere stroncato sul nascere per ragioni
- strategiche: esempio qualcosa esiste gia' o competitor troppo grosso
- tecniche: ascensore verso la Luna: figo ma non posso farlo
- manageriali: spendo piu' di quanto guadagnerei nella vendita

In questa fase quindi devo prendere delle decisioni. Partendo dalla base:
- definizione preliminare del problema (non puo' essere una definizione completa, altrimenti gia' perdo soldi e tempo. E' solo un'idea generale pre mercato)
	- possibile mercato e concorrenti: qualcuno mi propone di fare qualcosa (stimolo esterno) e io devo decidere se farlo.
- studio diversi scenari di realizzazione
	- scelte architetturali e hardware necessario: su che piattaforma voglio farlo, le risorse che ho a disposizione, l'esperienza pregressa, il linguaggio di programmazione.
	- sviluppo in proprio, subappalto
- stima dei costi
	- tempi di sviluppo
	- risorse necessarie
	- quale soluzione adottare
- spesso difficile fare analisi approfondita (quindi delego il mio problema a un altro, quindi non e' piu' problema mio)
	- limiti di tempo
	- commissionata esternamente: chiedo una consulenza a un esperto, che ha esperienza pregressa, che me lo fa in tempi brevi. In questo modo non blocco il mio Team di sviluppo aspettando (1 mese) che il delegato mi faccia l'analisi
- OUTPUT:
	- documento in forma naturale (quello che mi interessa)

**2. Analisi e specifica dei requisiti**

- bisogna comprendere il **dominio applicativo** del cliente che vuole il software, il che e' molto difficile. Solamente per capire cosa ci stanno chiedendo serve comunicazione, studio del linguaggio e del dominio (generale)
- identificare gli stakeholder (interessati): capi dei clienti che lo useranno, cliente dell'utente del programma. Esempio metropolitana: manager della ditta, il conducente, il secondo conducente, i viaggiatori ecc...
- quali sono le funzionalita' richieste?
	- **cosa** deve fare il sistema? La raccolta dei requisiti si concentra appunto sul capire *cosa* bisogna fare, NON il *come*, quello e' compito della progettazione. I **requisiti** riguardano cosa vuole l'utente (e' il punto di vista dell'utente), le **specifiche** (in mezzo tra requisiti e progettazione) sono frutto dell'interpretazione dei requisiti, ed e' cio' che viene congelato come contratto. Attenzione: ci vuole comunicazione o si sbaglia.
- quali sono le qualita' richieste? (requisiti non funzionali)
	- tempo, sicurezza, costi
	- vanno considerate solamente quando vengono specificate dai requisiti utente
- OUTPUT:
	- **documento di specifica**
		- documento contrattuale approvato dal committente
		- sara' la base di lavoro di design e verifica
		- importante avere documento formale: meno ambiguita' ho in questo documento, meno problemi ci saranno in futuro (manutenzione, vie legali ecc...)
	> LAW 4: il valore del modello che usiamo per spiegare qualcosa dipende dalle viste che diamo. Nessuna vista e' la migliore per tutti gli scopi

	Esempio: non tutti i linguaggi di programmazione sono adatti per fare una cosa (parallelismo, velocita' sviluppo, applicazioni web ecc...)
	- **manuale utente**: vista esterna per eccellenza, quello che il cliente vede
	- **piano di test del sistema**: pianificazione dei test a cui il prodotto verra' eseguito per certificare la correttezza di tutte le parti, per capire se il software fa quello che e' stato chiesto nei requisiti ed espresso (in linguaggio naturale e/o formale) nelle specifiche. Fa parte del contratto

**3. Progettazione (Design)**
Come devono essere realizzati in maniera opportuna i requisiti e le specifiche? Non possiamo partire a scrivere codice, perche' non e' strutturato, non e' parallelizzabile, modularizzabile, quindi non posso suddividere compiti. Definizione architettura sistema:
- scelta architettura software di riferimento
- identificazione patterns (soluzioni testate e ritestate e ritenute opportune a problemi ricorrenti). Riutilizzo di soluzioni standard
- **scomposizione moduli o oggetti** (divide et impera). Serve anche per questione di tempistica, per rendere indipendenti i team tramite le interfacce, quindi distaccandosi dalle implementazioni concrete
	- **modularita'**:
		- possobilita' di
			- scomporre problema in pezzi piu' semplici (top-down)
			- comporre un sistema complesso da moduli esistenti (bottom-up, puzzle)
			- comprendere il pezzo scomponendolo in pezzi semplici (creo sempre un livello di astrazione aggiuntivo, uno sopra l'atro). Anche un nome significativo puo' servire per descrivere e capire il componente stesso
			- modificare un sistema mettendo le mani solo in una singola parte ben definita. *Single Responsability Principle*
		- come si effettua una modularizzazione corretta?
			> LAW 7: una struttura e' stabile (posso farla evolvere, modificarla) quando e' forte la coesione e basso l'accoppiamento

			-  **coesione (interna)**: tutti i suoi elementi sono strettamente collegati uno con l'altro, per svolgere un lavoro comune
			- **disaccoppiamento (esterno)**: bassa interdipendenza tra moduli, basso numero di chiamate a procedure esterne al modulo. Attenzione: non posso isolare tutto quanto, altrimenti vengono raggruppate cose poco coese, quindi non necessarie all'interno del modulo.
			- **information hiding**: taglio fuori le dipendenze. Se per esempio, da una mia firma di una funzione dipendono tante chiamate da diversi moduli, se devo cambiare anche solamente il numero di parametri e' davvero un casino. Se lo nascondo (tipo dietro un interfaccia) ho piena liberta'
			> LAW 8: solo cio' che e' nascosto puo' essere cambiato senza rischi
			- **data abstraction**
			- **object orientation**

- OUTPUT:
	- documento di specifica del progetto
	- UML (noi usiamo questo)

**4. Programmazione e test di unita'**
 C'e' una stretta dipendenza tra quello che scrivo e i primi mini-test di verifica di quello che ho appena scritto. Quindi i programmatori sono i primi, in modo informalmente, a dover testare il loro frutto. Il passaggio successivo e' quello di sistema, non dipende dai programmatori singoli.
- Viene realizzato quello che e' stato "disegnato" al punto precedente.
- I singoli moduli vengono testati indipendentemente. Puo' sembrare una perdita di tempo perche' tutto il codice di test non viene venduto, per cui e' tempo perso, ma allo stesso tempo e' una sicurezza/garanzia: se sgarro col tempo, consegno e so che e' corretto.
	- vengono usati dei **framework di test**, che mi semplificano il lavoro, mi permettono di isolare i componenti. Anche se ho fatto di tutto per tenere basso il disaccoppiamento, esiste. Non so se il modulo che uso esternamente e' gia' pronto o e' giusto, per cui voglio essere sicuro di pescare errori dal mio codice e non al di fuori del codice.
		- **moduli stub (chiamante)** (fittizzi): grazie a essi posso isolare/mascherare l'esterno, concentrandomi solo sull'interno. Niente implementazione, solo casi prefissati hard-coded
		- **moduli driver (chiamato)** provano a chiamare le funzioni reali per testare il risultato
- OUTPUT:
	- insieme di moduli sviluppati separatamente
	- singolarmente verificati

**5. Integrazione e test di sistema**
E' ora di mettere insieme i componenti e fare i test di integrazione. Abbiamo sviluppato tutto singolarmente in modo fittizio, ora bisogna accoppiare nel mondo reale. Possono saltare problemi non previsti (esempio: unita' di misura diverse). Invece di mettere insieme tutto, si mette insieme pezzo per pezzo in maniera incrementale.
- Approcci diversi:
	- top down: nessuno mi chiama perche' sono il punto di partenza. Quindi parto dalla cima, la radice di tutto.
	- botton up: (non lo usa nessuno) parto dalle foglie. Molto scomodo

- test di sistema: intera applicazione
- test di accettazione: punto di vista utente
	- se esiste un committente come da contratto, lo testo sulla macchina del cliente e glielo faccio provare. Ambiente sotto controllo
	- oppure, se devo venderlo al grande pubblico a chi lo faccio testare? Diverse piattaforme, non previste, produttori di software/hardware diversi. Devo farlo provare a tante persone con diversi sistemi. Il metodo per farlo e'
		- alfa test: il prodotto viene fatto provare solo internamente all'azienda. Sinonimo di immaturo, preliminare. Nessuno esternamente lo sa. Raggiungo una certa affidabilita', ma le macchine hanno configurazioni uniformi.
		- beta test: lo faccio provare a clienti selezionati esternamente, quindi con macchine con configurazioni diverse. Puo' essere inutile perche' il cliente per vari motivi (pigrizia, privacy) non inviano gli errori riscontrati (bug). Conviene selezionare clienti e "costringerlo" a darmi feedback
- OUTPUT:
	- il sistema

**6. Manutenzione**
- Intervento:
	- correttivo
	- adattativo
	- perfettivo

- OUTPUT:
	- prodotto migliore. Ma se un sistema evolve, puo' allontanarsi dal progetto iniziale perche' le patch introducono entropia, casino, allontanandosi dalle forme iniziali. Bisogna evitare la re-ingegnerizzazione (butta via e ricomincia da capo)

**_. Altro**
- Documentazione
	- puo' avvenire in fasi diverse per motivi diversi, pratica trasversale
	- nella pratica e' un'attivita' fatta a posteriori
		- per AGILE la documentazione e' il testing fatto, e' una prova formale/informale di quello che e' stato fatto. Questo perche' la documentazione diventa datata, non viene aggiornata dopo le patch, quindi e' dissociata dalla realta. Nel testing invece i test, se falliscono, si autodenunciano, parlando della salute ATTUALE del codice.
- Verifica e controllo qualita'
	- QA
- Gestione del processo stesso
	- Inventivi, responsabilita', eccezioni. Esempio: nuovo arrivato, schieramento risorse, gestione tempo
- Gestione configurazioni
	- Diversi sistemi operativi, diverse accezioni/dialetti

### Fasi (qualcosa che devo fare IN UN CERTO MOMENTO)
Le fasi dipendono dal modello di ciclo di vita del software scelto, perche' stabilisce un ordine nelle attivita'
