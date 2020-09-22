## Centralità

### Media campionaria

$$
\bar{x} = \frac{1}{n} \sum_{i=1}^{n} x_i
$$

- **proprieta**

$$
y_i = ax_i + b \newline
\bar{y} = a\bar{x} + b
$$

$$
w_i = \frac{f_i}{n} \newline
\bar{x} = \sum_{i=1}^{k} x_i w_i = w_1 x_1 + ... + w_k x_k = x_1 \frac{f_1}{n} + ... + x_k\frac{f_k}{n}
$$

$$
\sum_{i=1}^{n} (x_i - \bar{x}) = 0
$$

- **cons**
  - sensibile ai valori estremi, la spostano

### Mediana campionaria

$$
m = \begin{cases}
[(n+1)/2]^{th} &\text{se n dispari} \\
\\
\frac{(n/2)^{th} + (n/2 + 1)^{th}}{2}&\text{se n pari}
\end{cases}
$$

- **pros**
  
  - poco sensibile ai valori estremi

### Moda campionaria

Il valore o i valori con maggior frequenza assoluta (moda se singolo, valori modali se > 1)

- da vedere in pratica

---

## Distribuzione

### Varianza campionaria

$$
s^2 = \frac{1}{n - 1} \sum_{i=1}^{n} (x_i - \bar{x})^{2}
$$

- **proprieta**

$$
y_i = a x_i + b \newline
s^{2}_y = a^{2} s^{2}_x
$$

- **cons**
  
  - l'unita' di misura e' al quadrato, poco significativa

### Deviazione standard campionaria

$$
s = \sqrt{\frac{1}{n-1}\sum_{i=1}^{n}(x_i-\bar{x})^2} = \sqrt{s^2}
$$

- **proprieta**

$$
y_i = a x_i + b \newline
s_y = |a|s_x
$$

- **pros**
  
  - l'unita' di misura e' uguale a quella dei dati

---

## Eterogeneita

Nel caso di variabili qualitative nominali la varianza e gli altri indici da essa derivati non si possono calcolare (infatti non sono calcolabili la media né la mediana né altri valori numerici di riferimento dai quali calcolare le distanze). È comunque necessario avere un **indice che misuri la dispersione della distribuzione delle frequenze**, detta **eterogeneità**. In particolare diremo che una variabile si distribuisce in modo eterogeneo se ogni suo valore si presenta con la stessa frequenza

### Indice di eterogeneita di Gini

$$
I = 1 - \sum_{i=1}^{s} f_i^2 \\
\text{} \\
I \in [0, \frac{s-1}{s}]
$$

- **proprieta**
  
  - **0**: eterogeneita minima (omogeneita massima), ovvero 1 singolo valore distinto ha la frequenza massima, con frequenza relativa = 1, tutti gli altri hanno frequenza 0
  
  - **(s - 1) / s**: eterogeneita massima (omogeneita minima), ovvero tutte le osservazioni hanno la medesima frequenza

#### Indice di eterogeneita di Gini normalizzato

$$
I' = I * \frac{s}{s - 1} \\
\text{} \\
I' \in [0, 1]
$$

### Entropia

$$
H = -\sum_{i=1}^{s} f_i \log{f_i} \\
\text{} \\
H \in [0, log(s)]
$$

- **proprieta**
  
  - **0**: eterogeneita' minima (omogeneita' massima), 1 singolo valore con frequenza massima (caos = 0)
  
  - **log(s)**: eterogeneita' massima (omogeneita' minima), tutte le osservazioni hanno la medesima frequenza (tanto caos)

#### Entropia normalizzata

$$
H' = H * \frac{1}{\log s} \\
\text{} \\
H' \in [0, 1]
$$

### Alberi di decisione

Gli indici di eterogeneita' sono alla base degli alberi di decisione, un classificatore di oggetti. Un albero di decisione **assegna oggetti a classi**, dove **un oggetto è descritto tramite un'osservazione che consiste in un vettore di valori per degli attributi prefissati**.

Il procedimento di classificazione procede nel modo seguente

1. si considera la **radice dell'albero, cioè l'unico nodo a cui non arrivano frecce** e che è contrassegnato da una condizione che coinvolge i valori di uno o più attributi per l'oggetto che si vuole classificare. A seconda del valore di questa condizione, si percorre una delle due frecce partenti dalla radice.

2. Se il nodo a cui si arriva è un nodo terminale (**una foglia**), in tale nodo è indicata la classe assegnata all'oggetto, altrimenti il nodo riporta un'altra condizione da valutare, iterando il comportamento precedente fino a che non si raggiunge una foglia e quindi si determina una classe per l'oggetto.

E' necessario decidere la condizione da inserire nella radice dell'albero. La scelta viene fatta considerando una serie di possibili condizioni, valutando per ognuna il modo in cui i dati risulterebbero suddivisi nei due nodi sottostanti la radice. Si può quindi utilizzare l'indice di Gini per quantificare quanto sia buona l'omogeneità: più l'indice sarà basso, più le osservazioni saranno omogenee.

Una volta scelto l'attributo si puo' mantenere fisso e considerare valori diversi per la soglia, al fine di trovare il valore che minimizza l'indice di Gini medio (e quindi corrisponde al caso di migliore omogeneità)

Il risultato ottenuto deve metterci in guardia: non necessariamente infatti un buon compoartamento degli alberi di decisione sui dati utilizzati per costruirli è associato a un analogo comportamento nell'*indurre* etichette per dati nuovi

---

### Percentili

- da vedere in pratica

---

## Correlazione

