# Sicurezza
1. **Attacco**
come lamer / {grey,black}hat possono attaccare la rete
2. **Difesa**
come difenderci dagli attacchi di questi
3. **Progettazione**
come progettare e modellare una rete (quasi)immune agli attacchi

**NB: INTERNET NON È STATA PENSATA CONSIDERANDO LA SICUREZZA**
> A group of mutually trusting users attacched to a transparent network. [cit.]

# Sicurezza Informatica
è la protezione predisposta per un sistema informatico al fine di preservare 3 distinte cose (TRIADE)
1. **integrita'**
	- **dati**
	assicurare che dati e programmi sono stati modificati solo in una specifica e autorizzata maniera.
	- **sistema**
	assicurare che il sistema esegua le sue funzioni in maniera inalterata da manipolazioni volontarie/involontarie
2. **disponibilita'**
	- **dati**
	accesso tempestivo e affidabile
	- **sistema**
	il servizio esegue correttamente e non nega l'accesso a chi è autorizzato
3. **confidenzialita'**
	- **dati**
	le informazioni riservate non sono disponibili da utenti non autorizzati
	- **privatezza**
	gli individui possono controllare quale informazione può essere raccolta e come può 	essere comunicata (e anche a chi)

Questa triade (anche detta triade CIA) è definita da uno standard (sia da NIST FIPS 199 sia da RFC 4949). Altri standard famosi: ITU-T X.800

## Cause principali dei problemi di sicurezza
- elevata complessità dei sistemi, numero crescente di componenti
- competitività: poco tempo a disposizione, alto ritorno di investimento (ROI)
- elevato numero di dispositivi: un bug ha un'ampa risonanza nel mondo, e l'elevato numero di dispositivi può essere sfruttato per creare una botnet / warm (canale di diffusione)
- la correzione o la segnalazione dei bug è molto lenta e molto spesso nascosta
- errori umani

## Standard
Anche nella sicurezza informatica sono stati definiti degli standard che riguardano l'amministrazione e l'architettura di una rete con i suoi meccanismi di sicurezza. Tra i diversi enti che si occupano di questi standard troviamo:
- **NIST (National Institute of Standards and Technology)**
agenzia federale statunitense, la stessa che si occupa dei protocolli crittografici adottati globalmente. Si occupa infatti di misure scientifiche, standard e tecnologia.
	- **FIPS (NIST Federal Information Processing Standards)**
	- **SP (NIST Special Pubblications)**
- **ISOC (Internet Society)**
società di appartenenza professionale a cui partecipano organizzazioni globali e singoli individui. Responsabili degli standard di infrastutture di rete
	- **IETF (Internet Engineering Task Force)**
	- **IAB (Internet Architecture Board)**
Queste organizzazioni sviluppano standard di internet con le relative specifiche, ed esse vengono tutte pubblicate sotto il nome di
RFC (Requests for Comments).
- **ITUT-T (Internetional Telecomunication Union)**
organizzazione internazionale a cui fanno parte governi e settori privati. Si occupano di coordinare le reti di telecomunicazioni globali e i servizi. ITU-T è solamente 1 dei 3 settori che compongono la ITU, ed essi si occupano di standardizzazione di tutto ciò che copre la telecomunicazione.
- **ISO (Internetional Organization for Standardizations)**
federazione di standard nazionali.

## Modelli di attacco
1. **attacco al canale di comunicazione**
un attaccante si mette nel mezzo della comunicazione tra due sistemi, tipo host-host, host-server, server-server ecc...
2. **attacco a un servizio informatico in rete**
un attaccante si mette attivamente ad attaccare uno specifico servizio / host nella rete

