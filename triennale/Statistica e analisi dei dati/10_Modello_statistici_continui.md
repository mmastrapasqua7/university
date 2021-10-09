## Modelli di v.a. continue

### Modello uniforme continuo

$$
X \sim U(a, b)
$$

**caratteristiche**:

$$
f_X(x) = \frac{1}{b - a} I_{(a, b)}(x) \\
\text{} \\
F_X(x) = \frac{x - a}{b - a} I_{(a, b)}(x) + I_{[b, \infin)}(x)\\
\text{} \\
E(X) = \frac{b + a}{2} \\
\text{} \\
Var(X) = \frac{(b - a)^2}{12}
$$

**esempio**:

Un autobus arriva ogni 15 minuti alla fermata a partire dalle 7:00. Qual e' la probabilita' di attendere meno di 5 minuti?

$$
X \sim U(0, 30) \\
\text{} \\
P(\text{attendo meno di 5 minuti}) = \\
= P(X = 0) \lor P(10 \lt X \le 15) \lor P(25 \lt X \le 30) = \\
\text{} \\
= F_X(15) - F_X(10) + F_X(30) - F_X(25) = \\
\text{} \\
= \frac{15 - 10 + 30 - 25}{30}  = \frac{1}{3}
$$

### Modello esponenziale

$$
X \sim E(\lambda) \qquad \lambda > 0
$$

**caratteristiche**:

$$
f_X(x) = \lambda e^{-\lambda x} I_{\R^+}(x) \\
\text{} \\
F_X(x) = 1 - P(X \gt x) = (1 - e^{-\lambda x}) I_{\R^+}(x) \\
\text{} \\
E(X) = \frac{1}{\lambda} \\
\text{} \\
Var(X) = \frac{1}{\lambda^2}
$$

**esempio**:

$$
X = \text{\# anni funzionamento auto nuova} \\
\text{} \\
X \sim E(\lambda) \\
\lambda = 0.1 \\
\text{} \\
P(\text{auto nuova funziona per almeno 5 anni}) = \\
= P(X > 5) = e^{-\lambda5} = e^{-0.5} \approx 0.61 \\
\text{} \\
P(\text{auto usata 7 anni funzioni per altri 5}) = \\
= P(X > 7 + 5 | X > 7) = \text{per assenza di memoria} =  \\
= P(X > 5) = e^{-\lambda 5} = e^{-0.5} \approx ?
$$

#### PROPRIETA: Assenza di memoria

$$
P(X > t + s \space|\space X > t) = P(X > s)
$$

#### PROPRIETA: Minimo dei modelli esponenziali

$$
\forall i \in \N \qquad X_i \sim E(\lambda_i) \qquad \text{+ INDIPENDENZA}\\
\implies \\
Y \coloneqq \min_{1 \le i \le n} X_i \sim E(\sum_{i=1}^{n} \lambda_i) = E(\lambda)\\
\text{} \\
\text{dove } \lambda = \sum_{i=1}^{n} \lambda_i
$$

**dim**:

$$
Y > x \iff \forall i \quad X_i > x \\
\text{} \\
P(Y > x) = P(\forall i \space X_i > x) = P(\bigcap_{i=1}^{n} \{X_i > x\}) = \prod_{i=1}^{n} P(X_i > x) = \\
= \prod_{i=1}^{n} e^{-\lambda_i x}= e^{-\lambda x}
$$

**esempio**:

Se ho dei componenti in serie, e indico con $X_i$ il tempo di guasto del componente i-esimo, il fatto che questi componenti siano legati in serie ne basta uno per determinare l'intero guasto del sistema. $\min(X_i)$ = tempo di guasto del sistema. **Ogni componente $C_i$ e' indipendente uno dall'altro.**

$$
X_i = \text{tempo di guasto di } C_i \sim E(\lambda_i) \\
\text{} \\
Y \coloneqq \min X_i = \text{tempo di guasto del sistema} \\
\text{} \\
Y \sim E(\sum_i \lambda_i) \\
\text{} \\
Y \sim E(\lambda)
$$

### Modello gaussiano (o normale)

$\mu$ determina il punto di massimo, trasla il grafico interamente. $\sigma$ invece rappresenta la distanza a partire da $\mu$ (sia sx che dx) dal quale partono i flessi. Sigma allarga la campana. **Simmetrico rispetto all'asse $\mu$ (zona di picco in $\mu$)**. **Invece $\sigma$ si riferisce ai punti di flesso. Piu' e' grande $\sigma$ e piu' la campana e' grossa**

$$
X \sim N(\mu, \sigma) \qquad \lambda \in \R, \sigma \in \R^+
$$

**caratteristiche**:

$$
f_X(x) = \frac{1}{\sqrt{2 \pi} \sigma}e^{-\frac{1}{2} (\frac{x - \mu}{\sigma})^2} I_{\R^+}(x) \\
\text{} \\
\text{dove} \\
\text{} \\
\mu \coloneqq E(X) \\
\text{} \\
\sigma^2 \coloneqq Var(X)
\text{} \\
\text{} \\
\text{} \\
F_X(x) = P(X \le x) = \int_{-\infin}^{x} f_X(y)dy = \\
\text{} \\
\text{per } z \coloneqq \frac{y - \mu}{\sigma} \\
\text{} \\
= \int_{-\infin}^{\frac{x - \mu}{\sigma}} \phi(z)dz = P(Z \le \frac{x - \mu}{\sigma}) = \Phi(\frac{x - \mu}{\sigma})
$$

**proprieta**:

Coerente con le proprieta' del valore atteso e della deviazione standard

$$
\forall a, b \in \R \qquad Y \coloneqq aX + b \implies Y \sim N(a \mu + b, |a|\sigma)
$$

**proprieta 2**:

$$
\Phi(-x) = P(Z \le -x) = P(Z \gt x) = 1 - P(Z \le x) = 1 - \Phi(x)
$$

**proprieta 3**:

$$
P(a \lt X \lt b) = \Phi(\frac{b - \mu}{\sigma}) - \Phi(\frac{a - \mu}{\sigma})
$$

#### Modello gaussiano standard (o normale standard)

$$
Z \coloneqq \frac{X - \mu}{\sigma}, \quad z = \frac{x - \mu}{\sigma}, \quad Z \sim N(0, 1) \\
\text{} \\
f_Z(z) = \phi(z) = \frac{1}{\sqrt{2\pi}} e^{-\frac{z^2}{2}} \\
\text{} \\
F_Z(z) = \Phi(z) = \int_{-\infin}^{\infin}\phi(z)dz
$$

La funzione di ripartizione di questa normale standard ci permette di esprimere le probabilita' di una generica normale X in termini di probabilita' su Z

## Quantili nei modelli continui

L'area della curva della densita' di probabilita' puo' essere usata come quantile, ovvero la funzione di ripartizione, integrale da meno infinito a $x$, se da come risultato $0.1$, allora quella variabile $x$ sara' chiamata lo $x0.1$ quantile

## Regola empirica

La regola empirica della statistica descrittiva deriva proprio dal modello gaussiano (o normale). Infatti se calcolo l'integrale della densita' di una normale da $-\sigma$ a $+\sigma$, mi esce fuori quella famosa percentuale (67%, 95%, 99.7%).