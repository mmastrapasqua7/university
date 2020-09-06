## Modelli / Distribuzioni

### Distribuzione di Bernoulli / Modello bernoulliano (V.A. discreta)

Una V.A. si dice bernoulliana se puo' assumere solo i valori 0 e 1 (FALLIMENTO o SUCCESSO, binaria).

$$
X \sim B(p) \qquad p \in [0, 1] = \text{probabilita di successo} \\\\
\text{} \\
X = \begin{cases}
    0 & \text{esito FALLIMENTO} \\
    1 & \text{esito SUCCESSO} \\
\end{cases} \\
\text{} \\
P(X = 0) = 1 - p \\
P(X = 1) = p
$$

**proprieta**:

$$
p_X(x) = P(X = x) =p^x(1-p)^{1 - x} I_{\{0, 1\}}(x) \\
\text{} \\
E(X) = p \\
\text{} \\
Var(X) = p(1 - p) \qquad Var(X) \in [0, \frac{1}{4}]\\
\text{} \\
F_X(x) = P(X \le x) = (1-p)I_{[0, 1)}(x) + I_{[1,\infin)(x)}
$$

### Distribuzione binomiale (famiglia bernoulliana) (V.A. discreta)

Faccio un esperimento bernoulliano, ovvero  ~ B(p), dove faccio n-ripetizioni dell'esperimento **indipendenti**, esperimento che puo' concludersi con probabilita' p di concludersi con SUCCESSO, e probabilita' (1 - p) di concludersi con FALLIMENTO.

$$
X \sim B(n, p) \\
\text{} \\
X = \# \text{successi in n-ripetizioni indipendenti} = \sum_{i=1}^{n} X_i \\
\text{} \\
\text{dove} \\
\text{} \\
X_i = \begin{cases}
1 & \text{successo in prova i} \\
0 & \text{altrimenti}
\end{cases} \qquad X_i \sim B(p)
$$

**proprieta**:

$$
p_X(x) = P(X = x) = \binom{n}{x}p^x(1 - p)^{n - x} I_{\N \lor \{0\}}(x) \\
\text{} \\
\text{dove } p^x \text{ = x successi, } (1-p)^{n - x} \text{ = n-x fallimenti} \\
\text{} \\
\text{e } \binom{n}{x} \text{ sono i modi diversi di disporre successi e fallimenti} \\
\text{} \\
\text{} \\
\text{} \\
E(X) = np \\
\text{} \\
Var(X) = np(1 - p) \\
\text{} \\
F_X(x) = P(X \le x) = \sum_{j=1}^{n} \binom{n}{j} p^j(1 - p)^{n-j} I_{[0, n]}(x) + I_{(n, \infin)}(x)
$$

**proprieta 2**:

