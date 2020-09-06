## Permutazioni

### Semplici

- N oggetti distinti
  - non posso ripetere un oggetto piu' volte
- N posti

SOLUZIONE:

$$
N!
$$

**esempio**: ci sono 4 persone che si vogliono sedere su una panchina da 4 posti numerati. In quanti modi posso far sedere tutte e 4 le persone? 4!

### A gruppi

- N oggetti distinti
  - non posso ripetere un oggetto piu' volte
  - categorizzabili in K categorie
    - Nk = numerosita' degli oggetti sotto la categoria k
- N posti

SOLUZIONE

$$
P_{N;N_1,...,N_k} = \frac{N!}{N_1! \space N_2! \space ... \space N_k!}
$$

**esempio**: ho 4 palline da ping pong, 2 rosse e 2 gialle. In quanti modi posso metterle in fila creando un pattern di colori diverso? 4! / (2! * 2!)

## Disposizioni (sequenze)

### Senza ripetizione

- N oggetti distinti
  - non posso ripetere un oggetto piu' volte
- K posti
  - K < N

SOLUZIONE

$$
d_{N,K} = \frac{N!}{(N-K)!}
$$

**esempio**: ci sono 4 persone che si vogliono sedere su una panchina da 2 posti numerati. In quanti modi posso riempire la panchina? 4! / (4 - 2)!

### Con ripetizione

- N oggetti
  - **posso** ripetere lo stesso oggetto piu' volte
- K posti

SOLUZIONE

$$
D_{N, K} = N^K
$$

**esempio**: ho 2 quadrettini, che posso colorare con 4 colori diversi. Quanti modi esistono di colorare o non colorare questi 2 quadrettini? 4^2

## Combinazioni (insiemi)

### Senza ripetizione (sottoinsiemi)

- N oggetti
  - non posso ripetere un oggetto piu' volte
- K posti nell'insieme
  - K < N
- **l'ordine non e' importante (e' un insieme)**

SOLUZIONE

$$
c_{N, K} = \binom{N}{K} = \frac{N!}{(N-K)! \space K!}
$$

**esempio**: voglio giocare alla lotteria. 90 numeri, solo 5 posti, l'ordine non e' importante, basta azzeccarli. Quante combinazioni vincenti esistono? 90! / ((90 - 5)! * 5!)

### Con ripetizione

- N oggetti
  - **posso** ripetere lo stesso oggetto piu' volte
- K posti nell'insieme
- **l'ordine non e' importante (e' un insieme)**

SOLUZIONE

$$
C_{N, K} = \binom{N+K-1}{K} = \frac{(N+K-1)!}{(N-1)! \space K!}
$$

**esempio**: ho 3 dadi a 6 facce. Quante combinazioni diverse di numeri posso avere (ordine non importante)? (6 + 3 - 1)! / ((6 - 1)! * 3!)