### Covarianza campionaria

$$
cov(x_i, y_i) = \frac{1}{n-1} \sum_{i=1}^{n}(x_i - \bar{x})(y_i - \bar{y})
$$

### Coefficiente di correlazione campionaria

$$
r_{x,y} = \frac{cov(x_i, y_i)}{s_x s_y} \\
\text{} \\
r_{x,y} \in [-1, 1]
$$

- **proprieta**

$$
w_i = a x_i + b \quad z_i = c y_i + d \qquad  \forall i = 1 ... n \newline
r_{wz} = r_{xy}
$$

---

## Concentrazione

In presenza di variabili che rappresentano beni condivisibili in una popolazione, come per esempio la ricchezza, ci si può chiedere quanto la variabile sia equamente distribuita tra gli individui della popolazione, oppure quanto sia concentrata solo su un numero ridotto di osservazioni. Questo concetto **è diverso dalla varianza**, che misura la dispersione dei valori intorno a un valore medio

### Indice di concentrazione di Gini

$$
G = \frac{\sum_{i=1}^{n-1} (F_i - Q_i)}{\sum_{i=1}^{n-1} F_i} = \frac{2}{n-1} \sum_{i=1}^{n - 1} (F_i - Q_i)\\
\text{} \\
G \in [0, 1]
$$

dove

- dati ordinati
  
  $$
  a_1 \le a_2 \le ... \le a_n
  $$

- frequenza relativa cumulata all'i-esima osservazione (nell'indice divido per $F_i$ che e' il valore massimo che puo' assumere l'indice, in modo che diventi 1)

$$
F_i = \frac{i}{n} \newline
$$

- quantita' relativa cumulata fino all'i-esima osservazione

$$
Q_i = \frac{\sum_{k=1}^{i} a_k}{n\bar{a}}
$$

- **proprieta**
  
  - **0**: concentrazione minima, ovvero tutti gli elementi assumono lo stesso valore
    
    - $a_1 = a_2 = ... = a_n = \bar{a}$

```vega-lite
{
  "description": "oogle's stock price over time.",
  "data": {
    "values": [
      {"x": 0, "y": 0},
      {"x": 1, "y": 1}
    ]
  },
  "mark": "line",
  "encoding": {
    "x": {"field": "x", "type": "quantitative", "title": "Fi"},
    "y": {"field": "y", "type": "quantitative", "title": "Qi"}
  }
}
```

- **1**: concentrazione massima, ovvero tutti i valori assumono valore 0 a parte uno
  
  - $a_1 = a_2 = ... = a_{n-1} = 0, \qquad a_n = n \bar{a}$

```vega-lite
{
  "description": "oogle's stock price over time.",
  "data": {
    "values": [
      {"x": 0, "y": 0},
      {"x": 0.9, "y": 0},
      {"x": 1, "y": 1}
    ]
  },
  "mark": "line",
  "encoding": {
    "x": {"field": "x", "type": "quantitative", "title": "Fi"},
    "y": {"field": "y", "type": "quantitative", "title": "Qi"}
  }
}
```

L'area compresa tra la bisettrice di 45 gradi e la curva $F_i - Q_i$ rappresenta l'area di concentrazione. Maggiore e' la concentrazione osservata, maggiore sara' l'area della differenza. Minore la concentrazione (quindi equidistribuzione), minore sara' l'area perche' la curva si posizionera' vicino la bisettrice.

---

## ANOVA (ANalysis On VAriance)

Ipotizziamo di avere a disposizione delle osservazioni di un medesimo attributo divise  in G gruppi. **Per valutare l'ipotesi che i valori delle medie nei vari gruppi siano sensibilmente differenti** è possibile applicare un metodo chiamato **ANOVA**. L'idea alla base di questo metodo è che **se non vi sono sostanziali differenze tra i gruppi considerati, allora calcolare la varianza all'interno dei gruppi non dovrebbe portare a un risultato molto dissimile da quello ottenuto effettuando il calcolo della varianza su tutti i dati a disposizione**.

$$
SS_T = SS_W + SS_B
$$

con rispettive varianze campionarie:

$$
S_T^2 = \frac{SS_T}{n - 1} \\
\text{} \\
S_W^2 = \frac{SS_W}{n - G} \\
\text{} \\
S_B^2 = \frac{SS_B}{G - 1}
$$

e quindi

$$
S_T^2 = S_W^2 + S_B^2
$$

**Possiamo utilizzare questa uguaglianza per validare o confutare l'ipotesi che le medie nei gruppi siano diverse**

Dove:

- media campionaria di tutte le osservazioni

$$
\bar{x} = \frac{1}{n} \sum_{g=1}^{G} \sum_{i=1}^{n_g} x_i^g
$$

- media campionaria all'interno del g-esimo gruppo

$$
\bar{x}^g = \frac{1}{n_g} \sum_{i=1}^{n_g} x_i^g
$$

- somma degli scarti **totali (Total)**

$$
SS_T = \sum_{g=1}^{G} \sum_{i=1}^{n_g} (x_i^g - \bar{x})^2
$$

- somma degli scarti **entro i gruppi (Within)**

$$
SS_W = \sum_{g=1}^{G} \sum_{i=1}^{n_g} (x_i^g - \bar{x}^g)^2
$$

- somma degli scarti **tra i gruppi (Between)**

$$
SS_B = \sum_{g=1}^{G} n_g (\bar{x}^g - \bar{x})^2
$$

### Variabilita' e centralita

#### Coefficiente di variazione

$$
s^* = \frac{s}{|\bar{x}|}
$$
