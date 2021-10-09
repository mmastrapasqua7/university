# UML (Unified (Undefined) Modeling Language)
Unione di tre visioni diverse di tre guru diversi. Fondano una compagnia: Rational Rose. Alla fine diventano uno standard ISO.

- 1.0

	Scontro tra 3 convinzioni diverse. La prima versione infatti molte cose sono sovrapposte, pieno di roba.

- 2.0

	Metamodello che definisce formalmente i vari diagrammi

#### Diagrammi affrontati
- STATICA
	- Diagramma delle classi (statica)
- DINAMICA
	- Diagramma degli stati (effetti interni agli oggetti)
	- Diagramma use case (effetti esterni)
	- Diagramma di interazione
		- Diagramma di sequenza
		- Diagramma di comunicazione
	- Diagramma di attivita'
		- possono essere usati per rappresentare flussi di dati complessi a vari gradi di astrazione, ancora prima di realizzare le classi.

Colgono 3 aspetti diversi importanti

---

## Diagramma delle classi (Class Diagram)
> NB: cardinalita' 1..* vuol dire che un oggetto nasce con gia' presente un altro oggetto come riferimento. Se metto cardinalita' 1, gli oggetti sono legati dalla nascita

- nome della classe
- attributi
- metodi

Ci sono anche simboli per indicare il grado di protezione
- public (+)
- private (-)
- protected (#)
- package (~): **di default quando non scriviamo nulla (ne public ne private ne protected)**

Ogni font indica qualcosa di diverso
- corsivo
	- classi e metodi astratti
- sottolineato
	- metodi e attributi statici
		- a livello di classe invece che di istanza (non Object.x ma Class.x), sia metodi che attributi

Modella staticamente la struttura, l'architettura del progetto, specifricando le classi.

### Generalizzazione
- **Freccia piena bianca dal figlio al padre, dalla specializzazione alla specializzata**

**Relazione tra classi** (no cardinalita')
- IS_LIKE_A
- CAN_BE_A
- EREDITA_DA
- EXTENDS

E' un meccanismo che permette di definire una classe come specializzazione di una esistente
- senza ripartire da zero, ma per differenza rispetto a qualcosa

Permette il riuso del codice
- una classe eredita' tutto dalla sua classe
- puo' aggiungere nuovi concetti (attributi e metodi)
- puo' ridefinire metodi della classe generalizzata

Singola o Multipla?

Posso fare anche **overriding** per ridefinire l'implementazione dei metodi. Non posso modificare ne togliere attributi esistenti, posso solo aggiungerli.

Metodo astratto: in corsivo, *italico*, non e' stata data l'implementazione. Se una classe ha un metodo astratto allora e' incompleta, quindi la classe e' astratta. Non e' condizione necessaria (posso dichiararla astratta anche senza metodi astratti)

Una classe A specializzazione di una classe B, che livello di visibilita' ha rispetto ai segreti di B?
- Puo' servire permettere accesso ad un sottoinsieme dei campi privati. In questo caso si usa **protected (#)**.

### Associazioni
- **Linea tra due classi**
- label: nome della relazione
- ruoli: nomi attributi
- molteplicita': un'istanza della classe A puo' essere in relazione con tot istanze della classe B, sulla classe di arrivo

**Relazioni tra istanze delle classi**
- USES

Sono delle relazioni che l'implementazione deve supportare. Ogni volta che un oggetto deve interagire con altri oggetti... esiste una relazione tra le classi dei due oggetti

#### Navigabilita' di un associazione
- monodirezionale
	- uso la freccia
	- se A punta la freccia verso B, A puo' avere (90% casi, ognuno sceglie l'implementazione, deve essere preservata la relazione) un attributo per memorizzare B, l'inverso invece non e' richiesto (non necessario)
		- un attributo non e' sempre un associazione
- bidirezionale
	- non uso le frecce (linea dritta)
- riflessiva
	- vanno su oggetti della stessa classe. Puo' essere monodirezionale o bidirezionale

Tengo in un solo punto l'informazione tramite qualcosa (spesso un attributo), inutile ridondanza. Chi, quando e dove viene memorizzata l'informazione.
- ATTENZIONE: Nel diagramma UML non bisogna ripetere stessa cosa in due livelli di dettagli diversi.
	- Esempio: non devo scrivere un'associazione monodirezionale e specificare l'attributo che lo implementa, perche' e' come ripetere la stessa cosa 2 volte. Sono 2 livelli di astrazione che devono rimanere separati. (Write Once)

### Aggregazioni
**Rombo bianco al contenitore, freccia dritta al contenuto**

**Relazione tra istanze delle classi**
- IS_PART_OF
- IS_COMPONENT_OF

Anche nelle aggregazioni (e composizone) esiste la navigabilita'. Se non c'e' e' bidirezionale. Aggregazione: aggrega riferimenti a oggetti.

Esempio: squadra di calcio. Un calciatore e' parte di una squadra, ma non si esaurisce in esso, non e' solo fine alla squadra. E' solo parte della definizione di squadra ma puo' coesistere o esistere senza.

### Composizione
**Rombo nero al contenitore, freccia dritta al contenuto** -> PACKAGE in UML

**Relazione tra istanze delle classi**
- IS_COMPOSED_OF

E' un particolare caso di aggregazione: l'oggetto composito e' completamente responsabile delle sue parti le quali non possono avere relazioni con altre classi. **La cardinalita' lato contenitore e' sempre 1, sottointeso: i contenuti non possono essere condivisi**. Composizione: aggrega oggetto all'interno.

Esempio: aereo e motore di un aereo. Il motore puo' appartenere a un solo aereo. La vita del motore e' vincolata dalla vita dell'aereo. Coesistono e l'aereo e' responsabile.

### Dipendenze
**Freccia tratteggiata**

**Relazione tra classi** (NEGATIVA) (no cardinalita')

Non richiede l'esistenza di istanze delle classi che relaziona, quindi non viene rimappata su attributi di classe. Se qualcosa cambia in una dipendenza, cambia anche la mia classe. Non c'e' un riferimento esplicito nel codice, bisogna segnarselo nell'UML.

Esempio: classi file. Una per scrivere, l'altra leggere su file. Le classi non si conoscono, non hanno riferimenti, non sono compilate insieme, eppure dipendono una dall'altra: se cambio formato di scrittura file, la classe per leggere deve essere cambiata!

Cosa devo fare: Devo esplicitare le dipendenze in UML, poi devo tirarle fuori dalle classi e rendere esplicita la parte di dipendenza, eliminandola, quindi avendo tutto piu' chiaro anche senza UML.

### Interfacce
**Freccia piena bianca tratteggiata** oppure

**Notazione a lollipop con nome**.
**Dall'altra parte un gancio (stile ossa, robot)**

Possono essere considerate come un caso speciale di classi astratte (in UML). Non hanno implementazioni, solo dichiarazioni. Se un linguaggio non supporta l'ereditarieta' multipla, supportano l'implementazione di interfacce multiple.

---

## Use Case
- **USE STORY (XP)**
	- gli scenari sono descrizioni di come il sistema e' usato in pratica
	- Sono utili nella raccolta dei requisiti perche' piu' semplici da scrivere di affermazioni astratte di cio' che il sistema deve fare.
	- Possono essere usati anche complementarmente a schede di descrizioni (come esempi)

- **USE STORY**: caso specifico (test di accettazione che lo spiega)
- **SCENARIO**: test di accettazione

Gli use case **sono un'unione di user story**. Informale. Mi aiuta a raccogliere specifiche. Interazione tra mondo esterno e sistema. Una classe di funzionalita' fornite dal sistema, cioe' un astrazione di un insieme di scenari relazionati tra loro.
- diverse modalita' di fare un compito
- interazione normale e possibili eccezioni

Al suo interno vengono date, in maniera testuale non formalizzata, informazioni circa:
- PRE e POST condizioni
- flusso normale di elaborazione
- flusso eccezionale di elaborazione

Spesso vengono collegati ad altri diagrammi (Sequence, Activity) che ne spiegano il funzionamento

- **CRITICA**
	- raccolta specifiche trasversale all'architettura di sistema (modellazione con classi e oggetti). Non aiuta a pensare a oggetti.
		- Ma al cliente non gliene frega. La raccolta delle specifiche e' importante, non e' legata all'implementazione
		- Puo' essere difficile la traduzione in diagramma delle classi (architettura)

### Use Case UML
- identificazione attori
	- entita' esterne al sistema
	- interagisce col sistema
	- **fonte o destinatario di scambio di informazioni**

	Non e' per forza una persona, ma un **ruolo** che una persona puo' coprire
		- un utente
		- un altro sistema con cui interfaccio
		- una periferica hardware

- denominazione del tipo di interazione
- collegamento tra attori e casi d'uso

#### Come identifico Use Cases?
- posso partire dalle funzionalita' del sistema
- posso partire dagli attori (i beneficiari)
	- cosa fanno? Cosa vogliono?

#### Associazioni
- Use Case / Attori
	- uno use case deve essere associato ad almeno un attore
	- un attore deve essere associato ad almeno uno use case
	- esiste un attore detto primario (diverso dal beneficiario) che ha il ocmpito di far partire uno use case
	- generealizzazione
		- permette di esplicitare relazioni tra ruoli (tipo un ruolo ha tutti i permessi del sottoruolo)

- Tra use case
	- Include
		- parti comuni del sistema, le estraggo e le rendo uniche, comuni a piu' use case (come l'autenticazione: puo' avvenire in diversi punti del sistema con diversi attori. La fattorizzo)
	- Extend
		- vari casi di interazione (testing per casi specifici, eccezionali)
	- Generalizzazione
		- molto simile a extends
		- La differenza e' che non ho dei punti di estensione, ma sostituisco alcune parti della descrizione mentre eredito altre

---

## Diagramma di sequenza (Sequence Diagram)
Nettamente Object Oriented. Componente principale di questo diagramma: Oggetto. Dimensione temporale significativa.
- definiscono una interazione tra oggetti
- sono orientati ai messaggi
- esprimono la dimensione temporale

Chiarisce meglio le componenti interne di una use case, quindi va dentro l'implementazione. **non adatto a descrivere sistemi concorrenti (perche' non hanno un ordine determinato)**

**ELEMENTI**
- possono essere attori o oggetti del sistema
	- compaiono generalmente in cima al diagrama
		- per gli oggetti il nome dell'istanza e' facoltativo (viene identificata la classe)
			- utilizzo dei soli metodi statici
			- oggetto anonimo
- lifeline
	- indica la vita di un oggetto o attore
		- un oggetto puo' essere creato e/o distrutto durante la descrizione dell'interazione

**GRAFICA**
- **CREAZIONE E DISTRUZIONE** (box di attivazione)
	- Attivazione
		- e' espressa mediante un rettangolo sulla lifeline
			- attori sempre attivi per definizione (devo essere attivo per mandare messaggi)
		- esprime il fatto che l'oggetto e' attivo
- **MESSAGGI**
	- sono istanze di associazioni
	- possono essere di vario tipo
		- messaggi sincroni
			- chiamate di funzioni
			- l'oggetto chiamante si sospende in attesa di una 	risposta
		- messaggi asincroni
			- segnali
			- l'oggetto chiamante continua la sua esecuzione
	- **TIPI MESSAGGI**
		- freccia piena continua
			- chiamata sincrona
		- freccia vuota tratteggiata
			- ritorno, valore ritornato da chimata
		- freccia aperta (mezza) continua
			- chiamata asincrona
	- **DETTAGLI**
		- nome del metodo chiamato con eventuali parametri
		- numero di sequenza
			- se usato correttamente serve a dare una rappresentazione testuale dell'ordine temporale. Servono per Collaboration diagram, ovvero per fare da tramite da un diagramma all altro.
			- viene aggiunto automaticamente. Utile per mapping e ridondante
		- condizioni
			- guardia da soddisfare affinche' il messaggio venga effettivamente spedito
		- interazione
			- condizione di permanenza nel ciclo
	- **DIMENSIONE TEMPORALE**
		- un messaggio puo' avere un tempo di consegna. E' qualitativa, NON in scala
			- la linea sara' diagonale, non orizzontale
				- passa del tempo
			- e' possibile indicare in note gli istanti di spedizione e ricezione dei messaggi
				- constraint

---

## Diagramma a stati
...

---

## Diagramma di attivita' (Activity Diagram)
ha tutto in comune col diagramma a stati, ma vengono cambiati nomi e ridefinite certe regole sintattiche.
- gli stati vengono chiamati attivita'
- le transazioni non sono etichettate con eventi
- le azioni sono inserite dentro le attivita' (non a fronte di un eventi ma a fronte di un attivita')
- dentro le azioni posso scriverci qualsiasi cosa. **Le attivita' possono essere interne ed esterne al sistema**

