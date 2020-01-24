# POLICY (politiche di sicurezza)
## SECURE DESIGN PRINCIPLES
- **KISS (economy)** keep it simple and small
- **fail-safe** access based on permission rather than execution
- **complete mediation** check every access, every time
- **open design** ABSOLUTELY NO "security through obscurity" (Kirkoff principle applicato oltre la crittografia)
- **separation of privileges** separation increases robustness
- **least privilege level** gain user minimal needed privileges to accomplish a task (minimo indispensabile, il necessario)
- **least common mechanism** minimize common resources, minimaze interference among users
- **psychological acceptability** keep mechanism simple or user will bypass it because of difficultness and lazyness

## DEFINIZIONI
- **RISCHIO** = pericolo * danno = probabilita * danno. Il rischio e' una misurazione che vede ai due estremi la SICUREZZA e il PERICOLO.

- **ASSET** beni di un sistema. Comprende sia beni hardware che beni software, oltre a caratteristiche intrinsiche al sistema come disponibilita', non-repudiation ecc... La valutazione di un asset (o bene) e' misurata in termini di:
	- costo del rimpiazzamento
	- fatturato perso
	
- **VULNERABILITA** punti deboli del sistema che possono essere sfruttati per causare danni. I maggiori repo di vulnerabilita' sono: CVE, BugTraq etc. Le piu' comuni vulnerabilita':
	- lack of input validation
	- unnecessary privileges
	- software's known flaws
	- weak access control
	- weak firewall / protection system	

- **CLASSIFICAZIONE VULNERABILITA**
	1. **CRITICAL** automatic exploitation available
	2. **MODERATE** exploit mitigated by configuration
	3. **LOW** exploit extremely difficult

