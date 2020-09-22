# Dati

- ## Quantitativi
  
  L'esito della misurazione e' una quantita' numerica. Di norma non ha senso considerare un singolo valore, ma intervalli di possibili valori osservabili
  
  esempio: tempo di percorrenza, altezza, velocita'
  
  - ### Classificazione
    
    - #### Discreti / Continui
    
    - #### Singoli / Intervalli
  
  - ### Grafici
    
    - istogramma (anche qui il vero misuratore e' l'area, ma se le barre hanno la stessa base allora le aree sono proporzionali all'altezza)

- ## Qualitativi
  
  I dati sono una misurazione effettuata scegliendo un'etichetta a partire da un insieme disponibile
  
  esempio: nome proprio, sesso, colore capelli, intelligenza
  
  - ### Classificazione
    
    - #### Booleani o binari
      
      - ##### Binari
        
        esistono due possibili etichette
      
      - ##### Booleani
        
        presenza o assenza di una proprieta'
      
      esempio: sesso e' binario, fumatore e' booleano
    
    - #### Nominali
      
      i valori non sono tra loro confrontabili (**i binari sono un caso particolare dei nominali**). Due osservazioni o sono uguali o sono diversi, unico rapporto esistente
      
      esempio: sesso, nome, luogo di nascita
    
    - #### Ordinali
      
      e' possibile stabilire una relazione d'ordine tra i valori osservabili
      
      esempio: intelligenza (bassa, media, alta)
  
  - ### Grafici
    
    - a barre
    
    - a torta (aree proporzionali alla frequenza)
    
    - a bastoncini

---

## Trasformazione dei dati

### Cambio di intervallo da (a, b) a (c, d)

$$
x \mapsto x' = c + \frac{d - c}{b - a} * (x - a)
$$

### Standardizzazione

$$
x \mapsto x' = \frac{x - \bar{x}}{s_x}
$$

- proprieta' x'
  - media: 0
  - varianza: 1

---

## Linguaggio

- **popolazione**: insieme completo di oggetti. A volte e' troppo grande per essere studiato

- **campione**: sottogruppo della mia popolazione. Per ottenere informazioni sulla popolazione, questo campione deve essere rappresentativo. Il miglior modo per ottenere la rappresentanza e' scegliere a caso

## Frequenze e grafici

- **frequenza assoluta**: conteggio del numero di volte che una data osservazione occorre in un campione. Utile quando il numero di differenti osservazioni non e' troppo grande tipo dati qualitativi, meno spesso per quelli quantitativi.

- **frequenza relativa**: frazione dei casi in cui quell'osservazione occorre. E' utile da usare quando il numero di osservazioni e' variabile da un campione all'altro che voglio mettere a confronto.

- **frequenza cumulata**: puo' essere calcolata quando esiste una relazione di ordine per i valori del carattere. Considero i dati dal piu' piccolo al piu' grande, e considero  l'i-esimo valore come la somma delle frequenze di tutti i valori da 0 a i. Il numero totale di casi corrisponde all'ultimo valore della frequenza cumulata

- **frequenza cumulativa empirica / ripartizione empirica**: funzione costante a tratti
  
  $$
  \hat{F}(x) = \frac{1}{n} \sum_{i=1}^{n} I_{(-\infin, x_i]}(x)
  $$

- **diagramma di Pareto**: unione di frequenza e frequenza cumulata. Ordino i dati per frequenza in modo decrescente, uso il grafico a barre per le frequenze e un grafico poligonale giustapposto. Evidenzia gli elementi piu' rilevanti

- **frequenza congiunta**: considero due o piu' caratteri alla volta nelle frequenze, per vedere se i valori di tali dati siano piu' o meno collegati tra loro. Attenzione: in caso di dati quantitativi, e' opportuno usare intervalli invece di singoli valori

- **frequenza marginale**: frequenze del carattere corrispondente, calcolate sulle singole righe o colonne di una tabella di frequenza congiunta

- **diagramma di dispersione**: quando ho due serie con un medesimo indice posso considerare di fare un diagramma di dispersione. Permettono di vedere visivamente se esistono relazioni che collegano due caratteri.
