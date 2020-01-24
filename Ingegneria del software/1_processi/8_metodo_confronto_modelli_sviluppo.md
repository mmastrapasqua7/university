### Come confrontare i processi
Come posso trovare un processo che mi dia qualcosa in piu' nel futuro? Cosa mi puo' rendere migliore degli altri? Qual e' il migliore? Quale scegliamo? Qual e' quello da adottare in un particolare caso?
	- il management deve sapere valutare non solo il singolo progetto ma anche
		- stato corrente interno dell'organizzazione
		- programmare miglioramenti: diverse possibilita' di miglioramento, diverse zone.
		- confrontare varie possibilita'

E' un problema serio che e' molto frequente.

- **CMMI** (Capability Maturity Model Integrated) VALE PER LE AZIENDE

	Il software engineering institute ha predisposto un modello per determinare il livello di maturita' del processo del software di un'organizzazione (una misura di efficacia dell'applicazione di tecniche di ingegneria del softwaare). Puo' essere usato per identificare i passi utili per migliorare il processo. Identifica 22 aree di intervento (**process area**), definite tramite pratiche utili al raggiungimento di un obiettivo (goal). Queste 22 aree sono raggruppate in 4 categorie:

	- **ingegneria**
	- **gestione del processo**
	- **gestione del progetto**
	- **supporto**
		- **configuration management**

		lo scopo di questa process area ha come obiettivo mantenere l'integrita' del lavoro, stabilendo identificazione delle configurazioni, tool di controllo, bug tracking, tracciabilita'.

		- GOAL & PRATICHE
			- **SG = Specific Goal**
			- **SP = Specific Practices**
			- **GG = Generic Goal**
			- **GP = Generic Practices**

		- **GENERAL (di tutte le aree)**
			- GG 1: applica le specifiche
			- GG 2: ...

		- **SPECIFIC (del comunication management)**
			- SG 1 (SPECIFICI)

				come siamo messi? Qual e' la baseline per noi? Va diviso in 3 pratiche

				- SP
					1. identificare elementi di configurazione
					1. stabilire un sistema di gestione delle configurazioni
					1. creare la baseline (prima versione, punto di partenza, primo obiettivo, non posso andare avanti senza)

			- SG 2

				tracciare e controllare i cambiamenti

				1. tracciare pull request o changes.
				1. controllare elementi di configurazione

			- SG 3
				1. controllare l'integrita', tipo a fronte di commit i test e il sistema funzionano tutti.

	- **2 punti di viste: CAPACITA'**

		- **continuous**

			si giudicano le singole capacita'. E' il primo metodo. Vengono valutate le capacita' delle varie aree singolarmente o eventualmente raggruppate per categorie. Area per area ricavo i singoli valori (totale 22 voti per 22 aree). Mi da una bella vista della situazione ma mi rende ancora difficile inquadrare le cose. Non e' sufficiente. A ogni area posso dare un valore su una scala da 0 a 5:

			- **SCALA**

				0. incompleta
				0. eseguita
				0. gestita
				0. definita
				0. gestita quantitivamente
				0. ottimizzata

		- **staged**

			si giudica la maturita'. Vengono raggruppate le aree in modo da definire un **cammino di miglioramento** basato su 5 livelli.

			- un livello viene raggiunto se sono state coperte tutte le aree specifiche con un livello di capacita' sufficiente
			- **LIVELLI**
				1. il primo livello (lvl 1) e' il livello degli eroi (**heroes**). Il successo o non successo di un progetto sono gli sviluppatori, buoni e cattivi. Ogni livello corrisponde a: "deve essere coperto almeno da un livello x" dove x e' il livello a cui e' stata collocata l'area. Tutto dipende su 2 persone
				1. il secondo livello dice che non devo dipendere dai singoli. Se mi muore l'eroe sono supportati da altri superiori. Ci sono 7 aree che rientrano in questo livello, e devono essere soddisfatte almeno a livello 2. Se non le soddisfo, sono ancora a livello 1.
				1. il terzo livello aumenta il livello delle aree. Aumenta il numero delle aree interessate e contemporaneamente chiede che siano tutte raggiunte a livello 3. E' un grossissimo gradino. < 1% delle aziende e' a questo livello. Praticamente tutte le aziende sono a livello 1, poche a livello 2, pochissime livello 3.
				1. il quarto livello chiede lo stesso del livello 3, ma servono 3 aree a scelta che devono essere portate a livello 4.
				1. il quinto livello e' come il 4: tutto a livello 3, ma almeno 3 aree a scelta devono essere portale a livello 5


> LAW 35: Processi maturi e disciplina personale migliorano la pianificazione e aumenta la produttivita

- **PSP** VALE PER GLI SVILUPPATORI SINGOLI
