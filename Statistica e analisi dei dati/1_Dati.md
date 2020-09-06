# Dati

- ## Quantitativi
  
  I dati sono una misurazione di una quantita' numerica
  
  esempio: tempo di percorrenza, altezza, velocita'
  
  - ### Classificazione
    
    - #### Discreti / Continui
    
    - #### Singoli / Intervalli
  
  - ### Grafici
    
    - istogramma (.hist(bins))

- ## Qualitativi
  
  I dati sono una misurazione effettuata con un'etichetta a partire dall'insieme disponibile
  
  esempio: nome proprio, sesso, colore capelli, intelligenza
  
  - ### Classificazione
    
    - #### Booleani
      
      presenza o assenza di una proprieta'
      
      esempio: sesso
    
    - #### Nominali
      
      i valori non sono tra loro confrontabili (**i booleani sono un caso particolare dei nominali**). Due osservazioni o sono uguali o sono diversi, unico rapporto esistente
      
      esempio: sesso, nome, luogo di nascita
    
    - #### Ordinali
      
      e' possibile stabilire una relazione d'ordine tra i valori osservabili
      
      esempio: intelligenza (bassa, media, alta)
  
  - ### Grafici
    
    - a barre (.plot.bar())
    
    - a torta (.plot.pie())

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
