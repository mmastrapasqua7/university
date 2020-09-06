## Modelli statistici continui

### Distribuzione uniforme continua (V.A. continua)

$$
X \sim U(a, b) \\
\text{} \\
f_X(x) = \frac{1}{b - a} I_{(a, b)}(x) \\
\text{} \\
F_X(x) = P(X \le x) = \frac{x-a}{b-a} I_{(a, b)}(x) + I_{[b, \infin)}(x)\\
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

### Distribuzione esponenziale (V.A. continua)

$$
X \sim E(\lambda) \qquad \lambda > 0 \\
\text{} \\
f_X(x) = \lambda e^{-\lambda x} I_{\R^+}(x) \\
\text{} \\
F_X(x) = P(X \le x) = (1 - e^{-\lambda x}) I_{\R^+}(x) \\
\text{} \\
E(X) = \frac{1}{\lambda} \\
\text{} \\
Var(X) = \frac{1}{\lambda^2}
$$

**esempio**

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
= P(X > 12 | X > 7) = \text{per assenza di memoria} =  \\
= P(X > 7) = e^{-\lambda 7} = e^{-0.7} \approx 0.50
$$

#### Proprieta': assenza di memoria

$$
P(X > t + s \space|\space X > t) = P(X > s)
$$

#### Proprieta': minimo dei modelli esponenziali

$$
\forall i \in \N \qquad X_i \sim E(\lambda_i) \qquad \text{+ INDIPENDENZA}\\
\implies \\
Y \coloneqq \min_{1 \le i \le n} X_i \qquad Y \sim E(\sum_{i=1}^{n} \lambda_i) \\
\text{} \\
\text{} \\
\text{} \\
Y > x \iff \forall i \quad X_i > x \\
\text{} \\
P(Y > x) = P(\forall i \space X_i > x) = P(\bigcap_{i=1}^{n} \{X_i > x\}) = \prod_{i=1}^{n} P(X_i > x)
$$

**esempio**

Se ho dei componenti in serie, e indico con Xi il tempo di guasto del componente i-esimo, il fatto che questi componenti siano legati in serie ne basta uno per determinare l'intero guasto del sistema. min(Xi) = tempo di guasto del sistema

$$
X_i = \text{tempo di guasto di } C_i \sim E(\lambda_i) \\
Y \coloneqq \min X_i = \text{tempo di guasto del sistema} \\
\text{} \\
Y \sim E(\sum_i \lambda_i) \\
\text{} \\
Y \sim E(\lambda)
$$

### Distribuzione gaussiana (o normale) (V.A. continue)

Mu determina il punto di massimo, trasla il grafico interamente. Sigma invece rappresenta la distanza a partire da Mu (sia sx che dx) dal quale partono i flessi. Sigma allarga la campana

$$
X \sim N(\mu, \sigma) \qquad \lambda \in \R, \sigma \in \R^+ \\
\text{} \\
f_X(x) = \frac{1}{\sqrt{2 \pi} \sigma}e^{-\frac{(x - \mu)^2}{2 \sigma^2}} \\
\text{} \\
\text{dove} \\
\text{} \\
\mu \coloneqq E(X) \\
\text{} \\
\sigma^2 \coloneqq Var(X)
\text{} \\
\text{} \\
\text{} \\
P(X \lt x) = P(\frac{X - \mu}{\sigma} \lt \frac{x - \mu}{\sigma}) =
P(Z \lt \frac{x - \mu}{\sigma}) \eqqcolon \Phi(\frac{x - \mu}{\sigma}) \\
\text{} \\
\text{} \\
\text{} \\
P(a \lt X \lt b) = P(a - \mu \lt X - \mu \lt b - \mu) = \\
\text{} \\
= P(\frac{a - \mu}{\sigma} \lt \frac{X - \mu}{\sigma} \lt \frac{b - \mu}{\sigma}) = \\
\text{} \\
= P(\frac{a - \mu}{\sigma} \lt Z \lt \frac{b - \mu}{\sigma}) = \\
\text{} \\
= \Phi(\frac{b - \mu}{\sigma}) - \Phi(\frac{a - \mu}{\sigma})
$$

**proprieta**:

$$
\forall a, b \in \R \qquad Y \coloneqq aX + b \implies Y \sim N(a \mu + b, |a|\sigma)
$$

**proprieta**:

$$
\Phi(-x) = P(Z \le -x) = P(Z \gt x) = 1 - P(Z \le x) = 1 - \Phi(x)
$$

#### Distribuzione gaussiana standard (o normale standard)

$$
Z \coloneqq \frac{X - \mu}{\sigma} \qquad Z \sim N(0, 1) \\
\text{} \\
F_Z(x) = \Phi_Z(x) = P(Z \le x) = \int_{-\infin}^{x} e^{-\frac{y^2}{2}} dy \\
\text{} \\
\forall x \in \R
$$

