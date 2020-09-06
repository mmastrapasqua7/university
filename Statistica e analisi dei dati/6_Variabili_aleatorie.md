## Variabili aleatorie

Quando non siamo interessati a un particolare esito ma a una quantita' determinata dall'esito di un esperimento, usiamo le **variabili aleatorie**. Siccome il valore di una V.A. e' determinato dall'esito dell'esperimento, possiamo assegnare delle probabilita' ai suoi valori.

$$
X: S \mapsto \R \\
\text{} \\
P(X = x) = P(\{X = x\}) \\
\text{} \\
\{X = x\} = \{s \in S : X(s) = x\} \\
\text{} \\
1 = P(S) = P(\bigcup_{i=1}^{n}\{X = i\}) = \sum_{i=1}^{n} P(X = i)
$$

**esempio**:

Sia S lo spazio degli esiti del lancio di 2 dadi, X una variabile aleatoria definita dalla somma. Qual e' la probabilita' che X assuma il valore 3?

$$
S = 6^2 = 36 \\
\text{} \\
\{X = 3\} = \{s \in S : X(s) = 3\} = \{(1, 2), (2, 1)\} \\
\text{} \\
P(X = 3) = 2/36
$$

### Funzione indicatrice

$$
I_A(x) \coloneqq \begin{cases}
   1 &\text{se x} \in \text{A} \\
   0 &\text{se x} \notin \text{A}
\end{cases}
$$

### Funzione di ripartizione

$$
F_X : \R \mapsto [0, 1] \\
\text{} \\
F_X(x) \coloneqq P(X \le x)
$$

**proprieta**:

$$
P(X \le b) = P(X \le a) + P(a \lt X \le b) \\
\text{} \\
P(a \lt X \le b) = P(X \le b) - P(X \le a) = F(b) - F(a)
$$

## V.A. Discrete

Una V.A. si dice discreta se e solo se puo' assumere un'insieme numerabile di specificazioni

### Funzione di massa di probabilita'

$$
p_X : \R \mapsto [0, 1] \\
\text{} \\
p_X(x) = P(X = x) \\
\text{} \\
\sum_{i=1}^{n}p_X(x_i) = 1
$$

### Funzione di ripartizione

$$
F_X : \R \mapsto [0, 1] \\
\text{} \\
F_X(x) = P(X \le x) = \sum_{a \le x} P(X = a) = \sum_{a \le x} p_X(a)
$$

**proprieta**

$$
\text{dato } A \subset \R \\
\text{} \\
P(X \in A) = \sum_{x \in A}p_X(x) = \sum_{x \in A} P(X = x)
$$

### Valore atteso

Media pesata dei valori possibili di X, usando come pesi le probabilita' che tali valori vengano assunti da X. Anche detta media di X

$$
E(X) = \sum_{i=1}^{n} x_i \space p_X(x_i)
$$

**proprieta**:

$$
E(aX + b) = aE(X) + b
$$

**esempio**:

Ho una scatola con 1000 fogliettini. 999/1000 fogliettini mi fanno vincere 1\$, mentre 1/1000 fogliettini contiene un debito di 10k\$. Sia X una V.A. discreta che descriva tale comportamento, qual e' il valore atteso E di X?

$$
p_X(1) = 999/1000 \\
\text{} \\
p_X(-10k) = 1/1000 \\
\text{} \\
E(X) = \sum x_i \space p_X(x_i) = 1 * p_X(1) + (-10k) * p_X(-10k) = \\
\text{} \\
= 1 * \frac{999}{1000} - 10k * \frac{1}{1000} = 0.99 - 10 = -9.01
$$

**esempio 2**:

$$
E(I_A) = \sum x_i \space p_X(x_i) = 0 * p_{I_A}(0) + 1 * p_{I_A}(1) = p_{I_A}(1) = P(A)
$$

### Varianza

$$
Var(X) = \sigma_X^2 = E(X^2) - E(X)^2
$$

**proprieta'**:

$$
Var(aX + b) = a^2 \space Var(X)
$$

**esempio**:

$$
X = \text{punteggio dado} \\
\text{} \\
p_X(i) = \frac{1}{6} I_{\{1, 2, ..., 6\}}(i) \\
\text{} \\
Var(X) = E(X^2) - E(X)^2 \\
\text{} \\
E(X) = \sum_{i=1}^{6} x_i \space p_X(x_i) = \sum_{i=1}^{n} x_i \frac{1}{6} = \frac{7}{2} \\
\text{} \\
E(X)^2 = (\frac{7}{2})^2 = \frac{49}{4} \\
\text{} \\
Y = g(x) \coloneqq x^2 = X^2 \\
\text{} \\
E(X^2) = E(Y) = E(g(x)) = \sum_{i=1}^{6} x_i^2 \space p_Y(x_i^2) = \sum_{i=1}^{6} i^2 \frac{1}{6} = \frac{91}{6} \\
\text{} \\
Var(X) = E(X^2) - E(X)^2 = \frac{91}{6} - \frac{49}{4} = \frac{35}{12} = 2.91
$$

### Deviazione Standard

$$
\sigma_X = \sqrt{\sigma_X^2} = \sqrt{Var(X)}
$$

