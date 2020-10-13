## Processo stocastico

Eventi a istanti di tempo casuali

$$
N(t) = \text{\# eventi occorsi in } [0, t] \\
\implies \\
\forall t \gt 0 \quad N(t) \text{ e' una variabile aleatoria} \\
\implies \\
N(t) \text{ e' un processo stocastico (famiglie di v.a.)}
$$

### Processo stocastico di Poisson

dove $\lambda$ = **intensita'**, $\lambda > 0$

#### Condizioni processo stocastico per essere di Poisson

1. $N(0) = 0$

2. Indipendenza nello studio di intervalli di tempo disgiunti: $\#$ eventi in intervalli disgiunti sono indipendenti da un intervallo all'altro.

3. la distribuzione dipende **solo** dalla lunghezza dell'intervallo $[0, t]$, N(0) e' ininfluente

4. $\lim_{h \to 0} \frac{P(N(h) = 1)}{h} = \lambda$
   
   Ovvero per $h$ piccolo $P(N(h) = 1) = \lambda h$

5. $\lim_{h \to 0} \frac{P(N(h) > 1)}{h} = 0$
   
   Ovvero per $h$ piccolo $P(N(h) > 1) = 0$

Per h piccolo, ovvero quando l'intervallo di tempo tende a 0, la probabilita' che accada esattamente 1 evento e' proporzionale all'intervallo e all'intensita' del processo. Analogamente, la probabilita' che accada piu' di 1 evento quando l'intervallo di tempo tende a 0 e' zero. Se sono soddisfatte tutte e 5 le condizioni diciamo che $N(t)$ e' un processo stocastico di Poisson con parametro (intensita') uguale a $\lambda$

#### Proprieta degli intervalli temporali

Dato un qualsiasi intervallo, $N(t)$ puo' essere descritta da una **distribuzione binomiale**. Ma, quando $n$ e' molto grande ovvero tende a infinito, la stessa $N(t)$ puo' essere descritta da una distribuzione di Poisson, il che e' preferibile perche' i parametri di Poisson non dipendono da $n$

1. $N(t) = k, \quad n \gt k$
   
   divido $[0, t]$ in $n$-sottointervalli molto piccoli, $k$-eventi. Ogni sottointervallo e' ampio  $\frac{t}{n}$ e sono tutti equiampi. Questi intervalli sono minuscoli, infinitesimi
   
   - $A = \{1 \text{ occorrenza per ogni k-intervalli e } 0 \text{ occorrenze negli n-k intervalli}\}$
   
   - $B = \{\text{tutti gli altri casi}\}$, per esempio dove tutte le occorrenze occorrono in un solo intervallo
   
   - $N(t) = k \iff A \lor B$
   
   - $A \land B = \empty \qquad$ sono disgiunti per definizione
   
   - $P(B) = 0 \qquad$ perche' i sottointervalli sono molto piccoli e quindi per le proprieta' del processo stocastico questa P tende a 0
   
   - $P(N(t)=k) = P(A \lor B) = P(A) + P(B) = P(A)$

2. $P(A) = (\lambda \frac{t}{n})^k (1 - \lambda \frac{t}{n})^{n-k} \binom{n}{k} $

3. $N(t) \sim B(n, \lambda \frac{t}{n}) \qquad$ dove $p \coloneqq \lambda \frac{t}{n}$

4. Se immagino di far crescere $n \to \infin$, ma questo rende il binomiale approssimabile con una Poisson

5. $N(t) \approx \sim P(\lambda t)$

In generale:

$$
P(N(t) = k) = e^{-\lambda t} \frac{(\lambda t)^k}{k!} I_{\N \lor \{0\}}(k)
$$

#### Proprieta' degli intertempi

Usiamo delle variabili aleatorie le cui specificazioni indicano il tempo che passa dall'istante precedente (iniziale nella prima e dell'evento nelle altre) all'istante dell'occorrenza dell'evento, appunto intertempi tra un evento e l'altro

1. divido il mio intervallo di tempo $t$ in $n$-intervalli

2. assegno a ogni intertempo **tra un'occorrenza e un'altra** una variabile aleatoria:
   
   - $(0, t_1]$ e' il primo intertempo, dove in $t1$ e' occorso un evento. Lo assegno a $X_1$
   
   - $(t_1, t_2]$ e' il secondo intertempo, dove in $t_2$ e' occorso un altro evento. Lo assegno a $X_2$
   
   - ...

3. ottengo $X_1, X_2, ..., X_n \quad i.i.d.$

4.

$$
P(X_1 \gt t) = P(\text{nessuna occorrenza tra (0, t]}) = P(N(t) = 0) = 0 \\
\text{} \\
P(N(t) = 0) = e^{-\lambda t} \frac{(\lambda t)^0}{0!} = e^{-\lambda t} \\
\text{} \\
F_{X_1}(t) = P(X_1 \le t) = 1 - P(X_1 \gt t) = 1 - e^{-\lambda t} \\
\text{} \\
\implies \\
\text{} \\
X_1 \sim E(\lambda)
$$

5.

$$
P(X_2 \gt t | X_1 = s) = P(\text{nessuna occorrenza tra } (s, s+t]| X_1 = s) = \\
\text{} \\
= P(\text{nessuna occorrenza tra } (s, s+t]) = P(N(t) = 0) = e^{-\lambda t} \\
\text{} \\
\implies \\
\text{} \\
X_2 \sim E(\lambda) \\
\text{} \\
X_1 \text{ indipendente da } X_2
$$

In un processo di Poisson, il numero di occorrenze all'interno di un intervallo $t$ e' distribuito secondo un modello di Poisson di $\lambda$t, dove $t$ e' la grandezza dell'intervallo, e invece l'intertempo tra un'occorrenza e' l'altra e' distribuito secondo un modello esponenziale di parametro $\lambda$