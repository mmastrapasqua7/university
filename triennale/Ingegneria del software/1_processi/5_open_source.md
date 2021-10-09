### Processo Open Source
Open source non vuol dire gratis (free), ma offre il codice. Se e' anche gratis (free), allora si parla di FOSS (Free and Open Source Software)

#### Strumenti Open Source
Ho bisogno di strumenti per aver la capacita' di fare qualcosa di concreto con l'open source. Open sta per accesso libero, come codice, tutorial, documentazione ecc... Questo **non vuol dire che sia facile**. Infatti la maggior parte degli strumenti sono mirati alla **comunicazione**

- comunicazione
	- internet
	- tutto e' comunicazione, ma qualcosa e' solamente comunicazione
		- forum
	- bisogna tenere la community di sviluppo unita
		- dato che spesso non si incontrano mai afk, c'e' bisogno dell'aspetto psicologico, il senso di inclusione / fraternita'
	- rispondere ai dubbi delle new entry
- sincronizzazione del lavoro e versioning
	- sul codice
	- sulla documentazione
- automatizzazione delle build (gradle)
	- scarica una serie di file di internet per le dipendenze / librerie, autoimport
	- automatizzazione del setup del mio luogo di lavoro
	- rilanciabile
- bug tracking

**SCM (Source Code Management): General Idea**
- Version Control: serve per sopperire al problema delle diverse versioni del software, che cambiano per bugfix, cambio idee ecc... Invece di avere numerose versioni in diverse cartelle, sparse per varie memorie di massa, vorrei avere un gestore delle versioni in modo automatico
	- voglio la facilita' di richiamare una qualunque versione del software, scritta da tizio, prima della versione x e dopo la versione y.... **trovare versioni**
	- non voglio aspettare dei commenti, non posso stare con le mani in mano, ma voglio procedere per poi integrare i vari commenti nel corso dello sviluppo, senza aspettare gli altri. Infatti il versioning mi permettte di condividere i lavori con altri, gestendo accessi contemporanei e aiutando a gestire i conflitti. **riconciliare versioni**
	- voglio tracciare chi ha fatto cosa, voglio sapere l'autore di ogni riga per risalire ad esempio a sviluppatori malevoli. **tracciabilita'**

**1. Approccio client server**
Unico server a cui tutti i client si connettono. Tra i tool proprietari prevale l'approccio centralizzato. Funziona bene quando si e' interni a un'azienda. Funziona.
- OpenCVS
- Subversion (SVR) vecchio

**2. Approccio distribuito**
Tra i tool opensource prevale l'approccio distribuito. Nell'open source la centralita' e' difficile, tipo per localita': diversi tempi di accesso, singolo punto di fallimento, non posso salvare il mio lavoro se non posso contattare il server. E' un vincolo. Ecco perche' distribuito (anarchico, non disciplinato). Tanti tentativi, ma ne prevale uno (git). Nell'opensource ci sono molte piu' sfide. Tutto il mondo puo' scrivere, su parti diverse, a tempi diversi ecc...
- BitKeeper
- Git

Ma un approccio distribuito e' anche ragionevole all'interno di aziene, centralizzate e piccole. Porta dei vantaggi

