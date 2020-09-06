## Centralità

### Media campionaria

$$
\bar{x} = \frac{1}{n} \sum_{i=1}^{n} x_i
$$

- proprieta'

$$
y_i = x_i + c \newline
\bar{y} = \bar{x} + c
$$

$$
y_i = c x_i \newline
\bar{y} = c \bar{x}
$$

$$
w_i = \frac{f_i}{n} \newline
\bar{x} = \sum_{i=1}^{k} x_i w_i = w_1 x_1 + ... + w_k x_k = x_1 \frac{f_1}{n} + ... + x_k\frac{f_k}{n}
$$

$$
\sum_{i=1}^{n} (x_i - \bar{x}) = 0
$$

- cons
  - sensibile ai valori estremi, la spostano

### Mediana campionaria

$$
m = \begin{cases}
[(n+1)/2]^{th} &\text{se n dispari} \\
\\
\frac{(n/2)^{th} + (n/2 + 1)^{th}}{2}&\text{se n pari}
\end{cases}
$$

- pros
  
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

- semplificata

$$
s^2 = \frac{1}{n - 1} (\sum_{i=1}^{n} x_i^2 - n\bar{x}^2)
$$

- proprieta'

$$
y_i = x_i + c \newline
s^{2}_x = s^{2}_y
$$

$$
y_i = c x_i \newline
s_y^2 = c^2 s_x^2
$$

- cons
  
  - l'unita' di misura e' al quadrato, poco significativa

### Deviazione standard campionaria

$$
s = \sqrt{\frac{1}{n-1}\sum_{i=1}^{n}(x_i-\bar{x})^2} = \sqrt{s^2}
$$

- proprieta'

$$
y_i = x_i + c \newline
s_x = s_y
$$

$$
y_i = c x_i \newline
s_y = |c| s_x
$$

- pros
  
  - l'unita' di misura e' uguale a quella dei dati

---

## Eterogeneita'

### Indice di eterogeneita' di Gini

$$
I = 1 - \sum_{i=1}^{s} f_i^2 \\
\text{} \\
I \in [0, \frac{s-1}{s}]
$$

- proprieta'
  
  - compreso tra [0, (s - 1) / s]
    
    - 0: eterogeneita' minima (omogeneita' massima), ovvero 1 singolo valore distinto ha la frequenza massima, con frequenza relativa = 1, tutti gli altri hanno frequenza 0
    
    - (s - 1) / s: eterogeneita' massima (omogeneita' minima), ovvero tutte le osservazioni hanno la medesima frequenza

#### Indice di eterogeneita' di Gini normalizzato

$$
I' = I * \frac{s}{s - 1} \\
\text{} \\
I' \in [0, 1]
$$

- proprieta'
  
  - compreso tra [0, 1]

### Entropia

$$
H = -\sum_{i=1}^{s} f_i \log{f_i} \\
\text{} \\
H \in [0, log(s)]
$$

- proprieta'
  
  - compreso tra [0, log(s)]
    
    - 0: eterogeneita' minima (omogeneita' massima), 1 singolo valore con frequenza massima (caos = 0)
    
    - log(s): eterogeneita' massima (omogeneita' minima), tutte le osservazioni hanno la medesima frequenza (tanto caos)

#### Entropia normalizzata

$$
H' = H * \frac{1}{\log s} \\
\text{} \\
H' \in [0, 1]
$$

- proprieta'
  
  - compreso tra [0, 1]

### Alberi di decisione

Gli indici di eterogeneita' sono alla base degli alberi di decisione, un classificatore di oggetti.

---

## Dispersione, simmetria

Quando le frequenze tendono a distribuirsi in modo simmetrico rispetto al valore della mediana campionaria si dice che il campione segue una distribuzione approssimativamente simmetrica

### Percentili

- da vedere in pratica

### Normali

Un insieme di dati si dice **normale** se il rispettivo istrogramma ha le seguenti proprieta':

- ha il punto massimo in corrispondenza dell'intervallo centrale
- forma una campana se ci spostiamo verso destra o sinistra (diminuisce gradualmente)
- e' simmetrico rispetto l'intervallo centrale

### Approssimativamente normali

