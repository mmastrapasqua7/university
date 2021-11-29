# Information Disclosure: protezioni

- **masking techniques**
	- **non-perturbative** (sampling, generalizzazione , soppressione)
	- **perturbative** (rounding, swapping)
- **synthetic data generation techniques**
	- **fully synthetic** (syntethic data only)
	- **partially synthetic** (mix of original and synthetic)

## Identity disclosure

### anonymity problem

**De-identification is necessary but not sufficient**

Problema dell'identity disclosure
- [[Kanonymity]]

## Attribute Disclosure

Problema dell'attribute disclosure

### Homogeneity attack

Anche se applico k-anonymity, associate alle tuple possono esserci degli attributi sensibili associati. Problema: sono tutti uguali, posso inferire, singolo valore

- [[Ldiversity]]

### Background/External knowledge attack

Posso inoltre usare la background knowledge per inferire molto altro. Ad esempio quando ho informazioni esterne e valori sensibili distribuiti, posso scartare le opzioni e comunque trovare informazioni

Knowledge can be about
- **target**
- **others**
- **same-value families**

- [[Ldiversity]]

### Similarity attack

Un blocco q è l-diverso ma il problema è che semanticamente sono molto simili: gastrite e ulcera sono malattie all'apparato digestivo

### Skewness attack

La distribuzione in un blocco q è diversa dalla distribuzione reale nella popolazione. Esempio: una persona presa a caso ha il 20% di possibilità di avere il diabete (statistiche nazionali), se la trovo in un blocco q e il 75% nel blocco q ha il diabete, la confidenza aumenta

- [[Tcloseness]]

### Multiple independent releases (longitudinal)

Non possono essere indipendenti assolutamente

#### Intersection attacks

Dati che hanno bisogno di essere pubblicati su basi regolari. Il rilascio multiplo può causare information leakage per via della correlazione tra i dataset

- [[Minvariance]]

# Classification of attributes

- **identifiers**
- **quasi-identifiers** (attributes that in combination can be linked with external information to re-identify a respondent: DoB, ZIP, Sex)
- **confidential** (sensitive information, like desease)
- **non-confidential**

# Masking techniques

## Sampling

## Local suppression

Semplicemente sopprimo il valore degli attributi sensibili o di celle sensibili lasciandoli vuoti

## Global recoding

Il dominio degli attributi è **partizionato a intervalli disgiunti** della stessa lunghezza. Le celle vengono sostituite dal label dell'intervallo. Tipo: 100K income diventa "medio" di label.

### Top-coding

Definisce un upper limit per ogni attributo da proteggere. Se la cella è sopra l'upper limit, viene **flaggata** con un label speciale

### Bottom-coding

Se la cella ha un valore sotto il lower limit, viene flaggata con un label speciale

## Generalization

## Random noise

Perturba il valore delle celle sensibili moltiplicando la variabile per un valore, usando una distribuzione data per generarlo. La distribuzione non viene pubblicata perchè aumenta il rischio di disclosure

## Swapping

Faccio un campione e cerco di fare un match su un determinato numero di variabili sulla stessa tabella. Quando trovo il match, le variabili predefinite restano uguali, ma faccio lo **swap** di tutti gli altri valori. Riduce il rischio di identificazione

## Micro-aggregation (blurring)

Raggruppo tuple in gruppi della stessa dimensione, per i valori sensibili faccio una media e **pubblico la media** invece del valore sensibile. I gruppi vengono scelti col criterio di massima somiglianza

# Synthetic techniques

I dati sintetici devono poter offrire le stesse proprietà statistiche di quelli reali. Il vantaggio è che nessuno dei dati si rivolge a un vero rispondente