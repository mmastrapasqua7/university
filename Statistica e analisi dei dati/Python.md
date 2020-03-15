Prima di ogni foglio .ipynb:

  ```python
  %matplotlib inline

  import csv
  import numpy as np
  import matplotlib.pyplot as plt
  import pandas as pd

  plt.style.use('fivethirtyeight')
  plt.rc('figure', figsize=(5.0, 2.0))

  with open('data/heroes.csv', 'r') as heroes_file:
    heroes_reader = csv.reader(heroes_file, delimiter=';', quotechar='"')
    heroes = list(heroes_reader)[1:]
  ```

## Series Pandas

##### Creazione Serie Pandas:

  ```python
  # un particolare carattere
  years = [int(h[7]) if h[7] else None for h in heroes]
  names = [h[0] for h in heroes]
  first_appearance_series = pd.Series(years, index=names)
  ```

  Va specificato prima il carattere osservato, poi l'indice. Devono essere due liste della stessa lunghezza.

##### Accesso Serie Pandas:

  ```python
  first_appearance_series.loc['Warp'] # indice
  first_appearance_series.loc['Warp':'Venompool'] # slice di indici (dx incluso)
  first_appearance_series.loc['Warp':]
  first_appearance_series.loc[first_appearance_series > 2000] # query

  first_appearance_series.iloc[46] # posizione
  first_appearance_series.iloc[45:55] # slice di posizioni (dx escluso)
  first_appearance_series.iloc[[1, 42, 47]] # specifiche posizioni tramite lista
  first_appearance_series.iloc[[1970 <= y < 1975 for y in first_appearance_series]] # list comprehension sulla serie

  first_appearance_series.index # lista di tutti gli indici
  first_appearance_series.values # lista di tutti i valori

  first_appearance_series.index.get_loc('Wonder Girl') # posizione dell'indice nella serie
  ```

##### Sort Serie Pandas:

  ```python
  first_appearance_series.value_counts() # sort in base alla frequenza
  first_appearance_series.sort_index() # sort in base all'indice
  first_appearance_series.sort_values() # sort in base ai valori
  first_appearance_series.sort_values(ascending=False)

  ```

##### Frequenze assolute Serie Pandas:

  ```python
  first_appearance_series.value_counts()
  ```

##### Somme dei valori Serie Pandas:

  ```python
  first_app_abs_freq = first_appearance_series.value_counts()
  sum(first_app_abs_freq.loc[1960:])
  sum(first_app_abs_freq.loc[1960:1997])
  sum(first_app_abs_freq.loc[:2020])
  ```

##### Operazioni sulle Serie Pandas

  ```python
  height_series = pd.Series([float(h[4]) if h[4] else None for h in heroes], index=names)
  weight_series = pd.Series([float(h[5]) if h[5] else None for h in heroes], index=names)

  height_series.apply(lambda h: (h / 100)**2) # funzione applicata a ogni valore
  indice_massa_corporea_series = weight / height_series
  ```

## Dataframe Pandas









## Pyplot

Disegnare grafici con Pyplot:

  ```python
  first_app_abs_freq = first_appearance_series.value_counts()
  x, y = first_app_abs_freq.index, first_app_abs_freq.values
  plt.bar(x, y)
  plt.show()
  ```

Limitare grafico a barre Pyplot:

  ```python
  plt.bar(x, y)
  plt.xlim(1935, 2020)
  plt.ylim(0, 19)
  plt.show()
  ```
