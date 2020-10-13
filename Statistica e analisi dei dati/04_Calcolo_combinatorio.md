# Calcolo combinaorio

**PRINCIPIO FONDAMENTALE DEL CALCOLO COMBINATORIO**: se ci sono $s_1$ modi per operare una scelta e, per ciascuno di essi, ci sono $s_2$ modi per operare una seconda scelta e, per ciascuno di essi ci sono $s_3$ modi per operare una terza scelta e così via fino a $s_t$ modi per operare la $t$-esima scelta, allora il numero delle sequenze di possibili scelte e' $s_1 * s_2 * ... * s_t$

## Permutazioni

### Semplici

- $n$-oggetti distinti
  - non posso ripetere un oggetto piu' volte
- $n$-posti

SOLUZIONE:

$$
p_n = n!
$$

**esempio**: ci sono 4 persone che si vogliono sedere su una panchina da 4 posti numerati. In quanti modi posso far sedere tutte e 4 le persone? 4!

### Di oggetti distinguibili a gruppi

- $n$-oggetti distinti
  - non posso ripetere un oggetto piu' volte
  - categorizzabili in $k$ categorie
    - $n_k$ = numerosita' degli oggetti sotto la categoria $k$
- $n$-posti

SOLUZIONE

$$
P_{n;n_1,...,n_k} = \frac{n!}{n_1! \space n_2! \space ... \space n_k!} = \binom{n}{n_1!, n_2!, ..., n_k!}
$$

anche chiamato **coefficiente multinomiale**

- **spiegazione**: a ogni **configurazione diversa**, corrispondono $n_1!*...*n_k!$ **permutazioni semplici**, per cui basta dividere il numero di permutazioni semplici per il numero di permutazioni semplici per configurazione
  
  $$
  P_{n;n_1, ...,n_k} = \text{numero configurazioni diverse} \\
\text{} \\
n! = P_{n;n_1, ..., n_k} * n_1! * ... * n_k! \\
\text{} \\
\frac{n!}{n_1!*...*n_k!} = P_{n;n_1, ..., n_k}
  $$

**esempio**: ho 4 palline da ping pong, 2 rosse e 2 gialle. In quanti modi posso metterle in fila creando un pattern di colori diverso? 4! / (2! * 2!)

## Disposizioni (sequenze)

### Senza ripetizione (semplici)

- $n$-oggetti distinti
  - non posso ripetere un oggetto piu' volte
- $k$-posti
  - $k \le n$

SOLUZIONE

$$
d_{n,k} = \frac{n!}{(n-k)!}
$$

**esempio**: ci sono 4 persone che si vogliono sedere su una panchina da 2 posti numerati. In quanti modi posso riempire la panchina? 4! / (4 - 2)!

- **proprieta**: le permutazioni semplici sono un caso particolare delle disposizioni semplici in cui il numero di posti e' uguale al numero di oggetti, ovvero in cui $k = n$

- **spiegazione**: presi $n$-oggetti distinti $k$ alla volta, pescati a caso, se ci compongo tutte le loro combinazioni salta fuori la relazione:
  
  $$
  d_{n,k} = c_{n,k} * k!
  $$

### Con ripetizione

- $n$-oggetti
  - **posso** ripetere lo stesso oggetto piu' volte
- $k$-posti

SOLUZIONE

$$
D_{n, k} = n^k
$$

**esempio**: ho 2 quadrettini, che posso colorare con 4 colori diversi. Quanti modi esistono di colorare o non colorare questi 2 quadrettini? 4^2

## Combinazioni (insiemi)

### Senza ripetizione (sottoinsiemi) (semplici)

- $n$-oggetti
  - non posso ripetere un oggetto piu' volte
- $k$-posti nell'insieme
  - $k \le n$
- **l'ordine non e' importante (e' un insieme)**

SOLUZIONE

$$
c_{n, k} = \frac{d_{n,k}}{k!} = \frac{n!}{(n-k)! \space k!} = \binom{n}{k} 
$$

**esempio**: voglio giocare alla lotteria. 90 numeri, solo 5 posti, l'ordine non e' importante, basta azzeccarli. Quante combinazioni vincenti esistono? 90! / ((90 - 5)! * 5!)

### Con ripetizione

- $n$-oggetti
  - **posso** ripetere lo stesso oggetto piu' volte
- $k$-posti nell'insieme
- **l'ordine non e' importante (e' un insieme)**

SOLUZIONE

$$
C_{n, k} = \frac{(n+k-1)!}{(n-1)! \space k!} = \binom{n+k-1}{k}
$$

**esempio**: ho 3 dadi a 6 facce. Quante combinazioni diverse di numeri posso avere (ordine non importante)? (6 + 3 - 1)! / ((6 - 1)! * 3!)