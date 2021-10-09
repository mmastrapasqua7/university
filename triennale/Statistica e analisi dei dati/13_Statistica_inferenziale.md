# Statistica inferenziale

- POPOLAZIONE

- CAMPIONE

Ho una popolazione descritta da una v.a. $X$. Ogni membro del campione viene rappresentato come una variabile aleatoria $X_i$, indipendenti e identicamente distribuite. Questa distribuzione puo' essere totalmente ignota o parzialmente ignota (nota ma a meno di alcuni parametri). Perche' le indico con delle v.a.? Voglio trovare dei risultati che non dipendano dall'esito di un particolare campionamento, ma che valgano indipendentemente da questa cosa.

**CAMPIONE**:

- $X_1, X_2, ..., X_n$ le uso come modellazione degli elementi del campione

$$
X \sim D \\
\text{} \\

X_1, X_2, ..., X_n \sim D \quad i.i.d. \qquad \text{campione} \\
\text{} \\
X \coloneqq \sum X_i \quad \text{popolazione} \\
\text{} \\
D = \begin{cases}
\text{ignota} & \\
\text{nota} & \text{a meno di parametri (parzialmente ignota)}
\end{cases} \\
\text{} \\
D = \begin{cases}
\text{ignota} & \text{inferenza non parametrica}\\
\text{nota} & \text{inferenza parametrica}
\end{cases} \\
\text{} \\
\text{inferenza parametrica} = \begin{cases}
\text{puntuale} \\
\text{per intervalli}
\end{cases} \\
\text{} \\
\text{} \\
\theta \quad \text{PARAMETRO IGNOTO} \\
\text{} \\
\tau(\theta) \quad \text{QUANTITA' IGNOTA CHE VOGLIO STIMARE CHE DIPENDE DA } \theta \\
\text{} \\
t: X_1 * X_2 * ... * X_n \mapsto \R \quad \text{STATISTICA / STIMATORE} \\
\text{} \\
t(x_1, x_2, ..., x_n) = s \quad \text{STIMA DELLA QUANTITA' IGNOTA } \tau(\theta)
$$

L'inferenza statistica su una distribuzione nota a meno di parametri e' un processo che ha come scopo quello di stimare il valore di quei parametri

## Statistica / Stimatore (algoritmo per stimare il parametro)

**esempio**:

X V.A. altezza di una generica donna nata in una regione

$$
X = \text{altezza di una generica donna nata in una certa regione} \\
\text{} \\
X_1, X_2, ..., X_n \text{ i.i.d.} \\
\text{} \\
X \sim N(\mu, \sigma) \\
\text{} \\
\theta: \mu \qquad \text{non conosco il parametro } \mu \\
\text{} \\
\tau(\theta): \mu \qquad \text{voglio stimare quantita' ignota } \mu \\
\text{} \\
t(X_1, X_2, ..., X_n) = \frac{1}{n} \sum_{i=1}^{n} X_i = \bar{X} \\
\text{} \\
\bar{X} \text{ e' una stima della quantita' ignota } \tau(\theta) \\
\text{} \\
\bar{X} \approx \tau(\theta) \\
\text{} \\
\bar{X} = \tau(\theta)
$$

### Stimatore non distorto / unbiased / non deviato

##### Richieste

1. $E(t(X_1, X_2, ..., X_n)) \approx \tau(\theta)$
   
   Voglio che il valore atteso della mia statistica sia vicino a quello che voglio stimare. Ogni volta che ripeto il processo che mi porta a una stima voglio che la stima oscilli intorno al valore atteso. Valori della stima vicino a quello che voglio stimare

2. oscillazioni non troppo grandi (ampiezza delle oscillazioni)
   
   La dispersione intorno a quello che voglio stimare non deve essere troppo alta, oscillazioni contenute.

#### Media campionaria

##### Richiesta 1: $E(t(X_1, X_2, ..., X_n)) \approx \tau(\theta)$

Popolazione $X$ di cui non so nulla, non conosco quindi $E(X) = \mu $, voglio stimare $\mu$

$$
\theta: \mu \\
\text{} \\
\tau(\theta): \mu \\
\text{} \\
X_1, X_2, ..., X_n \text{ i.i.d} \\
\text{} \\
t(X_1, X_2, ..., X_n) = \frac{1}{n} \sum_{i=1}^{n} X_i = \bar{X} \\
\text{} \\
\text{STATISTICA USATA: MEDIA CAMPIONARIA} \\
\text{} \\
E(\bar{X}) = \frac{1}{n} \sum_{i=1}^{n} E(X_i) = \frac{1}{n} \sum_{i=1}^{n} \mu = \mu \\
\text{} \\
E(t(X_1, X_2, ..., X_n)) = E(\bar{X}) = \mu \\
$$

**Quando succede questo, la statistica/stimatore che sto utilizzando e' non deviato/non distorto, ovvero la stima non e' un approssimazione, ma e' esattamente quello che sto cercando.**

**LA MEDIA CAMPIONARIA E' UNO STIMATORE NON DEVIATO/NON DISTORTO PER IL VALORE ATTESO DELLA POPOLAZIONE**

##### Richiesta 2: oscillazioni non troppo grandi

###### Varianza campionaria (misura ampiezza oscillazioni) per lo stimatore non deviato media campionaria

$$
Var(\bar{X}) = E((\bar{X} - \mu)^2)
$$

Quanto sono ampie le oscillazioni intorno a quello che sto stimando. La varianza della media campionaria e' pari al rapporto tra la varianza della popolazione e la **grandezza del campione**. **Aumentare il numero del campione non cambia la stima del valore atteso, ma NE DIMINUISCE LE OSCILLAZIONI**

$$
E(\bar{X}) = \mu, \quad \forall i E(X_i) = \mu, \quad Var(X_i) = \sigma^2 \\
\text{} \\
Var(t(X_1, X_2, ..., X_n)) = Var(\bar{X}) = Var(\frac{1}{n} \sum_{i=1}^{n} X_i) = \\
\text{se } X_1, X_2, ..., X_n \text{ i.i.d.} \\
= \frac{1}{n^2} \sum_{i=1}^{n} Var(X_i) = \frac{1}{n^2} \sum_{i=1}^{n} \sigma^2 = \frac{\sigma^2}{n}
$$

#### MSE = Mean Square Error (scarto quadratico medio)

$$
T \coloneqq t(X_1, X_2, ..., X_n) \\
\text{} \\
MSE_T(\tau(\theta)) = E((T - \tau(\theta))^2) \\
$$

##### MSE per stimatore non deviato

$$
E(T) = \tau(\theta) \\
\implies \\
MSE_T(\tau(\theta)) = E((T - \tau(\theta))^2) = E((T - E(T))^2) = Var(T) \\
$$

##### MSE per stimatore deviato

$$
E(T) \neq \tau(\theta) \\
\implies \\
MSE_T(\tau(\theta)) = E(((T - \mu_t) + (\mu_t - \tau(\theta)))^2) = Var(T) + b_T(\tau(\theta))^2 \\
\text{} \\
\text{dove} \\
\text{} \\
\mu_t \coloneqq E(T) \neq \tau(\theta) \\
\text{} \\
b_T(\tau(\theta)) \coloneqq E(T) - \tau(\theta) = \mu_t - \tau(\theta)\qquad \text{BIAS stimatore}
$$

### Consistenza

#### Consistenza quadratica

All'aumentare della numerosita' del campione, sia la varianza che il bias dello stimatore tendono a 0

$$
T_1 = t(X_1), \quad T_2 = t(X_1, X_2), \quad ..., \quad T_n = t(X_1, X_2, ..., X_n) \\
\text{} \\
\lim_{n \to \infin} MSE_{T_n}(\tau(\theta)) = 0 \qquad \forall \theta
$$

**esempio**: lo stimatore media campionaria per il valore atteso gode di questa proprieta'

La media campionaria non solo e' uno stimatore non deviato per il valore atteso della popolazione, ma gode anche della consistenza quadratica, sempre legato al processo di stima del valore atteso di una popolazione

$$
X \qquad E(X) = \mu = \tau(\theta) \qquad Var(X) = \sigma^2 \qquad T_n = \bar{X_n} = \frac{1}{n} \sum X_i \\
\text{} \\
E(T_n) = \mu \qquad Var(T_n) = \frac{\sigma^2}{n} \qquad MSE_{T_n}(\mu) = Var(T_n) = \frac{\sigma^2}{n} \to_{n \to \infin} 0
$$

#### Consistenza debole

$$
\lim_{n \to \infin} P(\tau(\theta) - \epsilon \lt T_n \lt \tau(\theta) + \epsilon) = 1 \qquad \forall \epsilon \gt 0
$$

Valida per la disuguaglianza di Markov

##### Teorema

CONSISTENZA QUADRATICA $\implies$ CONSISTENZA DEBOLE

### Legge dei grandi numeri

$$
X_1, X_2, ..., X_n \text{ campione di } X \\
\text{} \\
E(X) = \mu \qquad Var(X) = \sigma^2 \\
\text{} \\
\sum_{i=1}^{n} X_i \approx \sim N(n\mu, \sqrt{n}\sigma) \\
\text{} \\
\text{per teorema centrale del limite} \\
\text{} \\
\text{} \\
\text{} \\
\bar{X} = \frac{1}{n} \sum_{i=1}^{n} X_i \approx \sim N(\mu, \frac{\sigma}{\sqrt{n}}) \\
\text{} \\
\frac{\bar{X} - \mu}{\frac{\sigma}{\sqrt{n}}} \approx \sim N(0, 1)
$$

#### Legge FORTE dei grandi numeri

All'aumentare del campione, la varianza della variabile aleatoria si annulla e la V.A. diventa degenere, ovvero assume sempre lo stesso valore, ovvero il valore atteso. La V.A. diventa una costante

$$
P(\lim_{n \to \infin} \bar{X}_n = \mu) = 1
$$

#### Legge DEBOLE dei grandi numeri

$$
\lim_{n \to \infin} P(|\bar{X}_n - \mu| \lt \epsilon) = 1 \qquad \forall \epsilon \gt 0
$$

### Varianza campionaria

La varianza campionaria e' uno stimatore non deviato per la varianza della popolazione

$$
X, \quad E(X) = \mu, \quad Var(X) = \sigma^2 \\
\text{} \\
\bar{X} = \frac{1}{n} \sum_{i=1}^{n} X_i \\
\text{} \\
S^2 = \frac{1}{n - 1} \sum_{i=1}^{n} (X_i - \bar{X})^2 \\
\text{varianza campionaria} \\
\text{} \\
S = \sqrt{S^2} \\
\text{deviazione standard campionaria}
$$

**dim**

$$
\sum_i (x_i - \bar{x})^2 = \sum_i (x_i^2 - 2x_i\bar{x} + \bar{x}^2) = ... = \\
\text{} \\
= \sum_i x_i^2 - 2n\bar{x}^2 + n\bar{x}^2 = \sum_i x_i^2 - n\bar{x}^2 \\
\text{} \\
\text{} \\
E(X^2) = Var(X) + E(X)^2 \\
\text{} \\
\text{} \\
E(\bar{X}) = \mu, \quad Var(\bar{X}) = \frac{\sigma^2}{n} \\
\text{} \\
\text{} \\
\text{} \\
\text{} \\
(n-1)S^2 = \sum_i (X_i - \bar{X})^2 = \sum_i X_i^2 - n\bar{X}^2 \\
\text{} \\
\text{} \\
(n-1)E(S^2) = \sum_i E(X_i^2) - nE(\bar{X}^2) = \\
\text{} \\
= n(E(X^2) - E(\bar{X}^2)) = \\
\text{} \\
= n(Var(X) + E(X)^2 - Var(\bar{X}) - E(\bar{X})^2) = \\
\text{} \\
= n(\sigma^2 + \mu^2 - \frac{\sigma^2}{n} - \mu^2) = n\sigma^2(1 - \frac{1}{n}) = \sigma^2 (n - 1) \\
$$

# Esercizio numerosita' campione

$$
X = \text{misura distanza di una stella (a.l.)} \\
\text{} \\
X \sim N(d, 2) \qquad d = \text{distanza effettiva}\\
\text{} \\
x_1, x_2, ..., x_n \qquad \bar{x} = \frac{1}{n} \sum_{i=1}^{n} x_i \qquad d \approx \bar{x}
$$

Quante misurazioni devo fare per avere un errore della stima sia al massimo $0.5$ a.l. con probabilita' $p \ge 0.95$ ?

$$
P(|\bar{X} - d| \le 0.5) \ge 0.95 \\
\text{} \\
\bar{X} \sim N(d, \frac{2}{\sqrt{n}}) \\
\text{} \\
P(|\bar{X} - d| \le 0.5) = P(|\frac{\bar{X} - d}{\frac{2}{\sqrt{n}}}| \le \frac{0.5}{\frac{2}{\sqrt{n}}}) = \\
\text{} \\
Z \coloneqq \frac{|\bar{X} - d|}{\frac{2}{\sqrt{n}}} \sim N(0, 1)\\
\text{} \\
= P(|Z| \le \frac{\sqrt{n}}{4}) = \Phi(\frac{\sqrt{n}}{4}) - \Phi(- \frac{\sqrt{n}}{4}) = \\
\text{} \\
= \Phi(\frac{\sqrt{n}}{4}) - (1 - \Phi(\frac{\sqrt{n}}{4})) \\
\text{} \\
2 \space \Phi(\frac{\sqrt{n}}{4}) - 1 \ge 0.95 \\
\text{} \\
\Phi(\frac{\sqrt{n}}{4}) \ge 0.975 \\
\text{} \\
\Phi^{-1}(\Phi(\frac{\sqrt{n}}{4})) \ge \Phi^{-1} (0.975) \\
\text{} \\
\frac{\sqrt{n}}{4} \ge \Phi^{-1}(0.975) \approx 1.96 \\
\text{} \\
n \ge (4 * 1.96)^2 \approx 61.4 \\
\text{} \\
n = 62
$$

Devo fare almeno 62 misurazioni per avere una p del 95% di compiere un errore minore di 0.5 a.l. nel misurare la distanza della stella dalla Terra

# Altro esercizio

$$
X \qquad E(X) = \mu \qquad Var(X) = \sigma^2 \\
\text{} \\
X_1, X_2, ..., X_n \\
\text{} \\
\bar{X} = \frac{1}{n} \sum_{i=1}^{n} X_i
$$

Voglio un errore nella stima del valore atteso $\le r$, con probabilita' $p \ge 1 - \delta$

$$
P(|\bar{X} - \mu| \le r) \ge 1 - \delta \\
\text{} \\
\text{teorema centrale del limite} \\
\text{} \\
\bar{X} \sim N(\mu, \frac{\sigma}{\sqrt{n}}) \\
\text{} \\
\text{normalizzo secondo normale standard} \\
\text{} \\
\approx P(|Z| \le \frac{r}{\sigma}\sqrt{n}) = \\
\text{} \\
= P(-\frac{r}{\sigma}\sqrt{n} \le Z \le \frac{r}{\sigma}\sqrt{n}) = \\
\text{} \\
2 \space \Phi(\frac{r}{\sigma}\sqrt{n}) - 1 \ge 1 - \delta \\
\text{} \\
\Phi(\frac{r}{\sigma}\sqrt{n}) \ge 1 - \frac{\delta}{2} \\
\text{} \\
n \ge (\frac{\sigma}{r} \Phi^{-1}(1 - \frac{\delta}{2}))^2 \\
$$