La funzione di ripartizione di questa normale standard ci permette di esprimere le probabilita' di una generica normale X in termini di probabilita' su Z

## Processo stocastico

Eventi a istanti di tempo casuali

$$
N(t) = \text{\# eventi occorsi in } [0, t] \\
\implies \\
\forall t \gt 0 \quad N(t) \text{ e' una V.A.} \\
\implies \\
N(t) \text{ e' un PROCESSO STOCASTICO}
$$

### Processo stocastico di Poisson

dove $\lambda$ = **intensita'**

#### Condizioni processo stocastico per essere di Poisson

1. $$
   N(0) = 0
   $$

2. $$
   \text{\# eventi in intervalli disgiunti} \implies \text{INDIPENDENZA}
   $$

3. la distribuzione dipende **solo** dalla lunghezza dell'intervallo

4. $$
   \lim_{h \to 0} \frac{P(N(h) = 1)}{h} = \lambda
   $$
   
   Ovvero, per h piccolo, P(N(h) = 1) = $\lambda$h

5. $$
   \lim_{h \to 0} \frac{P(N(h) > 1)}{h} = 0
   $$
   
   Ovvero, per h piccolo, P(N(h) > 1) = 0

Per h piccolo, ovvero quando l'intervallo di tempo tende a 0, la probabilita' che accada esattamente 1 evento e' proporzionale all'intervallo e all'intensita' del processo. Analogamente, la probabilita' che accada piu' di 1 evento quando l'intervallo di tempo tende a 0 e' zero

#### Proprieta degli intervalli temporali

Dato un qualsiasi intervallo, N(t) puo' essere descritta da una distribuzione binomiale. Ma, quando n e' molto grande ovvero tende a infinito, la stessa N(t) puo' essere descritta da una distribuzione di Poisson, il che e' preferibile perche' i parametri di Poisson non dipendono da n

$$
N(t) = k \\
\text{} \\
\text{divido t in n-sottointervalli, k-eventi} \\
n \gt k \\
\text{} \\
\text{} \\
\text{} \\
N(t) = k \\
\iff \\
A \lor B \\
\iff \\
A \coloneqq \{\text{1 occorrenza in k intervalli, 0 in n-k intervalli}\} \lor \\
\lor B \coloneqq \{\text{tutti gli altri casi}\} \\
\text{} \\
\text{} \\
\text{} \\
A \land B = \empty \\
P(B) = 0 \\
\text{} \\
P(N(t) = k) = P(A \lor B) = P(A) + P(B) = P(A) \\
\text{} \\
P(A) = \binom{n}{k} (\lambda \frac{t}{n})^k (1 - \lambda \frac{t}{n})^{n-k} \\
\text{} \\
N(t) \sim B(n, \lambda \frac{t}{n}) \\
\text{} \\
N(t) \sim P(\lambda t) \qquad n \to \infin \\
\text{} \\
P(N(t) = k) = e^{-\lambda t}\frac{(\lambda t)^k}{k!} I_{\N \lor \{0\}}(k)
$$

#### Proprieta' degli intertempi

Usiamo delle variabili aleatorie le cui specificazioni indicano il tempo che passa dall'istante precedente (iniziale nella prima e dell'evento nelle altre) all'istante dell'occorrenza dell'evento, appunto intertempi tra un evento e l'altro

$$
X_1, X_2, ..., X_n \\
\text{} \\
P(X_1 \gt t) = P(\text{nessuna occorrenza tra (0, t]}) = P(N(t) = 0) \\
\text{} \\
P(N(t) = 0) = e^{-\lambda t} \frac{(\lambda t)^0}{0!} = e^{-\lambda t} \\
\text{} \\
F_{X_1}(t) = P(X_1 \le t) = 1 - P(X_1 \lt t) = 1 - e^{-\lambda t} \\
\text{} \\
\implies \\
\text{} \\
X_1 \sim E(\lambda) \\
\text{} \\
\text{} \\
\text{} \\
P(X_2 \gt t \space|\space X_1 = s) = P(\text{nessuna occorrenza in (s, s + t]} | X_1 = s) =\\
\text{} \\
= P(\text{nessuna occorrenza in (s, s + t]}) = P(N(t) = 0) = e^{-\lambda t} \\
\text{} \\
\implies \\
\text{} \\
X_2 \sim E(\lambda) \\
\text{} \\
\text{} \\
\iff
\text{} \\
\text{} \\
\forall i \quad X_i \sim E(\lambda) \\
X_1, X_2, ..., X_n \space \text{ INDIPENDENTI}
$$

In un processo di Poisson, il numero di occorrenze all'interno di un intervallo e' distribuito secondo un modello di Poisson di $\lambda$t e invece l'intertempo tra un'occorrenza e' l'altra e' distribuito secondo un modello esponenziale di parametro $\lambda$
