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

## Dataframe Pandas

Un dataframe è una collezione di Pandas Series che hanno lo stesso indice, ed è quindi un insieme di osservazioni di vari caratteri per una popolazione di individui

#### Creazione

```python
import pandas as pd

dataframe = pd.read_csv('/path/to/file.csv', sep=';')
```

#### Uso

```python
dataframe_index = dataframe.index
dataframe_columns = dataframe.columns
dataframe_values = dataframe.values

dataframe_series = dataframe['Column name']

dataframe_row = dataframe.loc['Index value']
dataframe_rows = dataframe.loc['Index value 1':'Index value 2']

dataframe_row = dataframe.iloc[1]
dataframe_rows = dataframe.iloc[0:10]

new_dataframe = dataframe[dataframe['Column name'] == 'Value']
```
