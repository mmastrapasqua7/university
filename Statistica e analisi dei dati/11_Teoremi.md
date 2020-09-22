## Teoremi

### Teorema centrale del limite

Le V.A. sono indipendenti e identicamente distribuite, non sappiamo quale distribuzione, ma sappiamo che sono tutte uguali e indipendenti. Questa approssimazione diventa sempre piu' precisa all'aumentare degli addendi Xi.

$$
X_1, X_2, ..., X_n \space \text{i.i.d.} \\
\text{} \\
\mu = E(X_i) \\
\text{} \\
\sigma = \sqrt{Var(X_i)} \quad \forall i \\
\text{} \\
\implies \\
\text{} \\
\sum_{i=1}^{n}X_i \approx \sim N(n \mu, \sqrt{n} \sigma) \qquad \text{NORMALE} \\
\text{} \\
Z \coloneqq \frac{\sum_{i=1}^{n} X_i - n \mu}{\sqrt{n} \sigma} \approx \sim N(0, 1) \qquad \text{NORMALE STANDARD}\\
\text{} \\
P(Z \le x) \approx \Phi(x)
$$

**esempio**:

Ci sono 25k polizze assicurative. Sia Xi il risarcimento annuo del cliente i, qual e' la probabilita' di dover pagare dei risarcimenti per piu' di 8,3m di euro in un anno?

$$
X_i = \text{risarcimento annuo cliente i} \\
E(X_i) = 320\$ \\
\sigma_{X_i} = 540\$ \\
X \coloneqq \text{risarcimento totale annuo} = \sum_{i = 1}^{25000} X_i \\
P(X > 8,300,000\$) = ? \\
\text{} \\
\text{} \\
\text{applico il teorema del limite centrale} \\
\text{} \\
\text{} \\
X \sim N(25000 * 320, \sqrt{25000}*540) \approx \\
N(8*10^6, 8.54*10^4) \\
\text{} \\
P(X > 8.3 * 10^6) = P(\frac{X - 8*10^6}{8.54 * 10^4} \gt \frac{8.3*10^6 - 8*10^6}{8.54*10^4}) \approx \\
\text{} \\
\approx P(Z > 3.51) = 1 - \Phi(3.51) \approx 2.2 * 10^{-4}
$$

#### V.A. bernoulliane + indipendenza approssimate da normale

E' da preferirsi il caso binomiale perche' piu' precisa e non approssimata, ma a volte e' preferibile il caso della normale. Per esempio, quando ho un numero elevato di addendi, dover fare i calcoli col binomiale, dove posso ottenere valori astronomici, sarebbe stato scomodo, quando, usando una normale, tutto si riduce a delle banali operazioni

$$
X_1, X_2, ..., X_n \sim B(p) \qquad \forall i \text{ + INDIPENDENZA} \\
\implies \\
X \coloneqq \sum_{i=1}^{n}X_i \approx \sim N(np, \sqrt{np(1 - p)})
\text{} \\
\text{} \\
X \sim B(n, p)
$$

**esempio**:

Ho una capienza in aula di 150 persone. Ci sono 450 persone iscritte al corso, di cui il 30% lo segue in presenza. Probabilita che l'aula sia insufficiente?

$$
X_i = \begin{cases}
1 & \text{studente in presenza} \\
0 & \text{altrimenti}
\end{cases} \\
\text{} \\
X \coloneqq \sum_{i=1}^{450} X_i \\
\text{} \\
P(X > 150) = \sum_{i=151}^{450} P(X = i) = ? \\
\text{} \\
\text{dove } \qquad X_i \sim B(p) \qquad X \sim B(450, p) \qquad p = 0.3 \\
\text{} \\
\text{} \\
\text{STANDARDIZZO (USO LA NORMALE):} \\
\text{} \\
\text{} \\
np = 450 * 0.3 = 135 \\
\text{} \\
\sqrt{np(1-p)} = 9.72 \\
\text{} \\
P(X > 150) = P(\frac{X - 135}{9.72} \gt \frac{150 - 135}{9.72}) \approx \\
\text{} \\
\approx P(Z \gt 1.59) = 1 - P(Z \le 1.59) = 1 - \Phi(1.59) \approx 0.06
$$

#### V.A. binomiali + indipendenza approssimate da normale

Se fossi partito da n-addendi binomiali invece che bernoulliani? Posso approssimare con lo stesso procedimento le binomiali con la normale

$$
X_1, X_2, ..., X_n \sim B(m, p) \qquad \forall i \\
\text{} \\
X \coloneqq \sum_{i=1}^{n} X_i \sim B(nm, p)
$$

#### V.A. normali + indipendenza =  normale (no approx)

Se gli n-addendi sono normali, quello che ottengo non e' piu' un approssimazione, ma ottengo qualcosa di esatto, un'uguaglianza, a differenza del teorema centrale del limite che offre un'approssimazione

$$
X_1, X_2, ..., X_n \sim N(\mu, \sigma) \qquad \forall i \\
\text{} \\
X \coloneqq \sum_{i=1}^{n} X_i \sim N(n\mu, \sqrt{n}\sigma)
$$
