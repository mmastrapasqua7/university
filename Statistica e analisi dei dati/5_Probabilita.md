### Teoria degli insiemi (ripasso)

$$
E \lor F = F \lor E
$$

$$
E \land F = F \land E
$$

$$
(E \lor F) \lor G = E \lor (F \lor G)
$$

$$
(E \land F) \land G = E \land (F \land G)
$$

$$
(E \lor F) \land G = (E \land G) \lor (F \land G)
$$

$$
(E \land F) \lor G = (E \lor G) \land (F \lor G)
$$

#### De Morgan

$$
(E \lor F)^c = E^c \land F^c
$$

$$
(E \land F)^c = E^c \lor F^c
$$

# Probabilita'

## Definizioni

- **Esito**: risultato di un esperimento
  
  $w \in \Omega$

- **Spazio degli esiti**: insieme che contiene tutti gli esiti possibili di un esperimento. Anche detto **evento certo**
  
  $\Omega$

- **Evento**: sottoinsieme dello spazio degli esiti
  
  $E \subset \Omega$
  
  - **un evento** $E$ **si dice verificato** quando l'esito dell'esperimento e' contenuto in $E$
    
    $E \text{ verificato} \iff w \in E \text{, dove } w \text{ e' l'esito dell'esperimento}$
  
  - **due eventi** $E$ **ed** $F$ **si dicono disgiunti o mutualmente esclusivi** quando l'intersezione dei due insiemi e' l'insieme vuoto
    
    $E \land F = \empty$
  
  - **un evento** $E^c$ **si dice complementare di** $E$ quando contiene tutti gli esiti di $\Omega$ che non stanno in $E$
    
    $\Omega^c = \empty$
    
    $x \in E^c \iff x \notin E$

## Algebra degli eventi

$$
\Alpha = \{E_i \subset \Omega\}
$$

**proprieta**:

1. $\Omega \in \Alpha$

2. $\forall E \qquad E \subset \Alpha \implies E^c \subset \Alpha$

3. $\forall E,F \qquad E \subset \Alpha \space \land \space F \subset \Alpha \implies E \lor F\subset \Alpha$

## Assiomi di Kolmogorov

$$
P: \Alpha \mapsto [0, 1]
$$

1. $P(\Omega) = 1$

2. $\forall E \in \Alpha \qquad 0 \le P(E) \le 1$

3. $\forall E_1, E_2 \in \Alpha, \quad E_1 \land E_2 = \empty \implies P(E_1 \lor E_2) = P(E_1) + P(E_2)$

### Proposizione 1

se vale l'assioma 3, allora:

$$
\forall E_1, ..., E_n, \quad \forall i \ne j \space E_i \land E_j = \empty \implies 
P(\bigcup_{i=1}^{n}E_i) = \sum_{i=1}^{n}P(E_i)
$$

### Proposizione 2

estensione dell'assioma 3 per ogni evento qualsiasi, anche non disgiunto

$$
P(E \lor F) = P(E) + P(F) - P(E \land F)
$$

### Proposizione 3

$$
1 = P(\Omega) = P(E) + P(E^c)
$$

## Teoria classica della probabilita'

$$
P(E) = \frac{\text{\# casi favorevoli}}{\text{\# casi possibili}}
$$

## Spazi equiprobabili

$$
\forall w \in \Omega \qquad P(\{w\}) = p = \frac{1}{p} \\
\implies \\
P(\Omega) = P(\{1\}) + ... + P(\{n\}) = np
$$

$$
\text{} \\
\forall E \subset \Omega \qquad E = \{e_1, ..., e_k\} \qquad k \le n \\
\implies \\
E = \{e_1\} \lor ... \lor \{e_k\} \\
P(E) = P(\{e_1\}) + ... + P(\{e_k\}) = kp = \frac{k}{n} = \frac{\#E}{n}
$$

## Probabilita condizionata

#### Formula 1

Utile per capire come il verificarsi di un evento influenzi o meno un altro evento

$$
P(E|F) = \frac{P(E \land F)}{P(F)}
$$

**esempio**:

Una confezione contiene 40 transistor: 25 funzionano, 10 funzionicchiano, 5 difettosi. Qual e' la probabilita' che il transistor funzioni, dato che non e' difettoso?

$$
F = \text{funziona} = 25/40 \\
ND = \text{non difettoso} = 35/40 \\
\text{} \\
P(F|ND) = \frac{P(F \land ND)}{P(ND)} = \frac{25/40}{35/40} = \frac{25}{35} = \frac{5}{7} = 0.714
$$

#### Formula 2

Utile quando si vuole calcolare la probabilita' di un'intersezione

$$
P(E \land F) = P(E|F)P(F)
$$

**esempio**:

Obama ha una probabilita' di 0.57 di essere eletto presidente. Se viene eletto, ho una probabilita' di 0.80 di essere scelto come vicepresidente. Che probabilita' ho di diventare vicepresidente?

$$
E = \text{Obama viene eletto} = 0.57 \\
V = \text{divento vicepresidente} = 0.80 \\
\text{} \\
P(V \land E) = P(V|E)P(E) = 0.80 * 0.57 = 0.456
$$

#### Formula 3 o Teorema delle probabilita' totali

Utile quando non e' possibile calcolare una probabilita' complessa direttamente, ma si puo' ricavare scegliendo un evento accessorio e usandolo per condizionare il verificarsi o meno dell'evento complesso

$$
P(E) = P(E \land F) + P(E \land F^c) = P(E|F)P(F) + P(E|F^c)P(F^c)
$$

**esempio**:

Il 30% della popolazione e' incline agli incidenti. Una persona incline agli incidenti ha probabilita' 0.4 di fare un incidente in un anno, mentre una persona non incline ne ha lo 0.2. Qual e' la probabilita' che pescando una persona a caso faccia un incidente entro un anno?

$$
H = \text{incline agli incidenti} = 0.3 \\
H^c = \text{non incline agli incidenti} = 0.7 \\
I_1 = \text{incidente in un anno} \\
\text{} \\
P(I_1) =
P(I_1|H)P(H) + P(I_1|H^c)P(H^c) = \\
= 0.4 * 0.3 + 0.2 * 0.7 = 0.12 + 0.14 = 0.26
$$

#### Formula 4 o Teorema di Bayes

Utile quando si vuole riconsiderare il proprio livello di convincimento / livello di confidenza su un fatto, alla luce di nuove informazioni

$$
P(E|F) = \frac{P(E \land F)}{P(F)} = \frac{P(F|E)P(E)}{P(F|E)P(E) + P(F|E^c){(E^c)}}
$$

**esempio**:

lo 0.5% della popolazione soffre di una malattia. Il tester per questa malattia sbaglia solo l'1% delle volte, sia in falsi positivi sia in falsi negativi. Presa una persona a caso dalla popolazione, se il test risulta positivo, qual e' la probabilita' che la persona sia **davvero** malata?

$$
P(E|M) = \text{esito positivo, risultato: malato} = 0.99 \\
P(M) = \text{sei veramente malato} = 0.005 \\
\text{} \\
P(M|E) =
\frac{P(M \land E)}{P(E)} =
\frac{P(E|M)P(M)}{P(E|M)P(M) + P(E|M^c)P(M^c)} = \\
\text{} \\
\frac{0.99 * 0.005}{0.99 * 0.005 + 0.01 * 0.995} = 0.332
$$

### Formula di fattorizzazione

Utile quando si vuole calcolare la probabilita di un evento E condizionando rispetto a quale si verifichi tra un gruppo di eventi accessori **F1, F2, ..., Fn mutualmente esclusivi che ricoprono S**

$$
P(E) = \sum_{i=1}^{n} P(E \land F_i) = \sum_{i=1}^{n} P(E|F_i)P(F_i)
$$

**esempio**:

Un'azienda produce 3 oggetti, il primo oggetto A e' il 60% della produzione totale, ed e' difettoso al 2% delle volte; B e' il 30% con difetti al 3%; C e' il restante 10% e' difettoso al 4%. Qual e' la probabilita' di pescare un oggetto difettoso?

$$
A: 60\%, 2\% \text{ difettoso} \\
B: 30\%, 3\% \text{difettoso} \\
C: 10\%, 4\% \text{difettoso} \\
P(\text{difettoso}) = ? \\
\text{} \\
P(D) = P(D|A)P(A) + P(D|B)P(B) + P(D|C)P(C) = \\
= 0.02 * 0.6 + 0.03 * 0.3 + 0.04 * 0.1 = 0.025 \space (2.5 \%)
$$

### Formula di Bayes

Utile perche mostra come e' necessario cambiare le proprie opinioni su delle ipotesi da prima a dopo l'esperimento stesso, con la probabilita' che cambia da ```P(Fj)``` a ```P(Fj|E)```

$$
P(F_j|E) = \frac{P(F_j \land E)}{P(E)} = \frac{P(E|F_j)P(F_j)}{\sum_{i=1}^{n} P(E|F_i)P(F_i)}
$$

**esempio (cont'd)**:

La probabilita di pescare una persona incline agli incidenti (evento H) dalla popolazione era di 0.3. Ma se l'incidente capita? Qual e' la probabilita' che l'incidente sia stato fatto proprio da una persona incline agli incidenti?

$$
P(H) = 0.3 \\
P(I_1|H) = 0.4 \\
P(I_1) = 0.26 \\
\text{} \\
P(H|I_1) =
\frac{P(H \land I_1)}{P(I_1)} =
\frac{P(I_1|H)P(H)}{P(I_1|H)P(H) + P(I_1|H^c)P(H^c)} = \\
\text{}\\
\frac{0.4 * 0.3}{0.26} =
0.461
$$

In questo esempio si vede chiaramente come l'ipotesi ```P(H) = 0.3``` viene rivalutata in seguito all'esperimento, ovvero che accade un incidente, portandola a ```P(H|I1) = 0.461```

### Classificatore Naive Bayes

L'ipotesi di sotto e' legata al teorema di Bayes, l'ingenuita' e' quella di poter sempre immaginare che gli attributi di un dataset siano tra loro indipendenti. Mi semplifica i calcoli perche' dovro' andare a calcolare $m + n$ probabilita' invece che $mn$.

$$
Y = y_k \qquad \text{eventi possibili} \\
\text{} \\
X_1, X_2, ..., X_n \qquad \text{attributi} \\
\text{} \\
X_1 = x_1 \qquad x_1 \text{ e' un possibile valore per l'attributo } X_1 \\
\text{} \\
X_2 = x_2, ..., X_n = x_n \\
\text{} \\
P(Y = y_k | X_1 = x_1, ..., X_n = x_n) = ? \\
\text{} \\
\text{applico teorema di Bayes (mn numeratori)} \\
\text{} \\
= \frac{P(X_1 = x_1, ..., X_n = x_n | Y = y_k)P(Y = y_k)}{P(X_1 = x_1, ..., X_n = x_n)} = \\
\text{} \\
\text{applico l'ingenuita': attributi indipendenti per cui intersezione = prodotto (m + n numeratori)} \\
\text{} \\
 = \frac{P(X_1 = x_1 | Y = y_k) * ... * P(X_n = x_n | Y = y_k)P(Y = y_k)}{P(X_1 = x_1, ..., X_n = x_n)} \propto \\
\text{} \\
\propto P(Y = y_k) \prod_{i=1}^{n} P(X_1 = x_1 | Y = y_k) \\
\text{} \\
k^* = \argmax_k P(Y = y_k) \prod_{i=1}^{n} P(X_1 = x_1 | Y = y_k)
$$

Voglio il k che massimizza questa produttoria per usarlo in un classificatore a soglia

### Eventi indipendenti

Due eventi E, F si dicono indipendenti se e solo se

$$
P(E|F) = P(E)
$$

Ovvero quando

$$
P(E \land F) = P(E)P(F)
$$

**esempio:**

Pesco 1 carta a caso da un mazzo di 52 carte. Se A e' l'evento che la carta sia un asso, e C l'evento che la carta sia di cuori. A e C sono eventi indipendenti?

$$
P(A) = \frac{4}{52} = \frac{1}{13} \\
\text{}\\
P(C) = \frac{13}{52} = \frac{1}{4} \\
\text{}\\
P(A \land C) = \frac{1}{52} \\
\text{}\\
A, C \text{ indipendenti} \implies P(A \land C) = P(A) * P(C) \\
\text{}\\
\frac{1}{52} = \frac{1}{13} * \frac{1}{4}
$$

#### Proposizione 1

$$
E, F \text{ indipendenti} \implies E, F^c \text{ indipendenti}
$$

#### Proposizione 2

n-eventi E1, E2, ..., En si dicono indipendenti se

$$
\text{per ogni sottogruppo Ea1, ..., Ear} \\
\text{con:} \\
1 \le a1 \lt ... \lt ar \le n \\
\text{vale:} \\
P(\bigcap_{i=1}^{r} E_{a_i}) = \prod_{i=1}^{r} P(E_{a_i})
$$
