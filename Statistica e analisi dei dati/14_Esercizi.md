# Esercizi

## 1

$$
X \sim B(p), \quad \theta = p, \quad \tau(\theta) = p, \quad T = \frac{X_1 + 2X_2 + X_3}{5}
$$

- T e' non deviato per p?

$$
E(T) = \frac{1}{5} E(X_1 + 2X_2 + X_3) = \frac{1}{5}(E(X_1) + 2E(X_2) + E(X_3)) = \\
\text{} \\
= \frac{1}{5} 4p \neq p
$$

- risposta
  
  - No, T non e' non deviato per p

- Qual e' il bias?

$$
b_T(p) = p - \frac{4}{5}p = \frac{p}{5} \\
\text{} \\
MSE_T(p) = Var(T) + b_T(p)^2 \\
\text{} \\
Var(T) = Var(\frac{X_1 + 2X_2 + X_3}{5}) = \frac{1}{25} Var(X_1 + 2X_2 + X_3) =  \frac{6}{25} p(1 - p) \\
\text{} \\
\text{} \\
MSE_T(p) = \frac{6}{25} p(1 - p) + \frac{p^2}{25} = \frac{p}{25}(6 - 5p)
$$

## 2

$$
X \sim N(\mu, \sigma), \quad X_1, X_2, \quad \theta = \sigma, \quad \tau(\theta) = \sigma^2 \\
\text{} \\
T = X_1^2 - X_1 X_2
$$

- T e' non deviato per $\sigma^2$?

$$
E(T) = E(X_1^2 - X_1 X_2) = E(X_1^2) - E(X_1)E(X_2) = E(X^2) - E(X)E(X) = \\
\text{} \\
= E(X^2) - E(X)^2 = \sigma^2
$$

- risposta
  
  - Si, T e' non deviato per $\sigma^2$

## 3

$$
X \sim U([0, \theta]), \quad \theta \gt 0, \quad \tau(\theta) = \theta \\
\text{} \\
T = \sum_i X_i
$$

- T e' non deviato per $\theta$?

$$
E(\bar{X}) = E(X) = \frac{\theta}{2} \neq \theta
$$

- risposta
  
  - No, T non e' non deviato per $\theta$

- trovare un T non deviato per $\theta$

$$
2 E(\bar{X}) = \theta, \quad E(2\bar{X}) = \theta, \quad T = 2\bar{X}
$$

- trovare Var(T)

$$
Var(T) = Var(2\bar{X}) = 4Var(\bar{X}) = 4 \frac{Var(X)}{n} = \frac{4}{n} \frac{\theta^2}{12} = \frac{\theta^2}{3n}
$$

- T e' consistente quadratico per $\theta$?

$$
\lim_{n \to \infin} MSE_T(\theta) = \lim_{n \to \infin} Var(T) = \lim_{n \to \infin} \frac{\theta^2}{3n} = 0
$$

- risposta
  
  - Si

## 4

$$
X \sim N(\mu, \sigma), \quad X_1, ..., X_n, \quad T = \frac{1}{3}\sum_{i=1}^{n} X_i
$$

- T e' non deviato per $\mu$? 

$$
E(T) = E(\frac{1}{3} \sum_{i=1}^{n} X_i) = \frac{n}{3} \mu \neq \mu
$$

- risposta
  
  - No per $n \neq 3$

- T gode di consistenza quadratica?

$$
Var(T) = \frac{1}{9} \sum_{i=1}^{n} \sigma^2 = \frac{n}{9} \sigma^2 \\
\text{} \\
b_T(\mu) = \mu(1 - \frac{n}{3}) \\
\text{} \\
MSE_T(\mu) = \lim_{n \to \infin} \frac{n}{9} \sigma^2 + \mu^2(1 - \frac{n}{3})^2 = \infin
$$

- risposta
  
  - No

## 5

$$
X \sim U([0, \theta]), \quad \theta \gt 0, \quad \tau(\theta) = \theta, \quad T" = 2\bar{X} \\
\text{} \\
T'= \max_{1 \le i \le n} X_i
$$
