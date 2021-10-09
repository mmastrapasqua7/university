# Reti di petri temporizzate
problemi non solo riguardo la concorrenza, ma riguardo il tempo. In queste reti il tempo influisce sul sitema, determinandone la correttezza (esempio: se una transazione scatta in un determinato momento invece che in un altro ne determina la correttezza o la scorrettezza di essa)

## Modellare sistemi hard real-time
- il tempo e' un fattore essenziale in moltissime applicazioni
- Hard-Real time significa che bisogna soddisfare dei vincoli temporali senza errori
	- controllo di centrali nucleari
	- controllo di volo
	- controllo di processi industriali
- e' un formalismo in cui la parte temporale e' esprimibile

## Modelli temporali
esistono diverse proposte sulla maniera migliore per aggiungere il tempo (deterministico alle reti di Petri)
- ritardo sui posti
- ritardo sulle transizioni
- tempi di scatto sulle transizioni
	- unici o multipli
		- unici: alla transizione viene associato un valore singolo
		- multipli: alla transizione vengono associati piu' possibili valori: tra questi si scegliera' poi il tempo effettivo di scatto della transizione
	- fissi o variabili
		- intervalli costanti
			- definito staticamente
		- intervalli variabili
			- l'insieme dei tempi di scatto puo' variare dinamicamente
			- TBnets: l'insieme dei tempi di scatto puo' variare dinamicamente
			- High Level TPnet: gli insiemi dei tempi di scatto sono definiti come funzioni dei timestamps getttoni che abilitano la transizione
	- assoluti o relativi
		- intervalli relativi
			- i tempi di scatto possono essere espressi solo in termini relativi al tempo di abilitazione
		- intervalli assoluti
			- tempi di scatto possono essere espressi in termini relativi a tempi assoluti e/o al tempo dei singoli gettoni che compongono l'abilitazione

### Tempo sui posti
il tempo associato ai posti indica il tempo che un gettone deve rimanere nel posto stesso prima di potere essere considerato come parte di una abilitazione
- Delta: rappresenta la durata minima di permanena del gettone nel posto. Non posso fare foto del sistema

### Tempo sulle transizioni
il tempo associato alle transizioni puo' essere usato per indicare due cose diverse
- un ritardo di scatto
- il momento in cui lo scatto avviene

#### Spostare tempo dei posti alle transizioni
Con questo modello posso facilmente rimappare una rete con ritardo sui posti con un ritardo sulle transizioni, semplicemente aggiungo due posti, Pstart e Pend, e una transizione con il ritardo voluto

### Modelli misti
- tempo sui posti e sulle transizioni (delay & firing)

**DURATA vs. MOMENTO DELLO SCATTO**
- Durata (ritardo sulla creazione dei gettoni)
	- le transizioni scattano non appena possibile
	- gli scatti hanno una durata fissa
- Momento dello scatto (ritardo sul consumo dei gettoni)
	- le transizioni scattano in un momento fissato (in diverse maniere dai diversi modelli)
	- lo scatto e' istantaneo
	- **spostare durata di una transizione a tempo di scatto**
		- se riesco a farlo posso usare solamente il momento dello scatto per rappresentare anche la durata
			- anche qui, basta prendere la durata della transizione T e aprirla in 2 transizioni nuove: Tstart e Tend, con in mezzo uno stato P che modella il fatto che sta avvenendo lo scatto di T0: Ho ottenuto la durata usando il ritardo
		- metto un timer 0 sulla prima transizione, e il timer effettivo sulla seconda

## Time Basic nets (Ghezzi)
### Informale
- tempo associato alle transizioni
- vengono associati:
	- degli insiemi di tempi di scatto possibili
	- definiti in maniera dinamica
	- come funzioni che possono fare riferimento a tempi assoluti e ai tempi dei singoli gettoni

- i gettoni non sono anonimi (timestamp) (etichetta temporale)
- tempo di abilitazione (enab) = il massimo tra il timestamp dei gettoni che compongono la tupla abilitante (enabling tuple)
	- tupla abilitante: l'insieme dei gettoni che mi stanno abilitando quella transizione
	- enab: il massimo tra un insieme dei gettoni, ovvero una tupla
	- non posso abilitare una transizione t a un tempo T0 se enab di una tupla abilitante di t e' > T0 (non ha senso)
