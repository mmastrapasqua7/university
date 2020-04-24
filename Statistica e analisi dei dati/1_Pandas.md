## Series Pandas

#### Creazione

```python
import pandas as pd

# from file
series = pd.read_csv('/path/to/file.csv', sep=';', index_col=0)['Column name']

# from lists
names = ['One', 'Two', 'Three']
values = ['X', 'Y', 'Z']
series = pd.Series(values, index=names)

# from reader
with open('/path/to/file.csv', 'r') as file:
	reader = csv.reader(file, delimiter=';', quotechar='"')
	lists = list(reader)[1:]

values = [int(l[7]) for l in lists]
names = [l[0] for l in lists]
series = pd.Series(values, index=names)
```

#### Uso

```python
series_index = series.index
series_values = series.values

value = series.loc['Index value']
value = series.iloc[42]
index = series.index.get_loc('Index value')

subseries = series.loc['Index value 1':'Index value 2']
subseries = series.iloc[45:55]
subseries = series.loc[series > 2000] # query on values
subseries = series.loc[(series > 10) & (series < 90)]
subseries = series.sort_index()
subseries = series.sort_values(ascending=False)
subseries = series.between(150, 220)

values_absolute_frequence = series.value_counts()
modified_series = series/100
modified_series = series.apply(lambda element: element/100)
new_series = series1 / series2
```

## Dataframe Pandas

Un dataframe è una collezione di Pandas Series che hanno lo stesso indice, ed è quindi un insieme di osservazioni di vari caratteri per una popolazione di individui

#### Creazione

```python
import pandas as pd

dataframe = pd.DataFrame.from_csv('/path/to/file.csv', sep=';')

dataframe = pd.read_csv('/path/to/file.csv', sep=';')

dataframe = pd.crosstab(index=dataframe['Column name'],
						columns=['Name you want for column'],
						colnames=[''],
						normalize=True) # True = relative frequences

```

#### Uso

```python
dataframe_index = dataframe.index
dataframe_columns = dataframe.columns
dataframe_values = dataframe.values

series = dataframe['Column name']

dataframe_row = dataframe.loc['Index value']
dataframe_rows = dataframe.loc['Index value 1':'Index value 2']

dataframe_row = dataframe.iloc[1]
dataframe_rows = dataframe.iloc[0:10]

new_dataframe = dataframe[dataframe['Column name'] > 2000] # query on values
new_dataframe = dataframe.sort_values(by='Column name', ascending=False)
new_dataframe = dataframe.sort_index()

modified_dataframe = dataframe.apply(lambda p: np.round(p, 2))
```
