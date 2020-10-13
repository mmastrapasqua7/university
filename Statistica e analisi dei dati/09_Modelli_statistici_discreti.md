## Modelli di v.a. discrete

### Modello di Bernoulli

Una V.A. si dice bernoulliana se puo' assumere solo i valori 0 e 1 (FALLIMENTO o SUCCESSO, binaria).

$$
X \sim B(p) \\
\text{} \\
X = \begin{cases}
    0 & \text{esito fallimento} \\
    1 & \text{esito successo} \\
\end{cases} \\
\text{} \\
P(X = 0) = 1 - p \\
P(X = 1) = p
$$

**caratteristiche**:

$$
p_X(x) = p^x(1-p)^{1 - x} I_{\{0, 1\}}(x) \\
\text{} \\
F_X(x) = (1-p)I_{[0, 1)}(x) + I_{[1,\infin)(x)} \\
\text{} \\
E(X) = p \\
\text{} \\
Var(X) = p(1 - p)
$$

**proprieta**:

$$
Var(X) \in [0, \frac{1}{4}]
$$

### Modello binomiale (famiglia bernoulliana)

Faccio un esperimento bernoulliano, ovvero $X \sim B(p)$, dove faccio n-ripetizioni dell'esperimento **indipendenti**, esperimento che puo' concludersi con probabilita' p di concludersi con successo, e probabilita' (1 - p) di concludersi con fallimento.

$$
X \sim B(n, p) \\
\text{} \\
X = \# \text{ successi in n-ripetizioni indipendenti} = \sum_{i=1}^{n} X_i \\
\text{} \\
X_i \sim B(p) \\
\text{} \\
X_i = \begin{cases}
1 & \text{successo in prova i-esima} \\
0 & \text{altrimenti}
\end{cases}
$$

**caratteristiche**:

$$
p_X(x) = p^x(1 - p)^{n - x} \binom{n}{x} I_{\{0, ..., n\}}(x) \\
\text{} \\
F_X(x) = \sum_{i=0}^{x} p^i(1 - p)^{n-i} \binom{n}{i} I_{[0, n]}(x) + I_{(n, \infin)}(x) \\
\text{} \\
E(X) = np \\
\text{} \\
Var(X) = np(1 - p)
$$

dove

- $p^x$ = $x$ successi

- $(1-p)^{n - x}$ = $n-x$ fallimenti

- $\binom{n}{x}$ sono i modi diversi di piazzare le posizioni dei successi

**proprieta**:

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

### Modello geometrico (famiglia bernoulliana)

Una V.A. geometrica e' l'esito di un esperimento bernoulliano di parametro p (successo o fallimento) ripetuto in modo **indipendente** finche non ottengo successo (mi fermo al primo successo)