## Tipi di attacco
1. **attivi**
	- si altera il flusso delle informazioni
	- si crea un flusso falso (replay attack, fingere di essere un'altra entità)
	- si impedisce l'accesso e l'utilizzo del sistema (DoS / DDoS)
2. **passivi (non alterano le informazioni in transito)**
	- accesso al contenuto dei messaggi / pacchetti in transito
	- analisi del traffico (frequenza e lunghezza rivelano la natura della comunicazione)

## Pratica
- **MECCANISMO**
indica che cosa si deve fare, descrive una data funzionalità che deve essere realizzata

- **POLITICA**
descrive quali scelte operare in risposta ad un evento. Indica quando e come applicare la funzionalità

- **POLITICA DI SICUREZZA**
asserzione su cosa è permesso e non è permesso fare

- **MECCANISMO DI SICUREZZA**
metodo / strumento / procedura per far rispettare una politica di sicurezza. È un processo che ha il fine di individuare, prevenire, ripristinare.
esempio:
	- POLITICA
	Un qualsiasi utente che ha accesso ad un file system non deve poter leggere il contenuto dei file di un altro utente

	- MECCANISMO
	```
	# chmod
	```

- **MECCANISMI DI SICUREZZA X.800**
	- **specifici**
	possono essere incorporati nell'appropriato livello per fornire servizi di sicurezza OSI. Esempio: Encipherment, Digital Signature, Access Control, Data Integrity, Authentication Exchange, Traffic Padding, Routing Control, Notarization.

	- **pervasivi**
	non sono specifici di un paritcolare servizio di sicurezza / livello OSI. Esempio: Trusted Functionality, Security Label, Event Detection, Security Audit Trail, Security Recovery.

- **SERVIZI DI SICUREZZA X.800**
servizio di elaborazione / comunicazione fornito da un livello ISO che 	incrementa la sicurezza del sistema di elaborazione ed il trasferimento dati. Sono destinati a contrastare gli attacchi alla sicurezza ed utilizzano uno o più meccanismi di sicurezza per fornire il servizio.

**SERVIZIO** | **MECCANISMO**
--- | ---
Access Control | Access Control (tipo HTTP OAuth)
Confidentiality | Encipherment, Routing Control
Data Integrity | Encipherment, Digital Signature, Checksum
Availability | Checksum, Authentication exchange

- **SUPERFICIE DI ATTACCO**
è la parte raggiungibile di un sistema, il "punto di contatto" per vulnerabilità sfruttabili dall'attaccante. Esistono varie superfici di attacco:
	- porte aperte, codice in ascolto su queste porte e porte di un determinato servizio web
	- servizi disponibili interni a un firewall
	- codice che processa dati in ingresso come documenti, xml, email e altro
	- interfacce utente, sql, web forms
	- un impiegato con accesso al servizio interessato con informazioni sensibili (può essere soggetto a social engineering, quindi sempre una superificie di attacco)

Tutte queste possibili superfici possono essere categorizzate in 3 tipi:
1. **superficie di rete**
vulnerabilità di una rete, come una LAN o una WAN, o addirittura Internet stessa. In questa categoria rientrano le vulnerabilità ai protocolli di rete.
2. **superficie di software**
vulnerabilità in un'applicazione, in un servizio o in un sistema operativo. In particolare è focalizzata su software per webserver
3. **superficie di persone**
vulnerabilità date dal personale, come social engineering, errori umani e fiducia

- **ALBERO DI ATTACCO**
è un albero ramificato gerarchicamente che rappresenta un insieme di tecniche potenziali per sfruttare vulnerabilità nella sicurezza di un sistema. Essi forniscono un metodo formale e metodico nel descrivere la sicurezza nei sistemi.

esempio:
```
APRIRE UNA CASSAFORTE
    • SCASSINARLA (impossibile)
    • SFRUTTARE UNA FALLA NELLA COSTRUZIONE (impossibile)
    • SEGARLA (possibile)
    • IMPARARE LA COMBINAZIONE (possibile)
        ◦ TROVARE LA COMBINAZIONE SCRITTA (impossibile)
        ◦ OTTENERE LA COMBINAZIONE DA UN BERSAGLIO (possibile)
            ▪ MINACCIARE (impossibile)
            ▪ RICATTARE (impossibile)
            ▪ FIDANZARSI (possibile, vedi 007)
            ▪ ASCOLTANDO DI NASCOSTO (possibile)
                • ASCOLTARE UNA CONVERSAZIONE (possibile)
                • PORTARE IL BERSAGLIO A DIRE LA COMBINAZIONE (impossibile)
```

- **STRATEGIA PER LA SICUREZZA**
	1. **specifica della politica (cosa fa questo schema di sicurezza?)**
	asserzioni formali di regole e pratiche che specificano o regolano come il sistema o un organizzazione provvede alla sicurezza per proteggere i dati sensibili e le risorse importanti
	2. **meccanismo di implementazione (come raggiunge l'obiettivo?)**
  Ci sono 4 vie di azione per questo:
		1. prevenzione (ideale) uno schema in cui nessun attacco è possibile o arriva a compimento. Più immaginario che reale.
		2. rilevamento ovvero un sistema di rilevamento di intrusioni non autorizzate in un sistema
		3. reazione ovvero il sistema reagisce in una determinata maniera quando è sotto attacco cercando di prevenire di causare danni o cercando di limitarli. Esempio: cloudflare per la reazione agli attacchi DDoS per prevenire la sospensione del servizio
		4. recupero per eliminare i danni e resettare lo stato delle macchine, esempio con un sistema di backup, per riportare l'integrità dei dati
	3. **assicurarsi della correttezza (funziona realmente?)**
	Per questo compito, il NIST Security Handbook (NIST95) definisce la garanzia o l'assicurazione come un grado di confidenza misurabile sia tecnicamente che operativamente. La valutazione è un processo di esaminazione del prodotto per verificarne il rispetto di determinati criteri, essa include fasi di testing, statistiche formali e tecniche matematiche