- **THREAT** azioni degli avversari, danni che vogliono arrecare per danneggiare il sistema. Gli obiettivi sono quelli definiti dalla sicurezza: confidenzialita', integrita', disponibilita'.

	**THREAT CLASSIFICATION (threats - risk)**
	- **DISCLOSURE** snooping, wiretapping (intercettazione)
	- **DECEPTION** (forzare l'accettazione di dati falsi) active wiretapping, modification, spoofing, repudiation of origini, denial of receipt
	- **DISRUPTION** (interrompere o stoppare servizi online), active wiretapping, denial of service (DoS)
	- **USURPATION** (controllo non autorizzato di parte del sistema) modification, spoofing, delay
	
- **POLICY (politica di sicurezza)** documento che definisce gli obbiettivi e la politica di un sistema di sicurezza. E' una specifica che va implementata tramite un **MECCANISMO DI SICUREZZA**. I meccanismi assicurano le politiche.
	- **SOGGETTI**
	- **OGGETTI**
	- **AZIONI**
	- **PERMESSI**
	- **PROTEZIONI**
	
	Una policy partiziona il sistema in due stati
	- **SECURE STATE**
	- **UNSECURE STATE**

> Un sistema sicuro inizia la sua vita in uno stato sicuro e non entra mai in uno stato insicuro.

- **SECURITY MANAGEMENT (ISO 17799)**
	-	establishment of security policy
	- secuirity infrastructure
	- asset classification and control
	- physical and environmental security
	- personnel security
	- communication and operation management
	- access control
	- system development and maintenance
	- business continuity and planning
	- compliance

## MULTILEVEL SECURITY MODEL
- **ACCESS CONTROL CLASSIFICATION**
	- **DISCRETIONARY (DAC)** utenti individuali settano i permessi di accesso per autorizzare o negare l'accesso a oggetti. Ogni utente determina i permessi per gli altri utenti.
	- **MANDATORY (MAC)** meccanismi di sistema settano i permessi di accesso agli oggetti e gli utenti non possono alterare questi permessi. Un amministratore setta le regole sugli utenti per l'accesso agli oggetti.
	- **ORIGINATOR CONTROLLED (ORCON)** chi crea un oggetto controlla i permessi di accesso su quell'oggetto. 

- **ACCESS CONTROL MODELS (famous)**
	- **Bell-LaPadula (BLP)**
	- **BIBA**
	- **Clark Wilson**
	- **Chinese Wall**

- **CONFIDENIALITY POLICY** ha a che fare col flusso di informazioni. Il gol di questa politica e' prevenire la distribuzione non autorizzata di informazioni. Ha origini nel campo militare, soprattutto nei sistemi database militari, dove c'e una classificazione netta e multilivello (confidential, secret, top-secret etc). Questo tipo di policy e' detta **multilevel secure**, sinonimo di **MAC**.

	**EXAMPLE: Bell-LaPadula(BLP)**
	- **LEVELS**
		- top-secret
		- secret
		- confidential
		- unclassified
	- **READING INFORMATION**
		- read up disallowed
		- read down allowed
	- **WRITING INFORMATION**
		- writes up allowed
		- writes down disallowed
	- **PROBLEMS** al di fuori dell'ambito militare fisico, in quello informatico e' poco pratico. Esempio: la gestione della memoria ha bisogno dei permessi di lettura e scrittura a tutti i livelli. Per cui questo meccanismo di gestione va inserito nel **TCB (Trusted Computer Base)**. Questo porta a un problema: tutti i sistemi affini, come backup, recovery e altri legati alla memoria devono essere tutti spostati nel TCB. Alla fine la TCB diventa enorme e difficile da verificarne la sicurezza.

> Data can only be ready by a principal whose privilege level is greater or equal than the data's classification

- **INTEGRITY POLICY** ha come goal quello di preservare l'integrita' dei dati, ovvero l'accesso a dati che non possono essere modificati in modo improprio. Confidentiality e Integrity hanno due concetti distinti:
	- **confidentiality** who can read a message
	- **integrity** who can write or alter it

	I principi:
	- **SEPARATION OF DUTY** 
	- **SEPARATION OF FUNCTION** developer department separated from production department
	- **AUDITING** recovery and accountability, who performed what

	**EXAMPLE: BIBA Integrity Model**
	- soggetto puo' alterare oggetti a livello minore o uguale al proprio (BLP)
	- un soggetto che puo' osservare X e' permesso alterare oggetti dominati da X (sotto X)

	**EXAMPLE: Clark Wilson Integrity Model** ha a che fare con i sistemi che performano transazioni. I principi sono:
	- l'integrita' del sistema e' preservata a ogni esecuzione di una transazione
	- transazioni well-formed portano il sistema da uno stato coerente a un altro

## MULTILATERAL SECURITY MODEL
Modelli di sicurezza usati quando a uno stesso livello di importanza o di sicurezza sono presenti piu' categorie di soggetti distinti tra loro.
- **COMPARTMENTATION** usato dalle intelligence, vengono usate delle parole chiave (codewords) come Ultra, Crypto, Olimpic ecc...
- **Chinese Wall Model** descrive meccanismi usati per prevenire il conflitto di interessi nella pratica professionale. Esempio: voglio investire dei soldi tramite la banca, e per farlo vado da piu' banche per sapere che prezzi e quali vantaggi mi offrono. Le due banche non devono comunicare tra loro, altrimenti si genererebbe un conflitto di interessi tra le due. Questo modello procede quindi:
	- controllo accessi di ogni classe
	- controllo di scrittura ad ogni classe per assicurare che le informazioni non vengano passate violando le regole
	- permettere sanitized data di essere letti da chiunque
- **British Medical Association (BMA) Model** descrive il flusso di informazioni permesso dai medici professionisti per i dati clinici, per prevenire che troppe persone abbiano accesso a dati che identificano un individuo, esempio le cure che fa, le medicine che prende ecc. 
	- ogni oggetto (record clinici) devono essere marcati con un access control list che identifica tutte le persone e gruppi che hanno accesso a quell'oggetto
	- se un medico vuole aggiungere un altro medico a quella lista di accesso, deve avere i permessi per farlo
	- il paziente deve essere notificato dal medico responsabile dei nomi della lista di accesso che hanno i suoi record quando e' aperto
	- le informazioni derivate da un oggetto A possono essere aggiunte a un record B se e solo se l'ACL di B e' interamente contenuta nell'ACL di A

## OTHER
- **Roled-Based Access Control** e' un evoluzione della nozione di permessi basati sui gruppi (come i filesystem)
	**COMPONENTI**
	- **RESOURCES** documenti, reti, database, stampanti ecc...
	- **USER** entita che desidera avere accesso alle risorse dell'organizzazione per effettuare tasks
	- **ROLE** e' una collezione di utenti con funzioni e responsabilita' simili all'interno dell'organizzazione
	- **PERMISSION** descrive un metodo consentito per accedera a una risorsa
	- **SESSION** consiste nell'attivazione di un sottoinsieme di operazioni performate su un oggetto (come aprire un file, inizializzare la connessione alla rete) 






