$$
X \sim G(p) \qquad p \in (0, 1]\\
\text{} \\
X = \text{\# insuccessi prima di 1 successo} \\
\text{} \\
\forall i \in \N \qquad P(X = i) = (1 - p)^{i} p
$$

**caratteristiche**:

$$
p_X(x) = (1 - p)^x \space p \space I_{\N \lor \{0\}}(x) \\
\text{} \\
F_X(x) = 1 - P(X \gt x) = (1 - (1 - p)^{x + 1}) I_{[0, \infin)}(x)\\
\text{} \\
E(X) = \frac{1 - p}{p} \\
\text{} \\
Var(X) = \frac{1 - p}{p^2}
$$

**proprieta**:

$p \in (0, 1]$, infatti:

- $p = 0$ vuol dire che l'esperimento non avra' mai successo, per cui e' escluso (valore infinito di insuccessi)

- $p = 1$ vuol dire che l'esperimento ha sempre successo, e la v.a. assume valore costante 0 (v.a. degenere), ma puo' essere incluso

prende il nome dalla **serie geometrica**:

$$
\sum_{i=0}^{\infin} \alpha^i = \frac{1}{1 - \alpha} \qquad |\alpha| \lt 1
$$

#### PROPRIETA: Assenza di memoria

Una V.A. discreta X possiede la mancanza di memoria se:

$$
X \sim G(p) \quad \text{e senza memoria} \\
\text{} \\
\implies \\
\text{} \\
\forall i, j \in \N \qquad P(X \ge i + j \space|\space X \ge i) = P(X \ge j)
$$

**dim**:

$$
P(X \ge i + j| X \ge i) = \frac{P(X \ge i + j \land X \ge i)}{P(X \ge i)} = \\
\text{} \\
= \frac{P(X \ge i + j)}{P(X \ge i)} = \frac{(1 - p)^{x + j}}{(1 - p)^x} = (1 - p)^j = P(X \ge j)
$$

Non "ricorda il passato" ma si comporta come se fosse "nuova"

### Modello uniforme discreto

Una V.A. distribuita in modo uniforme in un intervallo [a, b] se ha funzione di densita' di probabilita' costante in quell'intervallo. Tradotto: esiti equiprobabili

$$
X \sim U(n) \\
\text{} \\
X = \text{\# esito} \\
\text{} \\
\text{dove} \\
\text{} \\
\forall i \in \N \quad P(X = i) = \frac{1}{n} \\
$$

**caratteristiche**:

$$
p_X(x) = \frac{1}{n} I_{\{1, ..., n\}}(x) \\
\text{} \\
F_X(x) = \frac{\lfloor x \rfloor}{n} I_{[1, n)}(x) + I_{[n, \infin)}(x) \\
\text{} \\
E(X) = \frac{n+1}{2} \\
\text{} \\
Var(X) = \frac{n^2 - 1}{12}
$$

### Modello di Poisson

Dato che la distribuzione di Poisson approssima una binomiale, ovvero il limite a cui tende una distribuzione binomiale bernoulliana se le ripetizioni tendono a infinito e la probabilita' di successo tende a un valore basso, questa distribuzione e' adatta a questo tipo di problemi con tantissimi esperimenti e probabilita' bassa.

$$
X \sim P(\lambda) \qquad \lambda > 0 \\
\text{} \\
\forall i \in \N \qquad P(X = i) = e^{-\lambda}\frac{\lambda^i}{i!}
$$

**proprieta**:

$$
p_X(x) = e^{-\lambda} \frac{\lambda^x}{x!} \space I_{\N \lor \{0\}}(x) \\
\text{} \\
E(X) = \lambda \\
\text{} \\
Var(X) = \lambda
$$

#### Modello di Poisson per approssimare binomiale

Posso vedere la distribuzione di Poisson come il limite di tante distribuzioni di bernoulli dove $n \to \infin$ ma controbilanciato da $p \to 0$ tale che il prodotto $np$ e' costante, e viene chiamato $\lambda$

$$
X \sim B(n, p) \\
\text{} \\
\text{se } n \to \infin \quad \text{e} \quad p  \to 0 \\
\lambda = np \quad \text{costante} \\
\text{} \\
\implies \\
\text{} \\
X \sim P(np) = P(\lambda) \\
\text{} \\
p_X(x) \approx e^{-\lambda}\frac{\lambda^x}{x!}
$$

#### Riproducibilita' del modello di Poisson (grazie alla binomiale)

- n. refusi pagina di un libro

- n. telefonate in una giornata

- n. componenti che si guastano

- n. individui centenari popolazione

$$
X_1 \sim P(\lambda_1) \qquad X_2 \sim P(\lambda_2) \\
\implies \\
X_1 + X_2 \sim P(\lambda_1 + \lambda_2)
$$

#### Riproducibilita' + approssimazione binomiale

$$
X_1 \sim P(\lambda_1) \qquad X_2 \sim P(\lambda_2) \\
X_1 \sim B(n, p) \qquad X_2 \sim B(m, q) \\
\text{} \\
\implies \\
\text{} \\
\text{voglio } \lambda_1 = np \text{ e } \lambda_2 = mq \\
\text{} \\
\implies \\
\text{} \\
B(\frac{\lambda_1}{r}, r) \sim B(\frac{\lambda_2}{r}, r) \\
\text{} \\
\implies \\
\text{} \\
X_1 + X_2 \sim B(\frac{\lambda_1 + \lambda_2}{r}, r) \sim P(\lambda_1 + \lambda_2)
$$

Data la proprieta' rispetto alla somma delle v.a. di Poisson, e dato che le Poisson approssimano al limite le binomiali $B(n, p)$, allora metto a uguaglianza $\lambda = np$, e faccio si che $np = \lambda$. Un modo per farlo e' quello di dividere per $r$, ovvero costruisco la mia binomiale di parametri $B(\frac{\lambda_1}{r}, r)$ cosi' che $\frac{\lambda_1}{r}r = \lambda_1$

### Modello ipergeometrico (modello urna)

- con reimmissione: binomiale

- senza reimmissione: ipergeometrica

$$
\text{IPERGEOMETRICO}(M, N, n) \\
\text{} \\
X = \text{\# oggetti funzionanti estratti} \\
\text{} \\
\text{dove} \\
\text{} \\
M = \text{\# oggetti difettosi (costante)} \\
N = \text{\# oggetti funzionanti (costante)} \\
n = \text{\# oggetti estratti senza reimmissione}
$$

**caratteristiche**

$$
p_X(x) = \frac{\binom{N}{x}\binom{M}{n-x}}{\binom{N + M}{n}} I_{\{0, ..., n\}}(x) \\
\text{} \\
E(X) = n \frac{N}{N + M} \\
\text{} \\
Var(X) = n \frac{NM}{(N + M)^2}(1 - \frac{n - 1}{N + M - 1})
$$

**proprieta**:

Attenzione alle specificazioni:

$$
M =  1, N = 5, n = 2 \\
\text{} \\
\text{IPERGEOMETRICO}(1, 5, 2) \\
\text{} \\
p_X(0) = \binom{1}{2} \text{ binomiale negativo!!!}
$$

#### Modello ipergeometrico + reimmissione = binomiale

Se pongo $p$ come la frazione tra oggetti funzionanti e oggetti totali e faccio tendere a infinito il numero di oggetti, ovvero faccio l'esperimento su un urna con oggetti infiniti, nonostante la **dipendenza** delle singole variabili aleatorie booleane che rappresentano l'esito dell'estrazione, l'esperimento diventa di tipo bernoulliano binomiale.

Se estraggo un oggetto da un urna con pochi oggetti, tutto viene influenzato e quindi e' dipendente, ma se gli oggetti nell'urna sono infiniti, posso considerare le singole estrazioni indipendenti

$$
E(X) = n \frac{N}{N + M} \\
\text{} \\
\text{per } p \coloneqq \frac{N}{N + M} \\
\text{} \\
\implies \\
\text{} \\
E(X) = np \\
\text{} \\
\text{} \\
\text{} \\
Var(X) = np(1 - p)(1 - \frac{n - 1}{N + M - 1}) \\
\text{} \\
\text{per } (N + M) \to \infin \\
\text{} \\
\implies \\
\text{} \\
Var(X) = np(1 - p) \\
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