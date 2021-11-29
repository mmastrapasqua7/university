# Magnitude data

Ogni cella contiene un valore aggregato di una **quantità di interesse** rispetto alla tabella. E' un valore non-negativo riportato in sondaggi e censi. La distribuzione di questi valori è soggetta spesso a skewness attacks

La limitazione dei danni è affidata al prevenire gli **outliers**

## Suppression rules: primary suppression

Come per il conteggio, vanno soppresse

**Primary suppression**:
- p-percent rule
- pq ruke
- (n, k) rule

Sono regole per identificare celle sensibili verificando la difficolta di un rispondente nel stimare i valori riportati da un altro rispondente **troppo accuratamente**

### p-percent rule

Disclosure avviene quando posso stimare il contributo di un rispondente ad un certo livello di accuratezza

Una cella è sensibile quando il valore inferiore superiore del valore della cella può essere stimato entro una certa soglia p. 

**Una cella è protetta se**:

$\sum_{i=c+2}^{N} x_i \ge \frac{p}{100} x_1$

Anche scritta come 

$TOT - (c + x_1) \ge p$

- $c$: dimensione coalizione di rispondenti che vuole sapere dati di un altro rispondente
- $c+2$: tutti tranne la coalizione e il valore alto che vogliono inferire
- $x_1, ..., x_N$: tutti i valori dei rispondenti in ordine decrescente
- $x_1$ è il valore più grande, **lo voglio stimare**

Assunzione:
- conoscenza non a priori riguardo i valori dei rispondenti, non molto reale

### pq rule

In questa variante invece si tiene conto della conoscenza a priori tramite il parametro $q$ che rappresenta l'accuratezza di un rispondente a stimare i valori di un altro rispondente prima della pubblicazione (p < q < 100)

**Una cella è protetta se**:

$\frac{q}{100} \sum_{i=c+2}^{N} x_i \ge \frac{p}{100} x_1$

Anche scritta come

$TOT - (c + x_1) \ge \frac{p}{q}$

E' la stessa del p-percent, infatti se q=100 diventa come la p-percent (q=100 vuol dire nessuna conoscenza a priori, punto debole del p-percent)

### (n, k) rule

Indipendentemente dal numero di rispondenti in una cella, se un numero $n$ di rispondenti contribuisce a una gran percentuale $k$ % del totale, allora la cella è considerata sensibile

Esempio: (n, k) = (2, 70)
- se 2 persone guadagnano più del 70% del totale, le loro celle sono sensibili

## Suppression rules: secondary suppression

2 possibilità una volta trovate le celle sensibile:
- ristrutturo e collasso celle
- sopprimo cella

ma anche le celle non sensibili non devono essere soppresse per evitare la stima accurata. Prima di tutto
- posso risolvere la disequazione riguardo il totale su righe e colonne
- posso inferire dalle unioni di celle soppresse

### Audit

Se vengono pubblicati i totali delle somme su righe e colonne, le celle soppresse a livello primario e secondario possono essere derivate. Quello che devo fare è garantire che la selezione delle celle complementari risulta nella **minima perdita d'informazione**

Una via è quella di **mantenere segreti i valori dei parametri** delle regole come p-percent e nk.