E' molto flessibile per descrivere molte cose, fino agli algoritmi. Puo' descrivere cose ad alto livello oppure a basso livello.

### Swim lane
tante attivita' svolte da attori diversi. Per aumentare la chiarezza, vengono identificate delle corsie verticali per partizionare le attivita' al fine di rappresentare le responsabilita' delle singole attivita'.

### Per cosa li uso?
- flusso all'interno di un metodo con eventuali indicazioni di concorrenza
- il flusso di uno use-case (alternativo o ortogonale al sequence diagram)
- la logica all'interno di un business process

---

## Package
Non e' un vero diagramma. Usato per raggruppare classi o Use Case. Permette quindi un raggruppamento logico. Spesso indicato con la relazione IS_COMPOSED_OF. Raccolta dei requisiti.

---

## Componenti
Design e progettazione. Ragiona in termini di componenti fisici.
- File
- Libraries
- Executables
- Table
- Document

### Caratteristiche
- tipologie di componenti
- definisce una parte rimpiazzabile del sistema
- svolte una funzione ben determinata
- puo' essere strutturato gerarichicamente
- vengono indicate chiaramente
	- quali interfacce realizza (supporta)
	- relazioni di dipendenza e di composizione

---

## Diagramma di dislocamento (Deployment Diagram)
Permette di specificare la dislocazione fisica delle istanze dei componenti, ovvero sulle macchine fisiche (hardware)
- vista statica della configurazione a runtime
- aiuto agli installatori

Permette di specificare
- nodli del sistema
- collegamenti tra nodi
- dislocazione delle istanze di componenti all'interno dei nodi e le loro relazioni (come component diagram, ma tra istanze)

---

## Frame
Non sono un elemento esclusivo dei diagrammi di sequenza. Possono racchiudere un intero diagramma specificandone
- tipo
- nome
- confini

---

## Combination Fragment
E' possibile riferirsi ad altri Diagrammi
- si creano diversi livelli di astrazione a cui guardare i diagrammi
