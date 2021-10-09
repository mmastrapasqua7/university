# VOCABOLI

- **SISTEMA**
Singolo prodotto (pc, smartphone), sistema operativo o di comunicazione, applicazioni, personale, clienti e utenti esterni

- **SOGGETTO**
Persona fisica o persona legale (compagnia)

- **ATTORE**
Persona, dispositivo, ruolo o ruolo complesso

- **ATTACCANTE**
{hacker, virus, worm, ...}

- **RETE**
Configurazione di individui interconnessi

- **RETE DI COMPUTER**
	- FISICA
	infrastruttura hardware che connette diversi terminali
	- LOGICA
	sistema che facilita lo scambio di dati tra applicazioni che non condividono fisicamente lo stesso spazio di memoria

- **MALWARE**
codice che si comporta in modo inaspettato per iniziativa del programmatore malizioso. Ha accesso a tutto ciò a cui ha accesso l'utente. Esempi: installazione di software corrotto (vedi caso vlc senza https), Java Applet o ActiveX control. Classificati nelle seguenti categorie:
	1. **HOST PROGRAM REQUIRED**
		- **TROJAN HORSE** programma con un effetto evidente / aspettato e un effetto nascosto. Appare normale come lo si aspetta ma l'effetto viola la politica di sicurezza. L'utente deve essere indotto all'esecuzione di un trojan horse.
		- **VIRUS** codice che si replica da solo, altera il codice normale con una versione infetta e non ha azioni evidenti ma cerca di rimanere nell'ombra. Se ci sono le condizioni per la diffusione, si inizia cercando posti in cui mettere le istruzioni del virus. Queste istruzioni dovranno essere eseguite dal calcolatore, per cui vanno inserite in posti mirati. Una volta fatto, viene passato il controllo (jump, goto) al programma infettato, che inizierà l’esecuzione del programma infettato. Esempio classico: si prende un file eseguibile, si lascia l’header integro ma all’indirizzo della prima istruzione da eseguire del vero programma, viene inserito il codice del virus. Il programma vero quindi viene shiftato per fare spazio a righe di codice del virus.
	1. **INDIPENDENT**
		- **WORMS** viene eseguito in maniera indipendente, non si nasconde all’interno di programmi. Propaga una copia funzionante su altre macchine. Esso porta con se un payload, che esegue task nascosti (backdoors, spam, ddos relays ecc…).
			- **FASI**
				- PROBING
				- EXPLOITATION
				- REPLICATION
				- PAYLOAD
			- **FORME**
				- MULTIPIATTAFORMA
				- MULTIEXPLOIT
				- RAPID DIFFUSION
				- POLYMORPHIC
				ogni worm copiato viene lievemente modificato con codice equivalente, con algoritmi di compressione e con cifratura
				- METAMORPHIC
				oltre a cambiare il suo aspetto, cambia il suo modo di agire in base agli stadi differenti della diffusione che ha raggiunto
		- **ROOTKIT** set di programmi installati su una macchina per mantenere nel tempo un determinato accesso, che può essere coi privilegi di sistema, nascosto dagli altri. Semplici: programmi user modificati (come ls, ps). Sofisticati: modificano il kernel stesso e quindi difficili da scovare dall’userland.
			- PERSISTENT
			si attivano ogni volta al boot
			- MEMORY BASED
			non ha codice persistente
			- USER MODE
			intercetta le chiamate alle api
			- KERNEL MODE
			intercetta le chiamate alle API native in kernel mode
			- VIRTUAL MACHINE MODE
			- EXTERNAL MODE
			bios, system management, direct hardware access
		- **SPYWARE** malware che colleziona una piccola porzione di informazioni alla volta senza essere scoperto dall’user. Possono essere keylogger, browser tracking e redirects di URL. Non si propagano autonomamente.


## ESEMPI DI MALWARE
- **DRIVE-BY-DOWNLOADS** exploit di bug di applicazioni per scaricare e installare malware da remoto. É una tecnica molto comune. La più utilizzata è quella dei browser, ovvero sfruttare bug dei browser per scaricare e installare malware senza il consenso ne la conoscenza da parte dell’utente. Questo metodo aspetta che l’utente visiti una determinata pagina per diffondersi a macchia d’olio su tutti gli utenti. Possono essere anche malware che non compromettono il sito, come ad esempio pubblicità malevola (malvertising).

- **CLICKJACKING** compresi click del mouse e keystrokes. Possono essere collezionati sia per inviare l’utente in un sito fasullo, sia per fare altro, come piazzare keylogger nelle pagine, per prendere nota delle password digitiate e inviarle a un computer dell’attaccante, oppure per piazzare dei bottoni sopra dei bottoni legittimi e quindi nascondendoli con la mimetizzazione.

- **RANSOMWARE** detiene il controllo di un sistema o dei suoi dati, chiedendo un riscatto per essere disabilitato. Disabilita servizi essenziali o disabilita l’uso del desktop per eseguire qualsiasi altra cosa. Cifra i file personali dell’utente.