- insieme dei tempi di scatto
	- non possono essere minori del tempo di abilitazione (una transizione non puo' scattare finche' non e' abilitata dal tempo)
- tempo di scatto = scelto all'interno del set dei possibili timestamp di tutti i gettoni
	- quando una transizione scatta al tempo T, incluso nell'intervallo del tempo di abilitazione, distrugge i gettoni (sempre archi di peso 1) e per ogni posto in uscita, crea 1 nuovo gettone con timestamp associato uguale al tempo di scatto scelto

### Formale
Sestupla <P, T, 0(teta);F, tf, m0>
- [P,T; F]: come reti di petri normali
- 0(teta): insieme numerico (dominio temporale) (Naturali, Reali, Campi finiti)
- tf: funzione che associa a ogni transizione una funzione temporale Tft
	- dove Tft(en) e' un sottoinsieme di 0(teta)
		- en e' una **tupla abilitante**
		- prende teta e mi restituisce il sottoinsieme usato dalle transizioni
- m0: P -> {(timestamp, multiset(timestamp)) | timestamp appartiene a teta}
	- e' un multiset che esprime la marcatura iniziale

### La marcatura iniziale deve rispettare una regola
**AXIOM 1** monotonicita' rispetto alla marcatura iniziale
- tutti i tempi di scatto di una sequenza di scatto devono essere non minori di uno qualunque dei timestamp dei gettoni della marcatura iniziale
- la marcatura deve essere consistente: non deve contenere gettoni prodotti nel futuro

**AXIOM 2** monotonicita' dei tempi di scatto di una sequenza
- tutti i tempi di scatto di una sequenza di scatti devono essere ordinati nella sequenza in maniera monotonicamente non decrescente
- consistenza con la proprieta' intuitiva:
	- il tempo non torna indietro
- due o piu' transizioni possono scattare nello stesso istante:
	- azioni concorrenti simultanee
	- granularita' temporale piu' piccola delle necessita' del modello

**AXIOM 3** Divergenza del tempo (non-zenonicita')
- non e' possibile avere un numero infinito di scatti in un intervallo di tempo finito
- consistenza rispoetto a proprieta' intuitiva del tempo
	- il tempo avanza, non si ferma

**AXIOM 4** Marcatura forte iniziale
- il massimo tempo di scatto di tutte le abilitazioni della marcatura iniziale deve essere maggiore o uguale del massimo timestamp associato ad un gettone della marcatura
- la marcatura iniziale deve essere consistente con la nuova semantica
- il gettone non avrebbe potuto essere creato a un istante successivo a quel timestamp senza che prima fosse scattata la transizione (entro il suo tempo massimo)

**AXIOM 5** Sequenza di scatti forte (STS)
- una sequenza di scatti MWTS che parta da una marcature forte iniziale e' una sequenza di scatti forte se per ogni scatto, il tempo di scatto della transizione non e' maggiore del massimo tempo di scatto di un'altra transizione abilitata
- una transizione abilitata **DEVE** scattare entro il suo massimo tempo di scatto, se non viene disabilitata prima da un altro scatto

### Semantica temporale debole (weak WTS)
- Una transizione puo' scattare solo in uno degli istanti dalla sua funzione temporale
- Una transizione non puo' scattare prima di essere stata abilitata
- Una transizione anche se abilitata non e' forzata a scattare
	- Utile per modellare eventi solo parzialmente definiti
	- Eventi che dipendono da componenti non modellati o modellizzabili
		- Una decisione umana, un guasto

### Semantica temporale monotonica debole (monotonic weak MWTS)
- sequenze di scatti che soddisfano gli assiomi 1 e 3 sono chiamate sequenze ammissibili in semantica debole (WTS)
- sequenze di scatti che soddisfano gli assiomi 1, 2 e 3 sono chiamate sequenze ammissibili in semantica monotonica debole (MWTS)
	- con la MWTS salta una proprieta' importante delle reti di petri: non posso piu' guardare il mio angolino, ma devo rimanere sincronizzato con tutto il resto della rete, come se fosse tutto coeso, globale, devo guardare l'ultimo scatto eseguito. Perdo localita'
- sequenze di scatti che soddisfano gli assiomi 1, 2, 3, 4 e 5 sono dette sequenze ammissibili in semantica forte (STS)

**TEOREMA WTS = MWTS**
- per ogni sequenza di scatti debole s esiste almeno una sequenza di scatti monotonica debole ottenibile per semplice permutazione delle occorrenze degli scatti

### Semantica temporale forte (strong) (informalmente)
- Una transizione puo' scattare solo in uno degli istanti dalla sua funzione temporale
- Una transizione non puo' scattare prima di essere stata abilitata
- una transizione **DEVE** scattare ad un suo possibile tempo di scatto a meno che non venga disabilitata a livello topologico prima del proprio massimo tempo di scatto ammissibile

Semantica piu' diffusa di reti di petri (utile per sistemi deterministici)
- default in molto modelli temporizzati