## V.A. Discrete Multivariate

Vettore di variabili aleatorie, coppie X Y

### Funzione di ripartizione congiunta

$$
F_{X,Y}(x, y) = P(X \le x, Y \le y) \\
\text{} \\
\text{} \\
\text{se } X, Y \text{ sono V.A. indipendenti} \\
\iff \\
F_{X,Y}(x, y) = F_X(x) \space F_Y(y)
$$

### Funzione di massa di probabilita' congiunta

$$
p_{X,Y}(x, y) = P(X = x_i, Y = y_i) \\
\text{} \\
\text{} \\
\text{se } X, Y \text{ sono V.A. indipendenti} \\
\iff \\
p_{X,Y}(x, y) = p_X(x) \space p_Y(y)
$$

### Valore atteso

$$
E(X + Y) = E(X) + E(Y) \\
\text{} \\
\text{} \\
\text{se } X, Y \text{ sono V.A. indipendenti} \\
\iff \\
E(XY) = E(X) E(Y)
$$

**esempio**:

Lancio 2 dadi, voglio sapere il valore atteso da essi

$$
X_1 = \text{V.A. lancio del primo dado} \\
X_2 = \text{V.A. lancio del secondo dado} \\
X = X_1 + X_2 \\
\text{} \\
E(X) = E(X_1) + E(X_2) = \frac{7}{2} + \frac{7}{2} = 7
$$

**esempio 2**:

Esistono 20 buoni diversi. Ogni lettera contiene 1 buono. Qual e' il valore atteso di buoni diversi uno dall'altro comprando 10 lettere?

$$
X = \text{\# buoni diversi uno dall'altro} \\
\text{} \\
\forall \in {1, 2, ..., 20} \\ I_{X_i} = \begin{cases}
1 & \text{se il buono i e' in almeno una lettera} \\
0 & \text{altrimenti}
\end{cases} \\
\text{} \\
\text{} \\
p_{I_{X_i}}(1) = P(I_{X_i} = 1) = P(\text{il buono i e' in almeno una lettera}) = \\
= 1 - P(\text{buono i in nessuna lettera}) = \\
= 1 - \prod_{j=1}^{10} P(\text{buono i non e' nella j-esima lettera}) = \\
= 1 - \prod_{j=1}^{10} \frac{19}{20} = 1 - (\frac{19}{20})^{10} = E(I_{X_i})\\
\text{} \\
\text{} \\
E(X) = \sum_{i=1}^{20} E(I_{X_i}) = 20 * E(I_{X_i}) = \\
\text{} \\
= 20 * (1 - ({\frac{19}{20}})^{10}) = 20 * 0.401 = 8.025
$$

### Varianza

$$
Var(X + Y) = Var(X) + Var(Y) + 2*Cov(X, Y) \\
\text{} \\
\text{} \\
\text{se } X, Y \text{ sono V.A. indipendenti} \\
\iff \\
Var(X + Y) = Var(X) + Var(Y)
$$

**proprieta'**:

$$
Var(X + Y + Z) = Var(X) + Var(Y) + Var(Z) + \\
+ 2*Cov(X, Y) + 2*Cov(Y, Z) + 2*Cov(X, Z) \\
\text{} \\
Var(\sum_{i} X_i) = \sum_{i, j}Cov(X_i, X_j)
$$

**esempio**:

$$
X = \text{somma esiti 10 lanci di dado} \\
\text{} \\
\forall i = 1, 2, ..., 10 \qquad X_i = \text{esito lancio i-esimo} \\
\text{} \\
\forall i = 1, 2, ..., 10 \qquad Var(X_i) = \frac{35}{12} \\
\text{} \\
Var(X) = Var(\sum_{i=1}^{10} X_i) = \text{per indipendenza} = \\
\text{} \\
= \sum_{i=1}^{10} Var(X_i) = \sum_{i=1}^{10} \frac{35}{12} = 10 \space\frac{35}{12}
$$

### Covarianza

$$
Cov(X, Y) = E((X - E(X))(Y - E(Y))) \\
\text{} \\
\text{oppure} \\
\text{} \\
\mu_X \coloneqq E(X) \\
\mu_Y \coloneqq E(Y) \\
Cov(X,Y) = E((X-\mu_X)(Y - \mu_Y)) \\
\text{} \\
\text{} \\
\text{se } X, Y \text{ sono V.A. indipendenti} \\
\iff \\
Cov(X, Y) = 0
$$

**proprieta**

$$
Cov(X,Y) = Cov(Y,X) \\
\text{} \\
Cov(aX, Y) = a * Cov(X,Y) \\
\text{} \\
Cov(X+b, Y) = Cov(X, Y) \\
\text{} \\
Cov(X,Y) = E(XY) + E(X)E(Y) \\
\text{} \\
Cov(X + Y, Z) = Cov(X, Z) + Cov(Y, Z) \\
\text{} \\
Cov(X, X) = Var(X)
$$

### Coefficiente di correlazione lineare

$$
\rho_{X,Y} \in [-1, 1] \\
\text{} \\
\rho_{X,Y} = \frac{Cov(X, Y)}{\sigma_X \sigma_Y}
$$