- **BOTNET** collezione di macchine o dispositivi compromessi che girano un programma worm, trojan o backdoor, che sono sotto controllo di un unica infrastruttura, per cui rispondono tutte a uno stesso comando, una stessa console di controllo. Usate per lanciare DdoS, phishing, cracking di password ecc… Anche se ultimamente sono modificate per agire come peer-to-peer, ovvero basta un comando che i nodi comunicano tra loro il da-farsi

## CLASSIFICAZIONE VIRUS (per strategie di offuscamento)
- **ENCRYPTED** il virus sfrutta un algoritmo crittografico di tipo RSA per cifrare e decifrare la sua porzione di codice. All’interno del virus, vi è la chiave di decifrazione, e subito dopo le istruzioni cifrate. In questo modo, quando avviene l’esecuzione del programma, il virus decifra se stesso, e se si deve replicare, crea un paio di chiavi diverse da quelle attuali. In questo modo ho un pattern di bit sempre diverso → difficile da rilevare senza un pattern costante

- **STEALTH** costruito apposta per sfuggire ai controlli usuali di tutti gli antivirus o sistemi di protezione. Può usare mutazione del codice, compressione o tecniche di rootkit.

- **POLYMORPHIC** nel replicarsi, crea delle copie equivalenti del virus ma con istruzioni diverse, quindi porta a termine lo stesso compito in maniera diversa per creare pattern di bit differenti.

- **METAMORPHIC** si distingue dal polimorfo perché a ogni iterazione il virus riscrive se stesso completamente, usando più tecniche di trasformazione, aumentando la difficoltà.

- **BACKDOOR** punto di accesso segreto di un sistema, specifica UID o password che supera le normali procedure di sicurezza. Spesso usata dagli sviluppatori stronzi, possono addirittura essere incluse nei compilatori.

- **LOGIC BOMB** (inclusa in programmi legittimi) si attiva quando viene triggerata una specifica condizione (formata da più condizioni), come presenza / assenza di un file, di una chiave, di un url su internet. Quando scatta, danneggia il sistema, quindi file, interi dischi e altro.

- **ZERO-DAY EXPLOIT**
Ciclo di vita degli zeroday:

	1. Qualcuno scopre una vulnerabilità in un sistema
	1. Lo sviluppatore crea e distribuisce una patch a tale vulnerabilità
	1. Qualcuno scrive un exploit o un proof of concept
	1. La maggior parte dei sistemi vulnerabili applica la patch

*L’intervallo [3-4] è chiamato finestra di vulnerabilità. In caso di 0-day (zero day exploit) abbiamo che l’intervallo [2-3] <= 0, ovvero viene scritto prima l’exploit della patch. Nonostante una patch diventi pubblica, serve un intervallo di tempo prima che la maggior parte dei sistemi la adotti, per cui gli attacchi sono ancora possibili.*

- **APT** è in insieme di attacchi silenziosi e continui organizzati da una singola entità o da un gruppo verso uno specifico obiettivo (azienda, entità ecc…). Di solito gli APT prendono di mira aziende private e lo stato per motivi spesso politici. “A” per advanced, perché comprende una grandissima varietà di tecnologie di attacco, comprese applicazioni modellate ad-hoc. “P” per persistente, perché persistono per un lungo periodo nel tempo. “T” per threats, ovvero persone organizzate, preparate e ben finanziate che attaccano uno specifico obiettivo.
	- GOALS
		- Financial secrets
		- Intellectual property
		- National secrets
		- Infrastructures
		- Private personal information
	- TARGETS
		- Education
		- Governments
		- Financial services
		- High-tech
		- Aerospace
		- Energy
		- Chemical
		- Telecom
		- Healthcare

## STRUTTURA ESEGUIBILE (pseudocodice)
```
program Virus 1234567

main
	attach_to_program()
	if trigger_condition() then execute_payload()
	exec original program (goto/jump)

func attach_to_program()
	do
		file = get_random_program()
		attach Virus to file
	while first_program_line != 1234567

func execute_payload()
	// payload actions

func trigger_condition()
	return true if condition is true
```
l’entry point del programma infettato, quando sarà invocato, è proprio il main di questo pseudocodice virus. La prima linea di codice del programma è un marcatore speciale (flag) per indicare se il programma sia già stato infettato. Non serve solo a quello specifico virus ma può servire al singolo attaccante per capire se l’host è già una sua vittima di precedenti attacchi. Una volta eseguito il virus, il controllo passa al programma originale.

## VIRUS DI COMPRESSIONE
Viene compresso il file eseguibile in modo tale da avere programma infettato e programma pulito della stessa misura. Indistinguibili a livello di lunghezza.
- HOWTO
	1. Un programma infettato con un virus di compressione CV+P1’, e un 	programma pulito P2.
	1. Quando CV+P1’ viene lanciato, viene prima eseguita la 	porzione di codice del virus CV, che compie i seguenti step:
		1. trova il programma P2 non infettato, lo comprime e quindi riduce la sua lunghezza. Questo nuovo programma sarà P2’.
		1. una copia del virus CV viene incollata sopra la testa del programma pulito compresso P2’, che diventerà CV+P2’.
	1. il programma originariamente infettato, CV+P1’, viene decompresso e riportato alla sua misura originale, tornando P1.
	1. il programma originale decompresso P1 passa all’esecuzione. Ho nascosto!
