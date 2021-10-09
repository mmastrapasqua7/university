# Attacks history

## LOGIC BOMB
- **Trans-Siberian Gas Pipeline (1982) (fake?)**
La legenda narra che un agente del KGB doveva rubare un sistema di controllo insieme al suo software per usarlo sulla Siberian pipeline. La CIA fu avvisata di questo e fece installare una logic bomb nel programma, che fece saltare in aria un condotto.

## WORM
- **Morris Worm (1988)**
exploit che si basava su un buffer overflow sul demone fingerd. Infettò ben 6K macchine su internet, cioè circa il 10% dell’attuale internet. Costo stimato di $ 10M in riparazioni e downtime.
	- **Composto da due parti**
		1. programma per diffondersi
			- cerca macchine da infettare
			- prova a infettarle
		2. programma per vettori di attacco
			- compilato ed eseguito su macchine infette
			- trasferisce il programma principale per continuare l'infezione
	- **Exploit per introdursi nelle macchine**
		1. **buffer overflow sul demone fingerd**
		era il demone per il protocollo finger, girava sulla porta TCP 79. Serviva per scambiare informazioni riguardo gli user attivi sulla macchina e il loro stato. Informazioni dettagliate e non. Il worm scriveva stringhe più lunghe della capacità del buffer (soli 512 Byte) e sovrascriveva l’indirizzo di ritorno per saltare a una shell.
		2. **sendmail DEBUG feature**
		programma di default per distribuire e inoltrare / inviare email su sistemi Unix. Quando veniva compilato col flag di DEBUG, il programma sendmail accettava un nuovo comando SMTP: DEBUG. Questo sulla porta 25. Bella feature per il testing, ma nel 1988 veniva compilata di default col flag DEBUG per consentire di debuggare comandi. Questo comando dava la possibilità di inviare uno script shell ed eseguirlo sulla macchina host che girava il programma. Pecca: sendmail girava coi permessi di root…
		3. **trusted hosts file in remote login**
			- nel file /etc/hosts.equiv ci sono tutti gli hosts fidati (tutti hanno lo stesso account)
			- nel file /.rhosts e ~/.rhosts sono presenti gli host fidati
	- **Fasi**
		1. Ottiene informazioni riguardo alla macchina e riguardo agli indirizzi IP disponibili situati nella rete locale.
			1. Costruisce una lista di tutti gli IP della sottorete locale dalla netmask
			2. Utilizza netstat e randomizza la lista (al giorno d’oggi si provano tutti gli IP possibili perché internet ha più banda ed è molto più grossa e complessa)
		2. Provare a infettare le macchine secondo i vettori del worm, ovvero i 3 exploit precedentemente elencati (rsh, finger, sendmail). Esempio nel caso di rsh, una volta infettato un computer si leggevano i file /.rhosts e /etc/hosts.equiv per leggere gli hosts fidati e sperando nella relazione simmetrica, ovvero che i fidati da una parte fossero a loro volta fiduciosi di loro, provando connessioni rsh.
		3. leggere hosts da file per macchine fidate, provare connessioni rsh, provare a rompere l’accesso a semplici account (tipo account senza password, password semplici e attacchi a dizionario, con dizionario di 500 parole circa incluso nel worm).

- **Code Red I & II (2001)**
Diretto discendente del morris worm. Exploit basato su buffer overflow in IIS (web server di Microsoft, lol). Infettò più di 500K macchine su internet. Costo stimato di $ 2.6B in danni.

- **Nimda Worm (2001)**
Famiglia di worm che prendeva di mira principalmente certe versioni di Windows. Sfruttava una vulnerabilità per diffondersi infettando documenti su internet e allegandosi alle email in uscita. Inoltre si diffondeva copiando se stesso su dischi di rete, dischi rigidi, computer remoti, cartelle condivise e cartelle locali. Comprometteva la sicurezza condividendo il disco C e creando un account guest con privilegi di root.
la sua principale caratteristica era la propagazione rapida del worm tramite 5 vettori di attacco, tra cui backdoor lasciate da worm precedenti.

