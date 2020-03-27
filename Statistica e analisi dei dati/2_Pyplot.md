## Pyplot on Dataframes Pandas

```python
# a barre
series.plot.bar(legend=False)
plt.show()

# sovrapposizione punto punto
abs_freq1.plot(marker='o', color='blue', legend=False)
abs_freq2.plot(marker='o', color='pink', legend=False)
plt.show()

# sovrapposizione barre
abs_freq1.plot.bar(color='blue', legend=False, alpha=0.5)
abs_freq2.plot.bar(color='pink', legend=False, alpha=0.5)
plt.show()

# a torta
abs_freq.plot.pie('Nome grafico', colors=['pink', 'blue'])
plt.axis('equal') # 2D
plt.show()

# istogramma
series.hist(bins=50) # ampiezza classi
plt.show()

# punti
abs_freq_cum.plot(marker='o', legend=False)
plt.show()

# barre a valori multipli
multival_dataframe.plot.bar(color=['color1', 'color2'])
multival_dataframe.plot.bar(color=['color1', 'color2'], stacked=True) # sovrapposti

# diagramma di dispersione
dataframe.plot.scatter('Column name 1', 'Column name 2')
plt.show()

# box plot
series.plot.box(vert=False, whis='range', width=0.4)
plt.show()

# Q-Q plot
import statsmodels.api as sm

sm.qqplot_2samples(series1, series2, line='45')
plt.show()
```

## Pyplot standalone

```python
# a barre
x = abs_freq_series.index
y = abs_freq_series.get_values()
plt.bar(x, y)
plt.show()

# a bastoncini
plt.vlines(x, 0, y)
plt.show()

# istogramma

```