$$
X_1 \sim B(n, p) \\
X_2 \sim B(m, p) \\
\text{} \\
X = X_1 + X_2 = \text{\# successi su n+m ripetizioni} \\
\text{} \\
X \sim B(n + m, p)
$$

**esempio**: 

Un'azienda produce CD che sono difettosi con probabilita' 0.01. Questi dischetto sono poi venduti a stock da 10, con garanzia di rimborso se i numero di CD difettosi nello stock e' piu' di 1. Probabilita' di ritorno confezione? Probabilita' di ritorno di 1 stock se ne compro 3?

$$
X = \text{\# pezzi difettosi in uno stock da 10} \\
X \sim B(10, 0.01) \\
\text{} \\
P(X > 1) = ? \\
\text{} \\
P(X > 1) = 1 - P(X = 0) - P(X = 1) = \\
= 1 - \binom{10}{0} * 0.01^0 * 0.99^{10} - \binom{10}{1} * 0.01^1 * 0.99^{10} \approx 0.0043 \\
\text{} \\
Y = \text{\# scatole restituite} \\
Y \sim B(3, 0.0043) \\
\text{} \\
P(Y = 1) = ? \\
\text{} \\
P(Y = 1) = \binom{3}{1}* 0.0043^1 * 0.9957^3 = 0.0127
$$

### Distribuzione uniforme discreta (V.A. discreta)

Una V.A. distribuita in modo uniforme in un intervallo [a, b] se ha funzione di densita' di probabilita' costante in quell'intervallo. Tradotto: esiti equiprobabili

$$
X \sim U(n) \qquad n \in \N \\
\text{} \\
X = \text{\# esito} \\
\text{} \\
\text{dove} \\
\text{} \\
\forall i \in \N \quad P(X = i) = \frac{1}{n} \\
$$

**proprieta**:

$$
p_X(x) = P(X = x) = \frac{1}{n} I_{\N}(x) \\
\text{} \\
F_X(x) = P(X \le x) =  \frac{\lfloor X \rfloor}{n} I_{[1, n)}(x) + I_{[n, \infin)}(x) \\
\text{} \\
E(X) = \frac{n+1}{2} \\
\text{} \\
Var(X) = \frac{n^2 - 1}{12}
$$

### Distribuzione geometrica (V.A. discreta)

Una V.A. geometrica e' l'esito di un esperimento bernoulliano di parametro p (successo o fallimento) ripetuto in modo **indipendente** finche non ottengo successo (mi fermo al primo successo)

$$
X \sim G(p) \qquad p \in (0, 1] = \text{probabilita successo} \\
\text{} \\
X = \text{\# insuccessi} \\
\text{} \\
\forall i \in \N \qquad P(X = i) = (1 - p)^{i} p
$$

**proprieta'**:

$$
p_X(x) = P(X = x) = (1 - p)^x \space p \space I_{\N \lor \{0\}}(x) \\
\text{} \\
F_X(x) = P(X \le x) = 1 - P(X \gt x) = 1 - (1 - p)^{x + 1}\\
\text{} \\
E(X) = \frac{1 - p}{p} \\
\text{} \\
Var(X) = \frac{1 - p}{p^2}
$$

#### PROPRIETA: Assenza di memoria

Una V.A. discreta X possiede la mancanza di memoria se:

$$
X \sim G(p) \quad \text{e senza memoria} \\
\implies \\
\forall i, j \in \N \qquad P(X \ge i + j \space|\space X \ge i) = P(X \ge j)
$$

Non "ricorda il passato" ma si comporta come se fosse "nuova"

### Distribuzione di Poisson (V.A. discreta)

Dato che la distribuzione di Poisson approssima una binomiale, ovvero il limite a cui tende una distribuzione binomiale bernoulliana se le ripetizioni tendono a infinito e la probabilita' di successo tende a un valore basso, questa distribuzione e' adatta a questo tipo di problemi con tantissimi esperimenti e probabilita' bassa.

$$
X \sim P(\lambda) \qquad \lambda > 0 \\
\text{} \\
\forall i \in \N \qquad P(X = i) = e^{-\lambda}\frac{\lambda^i}{i!}
$$

**proprieta'**:

$$
p_X(x) = P(X = i) = e^{-\lambda} \frac{\lambda^i}{i!} \space I_{\N \lor \{0\}}(i) \\
\text{} \\
E(X) = \lambda \\
\text{} \\
Var(X) = \lambda
$$

#### Distribuzione di Poisson per approssimare binomiale

$$
\text{se } n \to \infin \quad \land \quad p  \to 0 \\
\lambda = np \\
X \sim B(n, p) \\
\implies \\
p_X(i) = P(X = i) \approx e^{-\lambda}\frac{\lambda^i}{i!}
$$

#### Riproducibilita' della distribuzione di Poisson

$$
X_1 \sim P(\lambda_1) \qquad X_2 \sim P(\lambda_2) \\
\implies \\
X_1 + X_2 \sim P(\lambda_1 + \lambda_2) \\
\text{} \\
\text{} \\
\text{} \\
X_1 \sim B(n, p) \qquad X_2 \sim B(m, q) \\
\implies \\
\text{} \\
B(\frac{\lambda_1}{r}, r) \sim B(\frac{\lambda_2}{r}, r) \\
\text{} \\
\implies \\
\text{} \\
X_1 + X_2 \sim B(\frac{\lambda_1 + \lambda_2}{r}, r) \sim P(\lambda_1 + \lambda_2)
$$

### Distribuzione ipergeometrica (V.A. discreta, modello urna)

- con reimmissione: binomiale

- senza reimmissione: ipergeometrica

$$
\text{IPERGEOMETRICO}(M, N, n) \\
\text{} \\
\forall i \in \N \qquad P(X = i) = \frac{\binom{N}{i}\binom{M}{n-i}}{\binom{M + N}{n}} \\
\text{} \\
\text{dove} \\
\text{} \\
M = \text{\# oggetti difettosi (costante)} \\
N = \text{\# oggetti funzionanti (costante)} \\
n = \text{\# oggetti estratti senza reimmissione} \\
X = \text{\# oggetti funzionanti estratti (V.A.)} \\
\text{} \\
E(X) = n \frac{N}{N + M} \\
\text{} \\
Var(X) = n \frac{NM}{(N + M)^2}(1 - \frac{n - 1}{N + M - 1})
$$

#### Distribuzione ipergeometrica + reimmissione = binomiale

Se pongo "p" come la frazione tra oggetti funzionanti e oggetti totali e faccio tendere a infinito il numero di oggetti, ovvero faccio l'esperimento su un urna con oggetti infiniti, nonostante la **dipendenza** delle singole variabili aleatorie booleane che rappresentano l'esito dell'estrazione, l'esperimento diventa di tipo bernoulliano binomiale.

Se estraggo un oggetto da un urna con pochi oggetti, tutto viene influenzato e quindi e' dipendente, ma se gli oggetti nell'urna sono infiniti, posso considerare le singole estrazioni indipendenti

$$
\text{se } p \coloneqq \frac{N}{N + M} \\
\text{} \\
\implies \\
\text{} \\
E(X) = np \\
\text{} \\
Var(X) = np(1 - p)(1 - \frac{n - 1}{N + M - 1}) \\
\text{} \\
\text{} \\
\text{} \\
\text{i-esima estrazione} \qquad X_i = \begin{cases}
1 & \text{i-esima estrazione funziona} \\
0 & \text{i-esima estrazione difettosa}
\end{cases} \\
\text{} \\
X = \sum_{i=1}^{n} X_i \\
\text{} \\
P(X_i = 1) = p \\
\text{} \\
E(X_i) = p \\
\text{} \\
Var(X_i) = \frac{NM}{(N + M)^2} = \frac{N}{N + M} \frac{M}{N + M} = p(1 - p) \\
\text{} \\
Cov(X_i, X_j) = E(X_i X_j) - E(X_i)E(X_j)
$$
