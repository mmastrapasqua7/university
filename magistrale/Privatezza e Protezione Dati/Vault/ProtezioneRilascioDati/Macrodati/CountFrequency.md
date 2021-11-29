# Count/Frequency

Ogni cella contiene un numero, un conteggio, o la percentuale dei rispondenti sul totale

## Sampling

Faccio un **campionamento e prevengo di fare il censo** che è totale. Viene applicato un peso da moltiplicare al singolo individuo per rendere la scelta dell'individuo meno identificabile. I pesi vengono nascosti. Le stime sul campione però devono avere una certa **accuratezza**

## Special rules

Specifico il **livello di dettaglio** che può mostrare la tabella. Le regole speciali le applico in certi casi e in dipendenza del tipo di tabella
- **Intervalli**
	- Income a intervalli di 5,000 $
- **Combinazione/Ristrutturazione**
	- Faccio il merge di alcune righe

## Threshold rules

Una cella è sensibile quando il numero di rispondenti è minore di tot. Quando è sensibile, la cancello
- **Restructuring**
- **Cell suprression**
	- **Primary suppression**: la cella soppressa
	- **Complementary suppression**: devo sopprimere un'altra cella altrimenti riesco a ricostruire la cella dai totali marginali. Anche con la soppressione secondaria non è facile garantire sicurezza. Si usano tecniche per la selezione come
		- Linear programming
		- Audit techniques
- **Random/Controlled rounding**
	- **Random**
		- **Random**: la somma dei valori per riga/colonna è diverso dal totale
		- **Controlled**: faccio enforcement che il totale sia uguale alla somma
	- **Controlled**
- **Confidentiality edit**
	- Usato per proteggere dati di lunga data, a distanza regolare: rilasci multipli. Come faccio? **Le statistiche vengono cambiate cambiando i dati in INPUT!**
		- Meccanismo:
			1. Prendo un sample dai record originali (10%)
			2. Cerco un match su un'altra tabella di tutt'altra origine ma nella stessa forma
			3. Faccio lo stesso per l'altra tabella in quale ho fatto match, altro sample di 10%
			4. Faccio lo **swap** di attributi sui record che matchano
			5. Uso i dati dopo lo swap e produco la tabella, cambiamenti minimi