**FAMOSI**
- CVS (il piu' diffuso)
- Subversion (dedicato anche a INGSW, erede CVS?): fare CVS meglio (risolvere i problemi)
- BitKeeper (distribuito ma proprietario), usato per Linux anni fa, usato da Torvalds. Era gratuito per progetti open source. Continuava a cambiare licenza
- Git, nato per risolvere i problemi di bitkeeper
- Mercurial, concorrente di git. Piu' pulito, scritto in python
- Bazaar (usato da ubuntu, mysql)
- GNU arch, monotone ecc...

#### ELEMENTI DEL VERSIONING
- **REPOSITYORY**:
mantiene informazioni comprese di date, etichette, versione. Salva solo le **differenze** tra una versione e l'altra. Puo' essere centralizzata o distribuita. Viene salvata solo la versione attuale, per tornare indietro applico le differenze (veloce per versioni recenti, lente per versioni vecchie)
	- git: usa la compressione e a ogni versione etichettata ufficiale (v0.1, v0.2) vengono salvati i file e non piu' toccati, ma riferiti come symbolic link. Tradeoff tra storage e velocita' di accesso

	Distribuzione:
	1. approccio a branch: lascio lavorare la gente solo su branch a parte
	1. approccio multirepo: ognuno clona il repo e ci fa quel che vuole, per poi fare una richiesta di push a quello originale

- **WORKSPACE**
Al posto di clonare tutto il repository, prendo una sola versione del software e lavoro su quella. Da una parte la storia, da una parte il software e basta.

- **CHECKOUT**
In CVS, l'oggetto di versioning era il singolo file. Ma c'erano dei problemi: cambio nome della classe, cambio nome del file e quindi per il versioning e' un file nuovo. Quel file, nascendo da zero, non ha storia. Tutta la storia delle modifiche di quel file vengono distrutte. Facendo il checkout sul repo, e' piu' semplice. C'e' una storia di tutti i file e le modifiche all'interno della cartella. Uso di hash, cosi' ho la sicurezza riguardo l'integrita' del file, anche contro la rinominazione dei file. (git/svn vs. cvs)

- **CHECKIN/COMMIT**
C'e' la possibilita' di conflitti: se faccio pull, modifico e prima del push il file e' stato modificato da qualcun altro, posso avere collisione. Succede solo lavorando sulle stesse righe o la stessa funzione. L'unita' di conflitto e' la riga di codice/funzione o distanza di righe. Git sposta i conflitti sul locale, ovvero prima di pushare devo fare un pull per la nuova versione. In git non e' piu' una comunicazione tra macchine (client-server), ma viene spostato sul client: prima risolvo i conflitti con la nuova versione pullata, poi faccio un push gia' risolto sul repo.

- **TAG**
mettono in relazione piu' file per poter essere usati come versioni, ovvero creare un insieme di file che definiscono una versione stabile del software. Segnalazione di una versione, configurazione. Perde significato in git/svn: tutto il repo viene taggato, non un insieme di file.
	- **FILE ANNOTATION**
	linea per linea dice quando e' stata cambiata e da chi, molto utile anche come bug tracking

- **LOCK o MERGE**
Nel sistema centralizzato veniva segnato il tipo di checkout: lettura e scrittura. Se marcavo un file come checkout in scrittura, tutti gli altri non potevano fare lo stesso finche' non lo liberavo. In git, faccio quel che voglio e poi mi occupo di risolvere conflitti, se ci sono. Prima del commit vedo se e' stato modificato e se c'e' un conflitto.
	- il merge in CVS e' noioso e laborioso (overhead)
	- nel merge di git ci sono 3 tipi base (estendibili tramite plugin, ognuno puo' fare il suo)
		- resolve: 3 way merge
			- si cerca il file antenato piu' vicino a cui si fa riferimento, e diventa il terzo (oltre sviluppatore1 e sviluppatore2)
		- recursive
		 	- non c'e' un antenato comune, va risolto ricorsivamente (tornando indietro)
		- octopus
			- in assenza di conflitti seri, mi permette di risolvere tanti branch. Prendo piu' branch e li unisco in un colpo solo su un branch. Unico merge.
	- git permette anche di tornare indietro nella storia, cancellare storia, versioni ecc... basso livello. Permette di cambiare la storia, accorciando anche il numero di commit. **Non e' un mezzo sicuro**, va usato solo quando si e' competenti.

- **DISTRIBUITO**
vuol dire **poter non avere** un server centralizzato, non implica l'assenza. E' piu' probabile che il server centrale sia su github/gitlab/altro, ma possono fungere anche da mirror pubblici per uno sviluppo piu' privato, interno. I peer hanno tutto il repo e non c'e' sincronizzazione automatica, va richiesto esplicitamente.
	- Si puo' decidere di fare merge con un paritoclare utente (altro repository)
	- posso collegare certi branch con quello centrale.

	- PRO:
		- offline work (posso cancellare le cavolate fatte prima di pusharle)
		- flessibile (posso distrubuire moduli o patch anche via mail), puo' passare per piu' livelli gerarchici senza deteriorarsi, ugualmente utile.
		- piu' veloce

- git: cambio approccio:
	- checkout, commit, update
		- lavorano tra working copy e repo locale
	- pull e push
		- servono per mettere in **comunicazione** repo diversi, senza gerarchia (repo tra users)

ESCLUSIVA DI GIT CHE ALTRI NON HANNO
- **INDEX**: con git-add faccio la fotografia, e questa fotografia finisce nell'index. Se prima di committare faccio altre modifiche, sull'index rimarra' la versione precedente, e mi verra' segnalato che in locale ho apportato modifiche a quel file (**passaggi intermedi**). Posso decidere quali file includere nel commit, cosi' posso separare aspetti diversi che ho modificato, per dare un messaggio di commit significativo della modifica, e non mettendo tutto in un unico impastato commit.

- **UP-STREAM REPO**

fork: fare un clone su cui noi siamo amministratori sul server, poi clone del mio personale repo.

### Processo Open Source
- La Cattedrale e il Bazaar [Eric Raymong]
- The care and feeding of FOSS [Craig James]
- The emerging economic paradigm of open source [Bruce Perens]

#### Vita ed evoluzione del software

1. **qualcuno ha un'idea**: e la fa funzionare
	- 1989: Tim B. Lee
		- un sistema ipertestuale globale (HTTP)
			- web client (browser)
			- web server
	- 1973: primo sistema operativo (UNIX) scritto ad alto livello (C).
		- questo sistema operativo era ricompilabile su tante diverse macchine.
			- c'e' la possibilita' di scelta del sistema operativo
1. **espansione ed innovazione**: il mondo prende coscenza e inizia a usarlo, e in questo modo l'idea si arricchisce
	- Web Server: CGI, SSI, encryption, security, streaming. Secondo l'autore questo e' il periodo peggiore per l'opensource perche' mentre le aziende hanno schierati sviluppatori full time pagati per l'espansione e l'evoluzione, l'opensource non ha ne capo ne coda, e' un bazaar. Nonostante questo, Apache domina il mercato. Altro problema in questa fase: nonostante tutto lo sforzo in tecnologie proprietarie, personali, gli sviluppatori, per svilupparle, prima o poi devono saperlo, e da li nasce la loro idea personanle che diffonderanno nel mondo gratuito, come le socket. Inizia un continuo sorpasso, continuo rincorrersi.
		- **commerciale**: Sun, Microsoft, Netscape (il browser era gratuito, il software del sito web veniva pagato)
		- **foss**: NCSA server, Apache
	- OS:
		- **commerciale**: Unix
		- **foss**: BSD, Minix
		- Nascono personal computer
1. **consolidation**: dalla pluralita' di prodotti esistenti, molti si aggregheranno ai migliori, si uniscono, si fondono. Gli investitori vogliono i soldi.
	- Web Server
		- Microsoft IIS (Internet Information Service)
			- non gliene frega di essere in perdita, perche' vuole dominare il mercato del futuro. Sistemi operativi: oltre a vendere il sistema operativo, distribuisco Internet Explorer: browser di merda Microsoft. Alcune cose subiscono l'influenza della coppia (client server), altri no (client-side scripting, DOM ecc...)
			- Vuole sfruttare la posizione dominante per forzarti a usare solamente i loro prodotti coi loro standard interni, non globali.
			- Assorbe Mosaic
		- Apache
			- si afferma come soluzione free

	- OS: Alcuni scomparsi
		- Commodore Atari VMS
		- o si tengono posizioni di nicchia (Macintosh)
		- Unix (IBM/HP/Sun -> Posix standard)

1. **maturita'**: pochi prodotti sopravvivonno come migliori, si affermano sul mercato, la tecnologia si ferma, l'esplorazione del dominio e' completa e non c'e' molto da aggiungere. Al contrario, si snelliscono le cose inutili aggiunte nella foga. Piccole ditte sopravvivono perche' sono di nicchia, specializzate in certe direzioni (cose ad HOC, non per il grande mercato), c'e' ancora la possibilita' di affermarsi di piccoli team per cose di nicchia, piccolo pubblico.
	- Ormai si sa cosa si vuole da un WebServer
		- lo sviluppo di nuove idee e' rallentato
		- si preferisce avere dei prodotti software con qualcosa di molto piu' specifico, ovvero un sottoinsieme di tutto quello che e' stato fatto (prodotti di nicchia)
	- Si sa cosa si vuole da un OS
		- fundamental I/O
		- networking
		- security
		- windowing
		- multitasking
		- memory management

1. **FOSS domination**: durante la maturita' dei prodotti e la fine dell'esplorazione del dominio (fine avanzamento tecnologia), le alternative libere e gratuite iniziano a prendere piede, iniziano a formarsi piccole comunita' volte allo sviluppo del software libero per loro stessi. Inesorabilmente levano terreno ai prodotti di mercato, li mangiano lentamente. Piano piano vado a rimangiare il terreno perso in fase di espansione, aggiungendo feature dopo feature. Ma questo e' anche il momento dell'abbattimento, della rinascita, del rifare le cose da zero: ora che si sanno tutti i problemi, tutto il software prodotto fino ad ora puo' sembrare qualcosa come un prototipo di tutto quanto, e quindi viene rifatto del software con la pienissima consapevolezza: nasce Linux da Minix (Torvalds), nasce nginx da Apache (bloat)
	- FOSS:
		- maggiore flessibilita': prodotto FOSS raggiunge le feature delle versioni commerciali. Aggrego tante cose e lo vendo come un prodotto finito, costumizzandolo per il cliente.
		- maggiore affidabilita' e sicurezza: data la possibilita' di inserire nel software altre cose che non so cosa fanno nelle robe commerciali, e' difficile fidarsi. Esempio: ci e' stato un periodo dove tutti i CD windows erano stati rimpiazzati da una versione modificata col virus. Col commerciale mi devo **fidare**, con l'opensource e' tutto pulito e aperto a tutti. Mi serve sapere in ambito di sicurezza sapere esattamente cosa c'e' dentro, voglio poterlo compilare.
	- Commerciali:
		- molti scompaiono
		- alcune ditte commerciali si convertono (IBM vende servizi)
		- Sun rende Solaris open source (troppo tardi, ormai col FOSS tutti copiano tutto, quello che vince non e' quello con piu' feature, perche' copiabili, ma quello gia' assodato, col maggior pubblico che gia' sviluppa intorno)

1. **FOSS era**: alla fine, foss dominera' il mondo
	- non attuata ne nel commerciale ne nel foss
	- i prodotti commerciali rimangono solo in mercati di nicchia
	- non possiamo far finta che il FOSS sia qualcosa di passeggero

Esiste la filosofia FOSS al di fuori del software?
- NO: il software e' impalpabile, non puoi toccarlo, non esiste fisicamente, e' duplicabile infinite volte. L'unico freno a mano sono le licenze e DRM.
- Anche se la digitalizzazione ha reso impalpabile una serie di operazioni (intermediari nei prodotti di consumo e nell'arte/musica)

#### Open Source Internals (artigianale)
- La cattedrale e il bazaar [Eric Raymond]
	1. ogni buon lavoro software inizia dalla frenesia personale di uno sviluppatore
	1. chiede ad amici o colleghi cosa sanno sull'argomento, alcuni hanno lo stesso problema o problemi simili, ma nessuno ha la soluzione
	1. Le persone interessate cominciano a scambiarsi pareri e conoscenze sull'argomento
	1. le persone interessate danno il via al progetto, ovvero le persone interessate a spendere risorse (il proprio tempo libero) per la risoluzione dell'idea

	OUTPUT:
	- qualcosa che attragga l'attenzione

	1. vengono raggiunti dei risultati presentabili
	1. si rende noto il lavoro svolto dal gruppo
	1. arrivano i primi suggerimenti da gruppi esterni
	1. interazione tra vecchi e nuovi membri del progetto
	1. nuove informazioni vengono acquisite
	1. si ritorna al punto 1

	C'e' solo comunicazione, voglia di andare avanti, goliardia, niente di piu'.

	**FRASI IMPORTANTI**:
	- "Se dai a tutti il tuo codice sorgente, ognuno di essi diventa un tuo potenziale ingegnere"
	- "Bad code is better than good/no code", "Se ci sono abbastanza occhi che cercano errori, gli errori diventano di poco conto". Se qualcosa non funziona si vede, non compila, per cui vado a mettere occhio al codice. Quando non lavoro io lavora qualcun altro. Se c'e' un piccolo errore, un utente con una patch diventa sviluppatore attivo. Non mi preoccupo di aver immesso un errore, tanto altri guarderanno
	- "Se tratti i tuoi beta-tester come se fossero la tua risorsa piu' importante, essi risponderanno diventando la tua risorsa piu' importante". Anche se l'affidabilita' e la sicurezza non e' l'obiettivo principale, sui grandi numeri qualcuno lo fa. Se mille persone guardano lo stesso codice, qualche feedback arriva per forza e qualcuno se lo prendera' in carico per la risoluzione
	- "Quando hai perso l'interesse in un programma, l'ultimo dovere e' passarlo un successore competente". Per non far morire il progetto bisogna trovare qualche successore, prima di abbandonarlo del tutto.

	- **CONFRONTO**

	|                 | proprietario | opensource |
	|-----------------|--------------|------------|
	| **modello** | cattedrale | bazaar |
	| **risorse** | definite | sconosciute |
	| **planning** | intero progetto | stepByStep |
	| **utente** | utente pagante | co-developers|
	| **obiettivo** | risp. del contratto | risolvere un problema |
	| **motivazione** | stipendio (forse?) | voglia (debole?) |
	| **stato progresso** | segreto | pubblico |
	| **collaborazione** | faccia a faccia | internet |
	| **assic. qualita'** | processo/management | peer revision |

	- **PROBLEMI**
		- tutti possono collaborare ma non tutti collaboreranno, c'e' una concorrenza sul conquistare vari developer. Ce ne sono tanti quanti sono i progetti opensource. Non c'e' un impegno fisso. E' anche un problema di visibilita': come faccio a sapere dell'esistenza di un software opensource?
		- forking: essendoci un codice disponibile, posso clonarlo e prenderlo come punto di partenza e fare il mio codice, usandolo come punto di partenza. Per cui non c'e' un controllo omogeneo di tutte le versioni e di tutto il codice. C'e' anche una questione di licenze: non posso copiare qualsiasi cosa su internet gratuitamente e farci quello che voglio. Se si crea conflitto tra developers, tipo un developer non accetta una modifica, si inizia una nuova fork per apportare le modifiche respinte dall'altro. Vedi: Bitcoin e Bitcoin Cash. Da un progetto forte, il progetto si divide e muore per assenza di forza lavoro. Cambio capo
		- voglia: non tutte le parti da sviluppare sono belle, ci sono dei punti noiosi da programmare di cui nessuno si vuole occupare, magari senza nemmeno il riconoscimennto. Colli di bottiglia noiosi.

#### Open Source Economics (Industrial)
- Il software non e' il centro del mondo, magari e' solo un mezzo, una tecnologia abilitante. Esempio Amazon: vende libri e prodotti, ma ha bisogno del software per farlo. Amazon non vende software, vende i servizi. Il software quindi serve per abilitare servizi.
- Il software puo' fare la differenza? Puo' differenziarmi dagli altri? E' un vero vantaggio rispetto agli altri? Se e' brevettabile e' un vantaggio, altrimenti no. Gli sviluppatori che producono il sito web di amazon non guadagnano soldi dal farlo, non e' il software in se a produrre, ma il servizio che regge sopra.
	- Il cliente puo' vedere l'effetto del software sul suo business? Il cliente vede se ho installato Linux o Windows per hostare il suo software/sitoweb/app?
	- Il tuo competitor puo' avere lo stesso identico software? Conviene investirci?

**Paradigma differenti di sviluppo per fattore economico**
- Come distribuisco il costo dello sviluppo?
- Come distribuisco il rischio di fallimento?
- Qual e' l'efficienza di finanziamento dello sviluppo? Quanti soldi vanno persi nell'overhead e quanti allo sviluppo effettivo?
- Qual e' il grado con cui riusciamo a escludere altri competitor dal mio software

![alt text](../.img/table.png "table")

- Descrizione
	- Retail: prodotto non fatto per uno specifico cliente, come Windows. Bassa efficienza, perche' viene speso molto in marketing, advertising, scatole, logistica, scaffali nei mercati ecc... E' cosi' inefficiente che l'unico motivo di sviluppo e' il mass market, ovvero grandissimi numeri di vendite. Il failure rate e' del 50%. Incomincio a vedere dei soldi solo a fine processo, tutti i rischi sono a mio carico, fino all'ultimo secondo. Non c'e' differenziazione per questo prodotto, e' mass market, chiunque cel'ha. E' un fattore di differenziazione per la casa che lo sviluppa, innfatti non puo' essere copiato.
	- In-House and Contract: prodotto richiesto dal cliente, su misura, per contratto (prodotto-acquirente). Alta efficienza perche' pago gli sviluppatori. Nessuna distribuzione dei costi. Protegge la differenziazione del cliente (richiesto dal cliente su contratto), altrimenti puo' essere rivenduto. Mercato richiesto: 1.
	- Consorzio / collaborazione non-opensource: efficienza alta, ma 90% di rischio fallimento, inutilmente alto. Costo distribuito, rischio distrubuito. Esempio: si riuniscono varie aziende per fare uno standard riguardo qualcosa. L'idea e' di fare un cartello, chiudere il mercato. E' difficile collaborare con le aziende perche' ci sono obiettivi contrastanti. Ecco perche' il fallimennto alto. Non mi soddisfa dal punto di vista competitivo
	- OpenSource: efficienza medio-alta. L'idea e' quasi sempre quella di rifare un prodotto commerciale e renderlo gratuito, ovvero fare qualcosa di gia' visto e farlo gratis. Problema: non ha grandi speranze, e' facilmente imbrogliabile: per il commerciante 'e facile rendere incompatibile i due progetti, tipo i formati dei file o le librerie. I colossi si scannano su una costa: stessa interfaccia, codice diverso, e' brevettabile? Si? No? Non protegge differenziazione vendor/client, ma almeno ho una grande distribuzione dei rischi e del costo. Perche' l'azienda paga sviluppaatori open source? Semplice: il cliente non vede se sotto l'app gira linux o windows, ma devo essere sicuro che funzioni: uso l'opensource perche' 'e' gratis, non sviluppo ulteriormente, ma invece di pagare 50 sviluppatori per qualcosa gia' fatto, ne pago 5 per il controllo qualita', per assicurarmi che tutto funzioni perfettamente, invece di rifare un software, gia' esistente, da zero. Opensource non vuol dire volontariato, vuol dire codice disponibile.

#### Validare le impressioni
Affermazioni->metriche. Devo validare tutte le affermazioni dell'opensource, come ha fatto Meyer per l'agile. Piu' di 6 studi sono stati fatti per ogni aspetto dell'opensource. Puo' essere fatto perche' siti come github e bitbucket hanno i grafici del progetto pubblici, ovvero posso vedere tutto lo sviluppo del software, tutti i rilasci delle versioni ecc...

Problema: 3/5 affermazioni dicono il contrario. Non bisogna dare mai per scontato quello che viene affermato.

![alt text](../.img/results.png "table")

#### Vecchie sfide
- integrazione del software
	- modello a cascata
		- e' una fase a se' stante
	- modello microsoft
		- stabilizza e sincronizza: alla fine della serata devo committare la mia versione, il mio codice, e partiva la compilazione totale, one shot. Ogni sera quindi e' la versione migliore possibile pronta a uscire dall'azienda.
	- modello XP
		- piu' volte al giorno, escludendosi a vicenda (finche' non siamo troppi)
	- F/LOSS
		- continuamente senza coordinazione a priori

#### Nuove sfide
- il team si sfalda
	- come comunicare?
	- come tenersi uniti?
	- come coordinarsi?
	- come ottenere collaborazioni?
