## Variabili aleatorie continue

### Densita di probabilita

$$
f_X : \R \mapsto \R^+ \\
\text{} \\
\forall B \subset \R \qquad P(X \in B) = \int_{B} f_X(x)dx \\
\text{} \\
\text{dove X e' una V.A. continua}
$$

**proprieta**

$$
1 = P(X \in \R) = \int_{-\infin}^{\infin}f_X(x) dx \\
\text{} \\
P(a \le X \le b) = \int_a^b f_X(x) dx \\
\text{} \\
P(X = a) = \int_a^a f_X(x) dx = 0
$$

**esempio**:

$$
f_X(x) = \begin{cases}
  c(4x - 2x^2) &\text{se } 0 \le X \le 2 \\
  0 &\text{altrimenti}
\end{cases} \\
\text{} \\
\text{} \\
\text{c = ? t.c. P(X > 1)} \\
\text{} \\
f_X(x) = c(4x - 2x^2)I_{[0,2]}(x) \\
\text{} \\
1 = \int_{-\infin}^{\infin} f_X(x) dx = \int_{0}^{2} c(4x - 2x^2)dx = \\
\text{} \\
= c \begin{vmatrix}
   4\frac{x^2}{2} - 2\frac{x^3}{3}
\end{vmatrix}_{0}^{2} = c(8 - 8\frac{2}{3}) = \frac{8}{3} c \to c = \frac{3}{8} \\
\text{} \\
\text{} \\
P(X > 1) = ? \\
\text{} \\
P(X > 1) = \int_{1}^{\infin}f_X(x)dx = \int_{1}^{2} \frac{3}{8}(4x - 2x^2)dx = ... = \\
\text{} \\
= \frac{3}{8} \begin{vmatrix}
   \frac{x^2}{2} - 2\frac{x^3}{3}
\end{vmatrix}_{1}^{2} = ... = \frac{1}{2}
$$

### Funzione di ripartizione

$$
F_X(a) = P(X \le a) \coloneqq P(X \in (-\infin, a]) = \int_{-\infin}^{a} f_X(x) dx
$$

**proprieta**:

$$
\lim_{x \to -\infin} F_X(x) = 0 \\
\text{} \\
\lim_{x \to \infin} F_X(x) = 1
$$

#### Relazione fondamentale

La densita' di probabilita' e' la derivata della funzione di ripartizione

$$
\frac{d}{dx} F_X(x) = f_X(x) \\
\text{} \\
F_X(x) = \int f_X(x)dx
$$

### Valore atteso

$$
E(X) = \int_{-\infin}^{\infin}x f_X(x) dx
$$

**proprieta'**:

$$
X \ge 0 \\
\implies \\
E(X) = \int_{0}^{\infin}1 - F_X(x) \space dx
$$

### Varianza

$$
Var(X) = E((X - \mu_X)^2)
$$
