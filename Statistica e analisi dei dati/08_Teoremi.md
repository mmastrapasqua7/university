## Teoremi

La disuguaglianza di Markov e di Chebyshev permettono di limitare la probabilita di eventi rari che riguardano V.A. di cui si conosce poco, come il valore atteso (Markov) o valore atteso e deviazione standard (Chebyshev)

### Disuguaglianza di Markov (v.a. discrete e continue)

$$
X \ge 0 \implies \forall a \gt 0 \quad P(X \ge a) \le \frac{\mu}{a} \\
\text{} \\
\text{dove} \\
\text{} \\
\mu \coloneqq E(X)
$$

**proprieta**:

$$
P(X \lt a) = 1 - P(X \ge a) \ge 1 - \frac{\mu}{a}
$$

### Disuguaglianza di Chebyshev (v.a. discrete e continue)

$$
\forall r > 0 \qquad P(|X - \mu| \ge r) \le \frac{\sigma^2}{r^2} \\
\text{} \\
\text{dove} \\
\text{} \\
\mu \coloneqq E(X) \qquad \sigma^2 \coloneqq Var(X)
$$

**proprieta**:

La probabilita' che una V.A. differisca dalla sua media per piu' di k-volte la sua deviazione standard non puo' superare il valore di 1 / (k^2)

$$
k \sigma \coloneqq r \\
P(|X - \mu| \ge k \sigma) \le \frac{1}{k^2}
$$

**esempio**:

$$
X = \text{\# pezzi prodotti in una settimana} \\
E(X) = 50 \text{ (media pezzi)} \\
P(X \ge 75) = ? \\
\text{} \\
\text{applico Markov} \\
\text{} \\
P(X \ge 75) \le \frac{E(X)}{75} = \frac{50}{75} = \frac{2}{3} \\
\text{} \\
\text{} \\
\text{} \\
\text{ipotizzando } \sigma^2 = 25 \text{, } P(40 \le X \le 60) = ? \\
\text{} \\
\text{applico Chebyshev} \\
\text{} \\
P(|X - 50| \ge 10) \le \frac{25}{10^2} = \frac{1}{4} \implies \\
\text{} \\
P(|X - 50| \le 10) \ge 1 - \frac{1}{4} = \frac{3}{4}
$$