Un insieme di dati si dice **approssimativamente normale** se il rispettivo istogramma e' simile a un'istogramma simmetrico e se l'insieme dei dati segue la seguente **REGOLA EMPIRICA**:

- approssimativamente il 68% delle osservazioni dista dalla media campionaria non più di 1 deviazione standard campionaria
- approssimativamente il 95% delle osservazioni dista dalla media campionaria non più di 2 deviazioni standard campionarie
- approssimativamente il 99.7% delle osservazioni dista dalla media campionaria non più di 3 deviazioni standard campionarie

### Bimodale

l'istogramma ha 2 massimi locali

### Asimmetrico

Un insieme di dati si dice asimmetrico se il rispettivo istogramma non e' distribuito approssimativamente normale, cioe' non e' distribuito intorno alla mediana campionaria

- a sinistra: la coda e' a sinistra
- a destra: la coda e' a destra

---

## Correlazione

### Covarianza campionaria

$$
cov(x_i, y_i) = \frac{1}{n-1} \sum_{i=1}^{n}(x_i - \bar{x})(y_i - \bar{y})
$$

### Coefficiente di correlazione campionaria

$$
r_{x,y} = \frac{1}{n - 1} \frac{\sum_{i=1}^{n} (x_i - \bar{x})(y_i - \bar{y})}{s_x s_y} \\
\text{} \\
r_{x,y} = \frac{cov(x_i, y_i)}{s_x s_y} \\
\text{} \\
r_{x,y} \in [-1, 1]
$$

- semplificata

$$
r_{xy} = \frac{\sum_{i=1}^{n} x_i y_i - n \bar{x} \bar{y}}
  {\sqrt{(\sum_{i=1}^{n} x_i^2 - n\bar{x}^2)(\sum_{i=1}^{n} y_i^2 - n\bar{y}^2)}}
$$

- proprieta'
  
  - compreso tra [-1, 1]

$$
w_i = a + b x_i \quad z_i = c + d y_i \qquad  i = 1 ... n \newline
r_{wz} = r_{xy}
$$

---

## Concentrazione

### Indice di concentrazione di Gini

$$
G = \frac{\sum_{i=1}^{n-1} (F_i - Q_i)}{\sum_{i=1}^{n-1} F_i} \\
\text{} \\
G \in [0, 1]
$$

dove

- frequenza relativa cumulata all'i-esima osservazione

$$
F_i = \frac{i}{n} \newline
$$

- somma dei valori

$$
TOT = n \bar{a} = \sum_{i=1}^{n} a_i\newline
$$

- quantita' relativa cumulata fino all'i-esima osservazione

$$
Q_i = \frac{\sum_{k=1}^{i} a_k}{TOT}
$$

- proprieta
  
  - compreso tra [0, 1]
    - 0: concentrazione minima, ovvero tutti gli elementi assumono lo stesso valore
      - $a_1 = a_2 = ... = a_n = \bar{a}$
    - 1: concentrazione massima, ovvero tutti i valori assumono valore 0 a parte uno
      - $a_1 = a_2 = ... = a_{n-1} = 0, \qquad a_n = n \bar{a}$

---

## ANOVA (ANalysis On VAriance)

$$
SS_T = SS_W + SS_B
$$

$$
\frac{SS_T}{n - 1} = \frac{SS_W}{n - G} + \frac{SS_B}{G - 1}
$$

dove

- media campionaria di tutte le osservazioni

$$
\bar{x} = \frac{1}{n} \sum_{g=1}^{G} \sum_{i=1}^{n_g} x_i^g
$$

- media campionaria all'interno del g-esimo gruppo

$$
\bar{x}^g = \frac{1}{n_g} \sum_{i=1}^{n_g} x_i^g
$$

- somma degli scarti **entro i gruppi (Within)**

$$
SS_W = \sum_{g=1}^{G} \sum_{i=1}^{n_g} (x_i^g - \bar{x}^g)^2
$$

- somma degli scarti **tra i gruppi (Between)**

$$
SS_B = \sum_{g=1}^{G} n_g (\bar{x}^g - \bar{x})^2
$$

- somma degli scarti **totali (Total)**

$$
SS_T = \sum_{g=1}^{G} \sum_{i=1}^{n_g} (x_i^g - \bar{x})^2
$$