- **Nimda I**
sfruttava una vulnerabilità di IE (Internet Explorer) legata al rendering HTML (bug logico). La vulnerabilità era la seguente: una mail creata appositamente in HTML riusciva a lanciare una mail embedded. Il worm infettava file in rete e veniva eseguito automaticamente quando un utente navigava col browser con le impostazioni di sicurezza settate sul basso.
	- **COME LO FACEVA**
	copiava se stesso come un file “readme.eml” che conteneva pagine web come file .html e .asp. Il file readme conteneva linee di codice in più per sfruttare la vulnerabilità. Infettava altri documenti con del codice javascript che apriva automaticamente il file readme.eml per chiamarlo.
		1. **allegato email** (ogni 10 giorni)
		il worm inviava una copia di se stesso come un allegato email alle email trovate sul computer infettato, insieme a linee di codice per sfruttare la vulnerabilità precedentemente citata. Questo allegato causava l’esecuzione automatica quando l’user semplicemente guardava una preview della mail o quando effettivamente apriva l’allegato
		1. **replicazione via network filesystem**
		Copiava se stesso col nome di una libreria “riched20.dll” nelle cartelle dove erano presenti documenti di word o file con estensione .doc e .eml. Il virus veniva eseguito quando un utente apriva WordPad o Word, perché queste applicazioni caricano la libreria in memoria.
		1. **ISS directory traversal**
		usava url preconfigurati per attraversare le cartelle a ritroso ed eseguire comandi. Tipo: “http://address.of.website.com/..%c1%1c../winnt/system32/cmd.exe?command”
		1. **exploit di backdoor lasciate da precedenti worm**
		1. **codice JavaScript nelle pagine web**
		```javascript
		<script type=”text/javascript”>
			window.open(“readme.eml”, null, “params”);
		</script>
		```
	Il worm inoltre abilitava la condivisione del disco C: in rete sotto nome di C$, creava un utente “Guest”  aggiungendolo al gruppo di amministratori su sistemi Windows NT e 2000.

- **SQL Slammer (2003)**
exploit basato su Microsoft SQL server. Infettò 75K hosts in 10 minuti.

- **Conficker (2008, 2009)**
exploit basato sui servizi server di Windows. Infettò circa 12M hosts. Era persistente, si aggiornava da solo e installava altra merda. Microsoft offrì $ 250K a chi avesse scoperto il creatore. Meccanismi di sicurezza avanzati per tenersi aggiornato. Inoltre disabilitava programmi volti alla sicurezza del sistema, come DNS lookup correlati a venditori di antivirus e windows update stesso.
	1. **vulnerabilità MS Server Service**
	veniva sfruttata tramite remoto con una richiesta banale come RPC, che portava all’esecuzione di codice senza alcuna autenticazione
	1. **attacchi a dizionario su ADMIN$ share**
	1. creava AutoRun basati su librerie DLL per allegarsi a chiavette USB.
Il computer attaccante incorporava un web server che inviava dei pezzi di codice su porte random degli hosts presenti nella lista di attacco. In alcuni computer questo induceva le macchine in un buffer overflow che causava una chiamata su internet o sulla LAN al computer attaccante. In questo modo l’attaccante spediva come risposta un codice per l’installazione di conficker, che veniva quindi scaricata ed eseguita sul computer infetto. Si loggava su dischi in rete usando una lista di password semplici e comuni e inoltre piazzava il codice sulle chiavette USB e su altri dischi in rete.

## WORM ACCADEMICI
- **Warhol Worm**
	- infettava tutti gli hosts vulnerabili in 15 minuti – 1 ora
	- ottimizzato per la scansione in rete
	- lista iniziale di host vulnerabili
	- scansione della sottorete
	- permutazioni delle scansioni coordinate

- **Flash Worm**
	- infettava tutti gli hosts vulnerabili in 30 secondi
	- determinava una lista di server con servizi in ascolto e la replicava insieme al worm stesso

## EMAIL WORM
- **Love Bug Worm (ILOVEYOU worm) (2000)**
10B $ di danni
- **MyDoom Worm (2004)**
1M di hosts infettati, che iniziarono un DDoS in massa contro SCO group, una compagnia software americana molto famosa a quel tempo.
- **Storm worm & Storm botnet (2007)**
1.7M di hosts infettati. In meno di un anno diventarono 10m.

## MOBILE WORM
nati inizialmente per telefonini con sistema operativo Symbian. Esempi famosi:
- **Cabir Worm (2004)**
si replicava nell’area bluetooth intorno al telefonino attaccante. Inviava se stesso tramite MMS file ai numeri di telefono che trovava in rubrica e rispondeva automaticamente a tutti i messaggi in ingresso e MMS. Inoltre copiava se stesso sulle schede microSD
- **Lasco and CommWarrior (2005).**
Questi worms comunicavano via bluetooth o via MMS.
