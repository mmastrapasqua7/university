# Approcci testing
- chiamo un metodo e testo il risultato
	- certe volte non e' fattibile o sufficiente, serve vedere oltre (esempio: side effects, cambio di stato interno dopo l'esecuzione)
	- le cose si complicano quando il metodo di una classe chiama il metodo di un'altra classe da cui dipende. Non ha senso controllare solamente il metodo che chiamo, ma anche quello che chiama a sua volta (catena)
		- l'errore e' nella prima parte o nella seconda parte? Nella prima classe o nella classe da cui dipende?
- serve tagliare tutte le colonne del diagramma di sequenza, creare il meno possibile.

## Mocking Objects vs Stub
SUT (System Under Testing) deve svolgere un operazione, e nel farlo usa un **metodo** di altra classe DOC (Dependent On COmponent)
- testa lo stato del mio oggetto a fronte della chaiamata del **metodo stub**.
- instrumento il metodo mock che controlli che l'ho chiamato nell'ordine giusto coi parametri giusti
- mi basta avere una chiamata che controlli il protocollo di scambio chiamate tra le classi
- registratore di cosa e' successo (sono stato chiamato, prima questo poi quello), non piu' su cosa ho fatto, ma che scambio di messaggi ci e' stato

### Test doubles
e' un termine generico per un qualunque tipo di oggetto che viene messo al posto di quello reale al fine di permettere un'attivita' di testing. Motivazione:
- componente che non esiste ancora o non facilmente accessibile
- l'oggetto fornirebbe dei dati non deterministici o non prevedibili (tempo corrente, temperatura corrente)
- l'oggetto puo' presentare delle situazioni difficilmente riproducibili (errori di trasmissione, esaurimento memoria)
- l'oggetto e' lento

#### Dummy Objects
oggetti che sono passati in giro ma mai veramente usati (dummy implementations)
- non-null
- potrei avere solo un'interfaccia e non una classe
- potrei avere solo costruttori complessi

#### Stub Objects
Oggetti che forniscono risposte preconfezionate alle sole chiamate fatte durante il testing
- non mi interessa avere l'implementazione di tutto, ma solo quello che mi serve e che chiamo

#### Mock Objects
- non ho un controllo diretto
- oggetto che instrumento e controllano le chiamate

#### Spy Objects
Prendo un oggetto vero e aggiungo instrumentazione per fare i controlli che mi servono. Oggetti che instrumento e controllano le chiamate di oggetti reali

#### Fake Objects
oggetti che danno vera implementazione di un DOC ma usando qualche scorciatoia, in maniera non realistica o non installabile
-	database in memoria invece che reale
- soluzione inefficiente per casi di dimensione grande

##### FRAMEWORK: MOCKITO
Libreria (framework) molto pulita e potente per costruire mock objects **e non solo**. Di tutti i metodi mi da un'implementazione base (ritorna il valore zero di ogni tipo (false per boolean, 0 per int))

```java
// DUMMY
MyClass dummy = mock(MyClass.class);
List<MyClass> SUT = new ArrayList<MyClass>();
SUT.add(dummy);
assertThat(SUT.size()).isEqualTo(1))
```

```java
// STUB
MyClass stub = mock(MyClass.class)

when(stub.getValue(0)).thenReturn(4);
when(stub.getValue(1)).thenReturn(7, 3); // ordine di valori restituiti
```

```java
// MOCK
InOrder io = InOrder(mock);
io.verify(mock).getValue(0); // verifica chiamata
io.verify(mock, times(2)).getValue(1); // verifica chiamata 2 volte
```

Non garantisce, potrebbe dare dei falsi negativi. Puo' essere d'aiuto per capire l'architettura del progetto, modificando il test o il codice del programma

```java
// SPY
MyClass spy = spy(new MyClass());
// ...
assertThat(SUT.size()).isEqualTo(1));
InOrder io = InOrder(mock);
io.verify(mock).getValue(0); // verifica chiamata
io.verify(mock, times(2)).getValue(1); // verifica chiamata 2 volte
```

###### Stubbing
```java
when(mockedObj.methodName(args)).thenXXX(values);
    args: values | matchers | argumentCaptor
		    matchers: anyInt(), argThat(is(closeTo(1.0, 0.0001)))
		thenXXX: thenReturn | thenThrows | thenAnswer | thenCallRealMethod
		values

doXXX(values).when(mockedObj).methodName(args)
// sembra uguale ma quella prima non funziona in caso di metodi void
```

###### Verifying
```java
verify(mockedObj, howmany).methodName(args)
    howmany: times(n) | never | atLest(n) | atMost(n)
		    times(n) = times(1) se non specificato
verifyNoMoreInteractions(mockedObj)

verify(mock).doSomething(arg.capture());
assertEquals("John", arg.getValues().getName())
```

### Test funzionale
(come TDD) non c'e' conoscenza del codice (blackbox). Viene basato sulle specifiche, il mio test diventa specifica operativa.
- Puo' essere l'unico approccio possibile (test di validazione di committente esterno).
- Permette di identificare errori non sintetizzabili con criteri strutturali
	- esempio: non ho implementato una funzione, cammino di flusso dimenticato

OBIETTIVI
- Funzioni scorrette o mancanti
- Errori di interfaccia
- Errori di prestazioni

- ci si concentra sul dominio delle informazioni invece che sulla struttura di controllo

#### Tecniche
- metodi basati sui grafi
- suddivisioni in classi di equivalenza
	- category partition: divido il mio dominio in diverse parti (classi) secondo la mia logica, all'interno delle quali specifico di dover trattare quelle classi con lo stesso dominio
- test di frontiera (analisi dei valori limite: MAX_INT, MIN_INT...)
- collaudo per confronto (test di non regressione): devo saper fare le stesse cose che la versione precendente riusciva a fare, ovvero deve passare stessi test / casi d'uso

### Test delle interfacce
- Tipi di interfacce
	- a invocazione con parametri
	- a condivisone di memoria
	- a metodi
	- a passaggio messaggi
- Tipi di errori
	- sbagli nell'uso di interfaccia
		- ordine o tipo parametri
	- fraintendimenti dell'interfaccia
		- assunzioni sbagliate
		- assenza di chiarezza precondizioni
	- errori di tempistica o di sincronizzazione

### Classi di equivalenza
- Si basa sulla suddivisione del dominio dei dati in ingresso in classi di dati, dalle quali derivare casi di test
	- una classe di dati e' un insieme i cui componenti dovrebbero essere trattati in maniera analoga al programma
- Si cerca quindi di individuare dati di test che rivelino eventuali errori

Una classe di equivalenza rappresenta un insieme di stati validi o non validi per i dati in input e un insieme di stati validi per i dati di output. Un dato puo' essere
- un valore
- un intervallo
- insieme di valori correlati

Esempio: PIN corretto, numero di 4 cifre qualsiasi != PIN
- Se ci si aspetta un valore in un intervallo, vengono definite una classe di equivalenza valida e due non valida
	- PIN: [100, 700]
		- Giusto: [100, 700]
		- Sbagliato: [0, 100), (700, 999]

**RIASSUNTO**
- Individuare input
- Classi di equivalenza
- i dati di test devono cercare di esercitare quante piu' combinazioni possibili tra le diverse classi di equivalenza
	- esiste un approccio specifico e molto utilizzato (+/- consigliato) per la definizione dei dati di test a partire da informazioni sul dominio
		- analisi valore limite

### Test di frontiera
- gli errori tendono ad accumularsi ai limiti del dominio
	- selezioni test con dati al limite
- e' complementare alle classi di equivalenza
	- non seleziono un elemento a caso della classe ma uno ai confini
