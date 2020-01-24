# Testing funzionale e OO?
Il test di integrazione riguarda il ricomporre i moduli finali, aggregandoli pian piano, ma funziona se tra i moduli c'e' una chiara struttura gerarchica. Nell'OO invece non c'e' piu' una scomposizione successiva. Problema di integrazione delle parti.
- E' possibile trovare dei sottoinsiemi significativi
	- use cases (unita' di testing) e scenari
	- copertura thread e messaggi
		- stimolo una classe con input e vedo fin dove si propaga
	- integro funzionalita'
	- diagramma a stati di sottoinsiemi

# Software Inspection (verifica)
- Tecnica manuale per individuare e correggere gli errori basati su di una attivita' di gruppo, senza eseguirlo, senza basarsi sul funzionamento.
	- Esempio: errori comuni, partendo da una classe di errori critica nel mio software: uso tanti puntatori, strutture dati complesse, concorrenza...
	- La faccio in gruppo cosi' ho piu' occhi
- Fagan Code Inspections (sottotipo di Software Inspections)
	- la piu' diffusa di tecnica di ispezione
	- estesa anche alla raccolta requisiti

## Ruoli
### Moderatore
preso a prestito da un altro progetto, coordina il meeting, sceglie i partecipanti. Meglio avere uno esterno per non avere preconcetti o precondizioni

### Readers, Testers
Cerco di leggere il software parafrasandolo in linguaggio naturale, cercando dei difetti

### Autore
Anche se non e' la persona piu' adatta a testare il codice, infatti e' li per rispondere a qualunque domanda/dubbio dei testers ("Autore cosa vuoi dire qui?")

## Processo
### Planning
Sceglie i partecipanti e fissa gli incontri (Persone tutte diverse)

### Overview
Fornire background e assegnare ruoli in base al software (presentazione)

### Preparation
Attivita' svolte offline per la comprensione del codice o della struttura del sistema

### Inspection
Trovare il maggior numero di anomalie (difetti).
- al massimo 2 sessioni di 2 ore al giorno (e' gia' tanto)
- circa 150 loc/h
- Sperimentalmente e' efficacie, piu' efficacie di un impegno pari a quello del testing di unita' funzionale

Approccio: parafrasare linea per linea
- risalire allo scopo del codice a partire dal sorgente
- possibile anche test a mano (mentale/su carta)

Trovare e registrare gli errori trovati (MA NON CORREGGERLI)

#### Checklist
Quali sono gli errori da cui partire? Ce ne sono una sottoclasse molto frequente. Divise in:
- Funzionalita'
- Uso daati
- Controllo
- Computazione
- Manutenzione
- Chiarezza

Esempio:
- Ogni modulo ha una singola funzione?
- Le costanti sono tutte maiuscole?
- I puntatori sono tutti non typecasted?
- Usi non standard non documentati?
- Ci sono commenti nelle parti critiche?

Le checklist possono evolvere man mano che si fa ispezione e si trovano nuovi tipi di errori

##### Funziona?
- Processo rigoroso e dettagliato
- Basato su accumulo di esperienza, si automigliorano
- Aspetti sociali del Processo
- Si considera l'intero dominio dei dati

##### Limiti?
- Livello del test: solo a livello di unita'
- Non e' incrementale, ma a cascata (ripeto da capo tutto quanto se cambio codice)
> LAW 17: L'ispezione del codice incrementa produttivita', qualita' e struttura del software

#### Struttura di incentivi
La mente umana ha bisogno di incentivi per trovare errori, per attenzione, per freschezza mentale.
- I difetti trovati non devono essere utilizzati per valutare il programmatore
	- Il programmatore non e' incentivato a nascondere difetti
- I difetti trovati dopo l'ispezione sono usati per la valutazione personale
	- Il programmatore e' incentivato a trovare tutti i difetti durante l'ispezione (collaborazione)

Attenzione: un revisore puo' stare tranquillamente seduto a non fare nulla
- Variante:
	- Scegliere revisori con aadeguata esperienza
	- L'autore fa domande al revisore (Checklist)
		- Il revisore dovendo rispondere e' costretto a partecipare

#### Automazione dell'ispezione
Esistono supporti a questa tecnica prettamente manuale
- Formattazione
- Riferimenti (checklist, standard)
- Reverse engineering (navigabilita' codice, rappresentazione architettura)
- Annotazioni, comunicazioni
- Guida al processo e rinforzo

### Rework
Durante la fase di ispezione e' facile che saltino fuori errori. Non si correggono gli errori durante l'ispezione. L'autore si occupa dei difetti individuali a fine riunione

### Follow-UP
Reispezione

## Qual e' il migliore tra le varie tecniche?
Ispezione vs Test Funzionale vs Test Strutturale

Tanti articoli presi in considerazione, ognuno dice risultati diversi. L'indicazione e' quello di farli tutti (prendo tutto insieme). Dato che le tecniche trovano errori diversi in diverse situazioni, e' meglio farle tutte o un sottoinsieme. Problema: non posso fare solamente questa attivita' perche' richiede tanto tempo
> LAW 20: La combinazione di tecniche diverse, anche non a livello approfondito, sorpassa la singola tecnica (e' migliore)

Lo scopo dell'XP e' proprio questo: creare una code inspection durante la codifica (pair programming, due cervelli sullo stesso codice)

# Debugging
- Mira a localizzare e rimuovere le anomalie di malfunzionamenti trovati in precedenza nel testing
- Non deve esserre usato per trovare i malfunzionamenti
- L'attivita' e' definita per un programma e un insieme di dati che causano il malfunzionamento
	- DEVE ESSERE RIPRODUCIBILE (difficile per app concorrenti)
	- **Va verificato che il malfunzionamento non sia dovuto a specifica errata**

## Problemi e tecniche
Difficile stabilire la relazione anomalia-malfunzionamento
- Voglio guardare denntro l'esecuzione del programma
- Non esiste una relazione biunivoca tra anomalie e malfunzionamenti

## Approcci
- incrementale: permette di limitare la parte in cui ricercare il difetto
- produzione degli stati intermedi dell'esecuzione del programma

### Tecnica Naive
Introduco delle println per stampare valori intermedi delle variaabili in una funzione
- e' molto facile da applicaare
- e' buona per una panoramica generale e veloce predebugging
- e' lento: aggiungere, ricompilare e poi disfarsene, laborioso e lungo (e devo ricordarmi di buttarle via)
- poco flessibile

#### Tecnica Naive avanzata
- ```#ifdef``` in C
- ```assert```
- funzionalita' del linguaggio in generale

### Core Dump (dump della memoria)
consiste nel produrre un immagine esatta della memoria dopo ogni esecuzione del codice
- non richiede modifica codice
- difficile per la differenza tra rappresentazione astratta dello stato e la rappresentazione fornita dallo strumento (struttura dati vs. registri di memoria, troppo machine-oriented)
- mole di dati enorme e inutile

### Debugging simbolico
Gli stadi intermedi sono prodotti usando una rappresentazione compatibile con quella del linguaggio usato
- Sono rappresentati come strutture dati, niente piu' machine-oriented, rappresentazione utile al programmatore
- Forniscono ulteriori strumenti (watch o spy monitor) che permettono di visualizzare gli stadi intermedi in maniera selettiva (breakpoint)

### Debugging per prova
Non solo visualizzio ma anche l'esame automatico degli stati ottenuti
- strumenti per verificare la correttezza degli stati intermedi
	- watch condizionali

## Debugger
- singolo passo
- entra ed esci da una funzione
- modifica contenuto variabile
- modifica codice
	- non sempre possibile perche' necessita la ricompilazione ma poi si prosegue dal punto di modifica
- rappresentazione grafica dei dati

# E' possibile automatizzare il debugging?
Qualcuno ci ha lavorato...

## Delta debugging (differential debuggin)
- Si parte da 2 versioni dei programmi che nel test di regressione falliscono (due funzioni si comportano in modo diverso per la stessa condizione)
- 1 versione che funziona
- usato (testato) per **compilatore gcc**

# Vantaggi gruppo di test autonomo
- Aspetti tecnici
	- maggiore specializzazione
	- conoscenza della tecnica e degli strumenti
- Aspetti psicologici
	- distacco dal codice
		- test indipendente dalla conoscenzaa del codice
		- attenzione ad aspetti dimenticati
	- indipendenza della valutazione

## Svantaggi
- Aspetti tecnici
	- progressiva perdita di capacita' di progetto e codifica: mi rende piu' difficile il testing
	- minor conoscenza dei requisiti
- Aspetti psicologici
	- possibile pressione negativa sul team di sviluppo
	- possibile gestione scorretta delle responsabilita'

## Alternative
- Rotazione del personale
	- permette di evitare progressivo depuramento tecnico dovuto a eccessiva specializzazione
	- permette di evitare svuotamento dei ruoli
	- aumenta i costi di formazione
	- aumenta le difficolta' di pianificazione
- Condivisione del personale
	- permette di supplire a scarsa conoscenza del prodotto in esame
	- aumenta le difficolta' di gestione

# Modelli statistici
- relazione statistica tra
	- metriche e presenza di errori
		- es: se il modulo e' stato scritto da X persone diverse allora...
	- numero di errori per classe

E' possibile predire distribuzione degli errori per modulo
- non da indicazione su cosa non testare, ma su dove concentrarsi
> LAW 24: (PARETO) l'80% degli errori si concentra nel 20% dei moduli
