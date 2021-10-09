# Classificatori

Immaginiamo di avere a disposizione un classificatore **binario**, costruito cioè per discriminare tra due classi che convenzionalmente indicheremo come **positiva** e **negativa**.

A partire da un insieme di oggetti di cui è noto a priori l'esito della classificazione possiamo valutare la bontà di questo classificatore calcolando il numero di casi (o la corrispondente frazione) che vengono classificati in modo errato. Notiamo però che ci sono due possibili modi di sbagliare la classificazione:

- un esempio positivo viene classificato come negativo, dando luogo a un cosiddetto **falso negativo**;
- un esempio negativo viene classificato come positivo, e in questo caso si parla di **falso positivo**.

Tenuto anche conto del fatto che tipicamente è molto difficile riuscire a ottenere un buon classificatre in termine sia di falsi positivi, sia di falsi negativi, un modo efficace di valutare entrambi questi tipi di errore consiste nel disegnare la **matrice di confusione**

### Sensibilita'

positivi **correttamente classificati** sul totale

$$
\text{sensibilita} = \frac{VP}{TP} = \frac{\text{Veri Positivi}}{\text{Totale Positivi}}
$$

### Specificita'

negativi **correttamente classificati** sul totale

$$
\text{specificita} = \frac{VN}{TN} = \frac{\text{Veri Negativi}}{\text{Totale Negativi}}
$$

* **proprieta**:
  
  $$
  1 - \text{specificita} = 1 - \frac{VN}{TN} = \frac{FP}{TN}
  $$

### Accuratezza

$$
\text{accuratezza} = \frac{\text{VP + VN}}{\text{\# totale casi}}
$$

## Matrice di confusione

|           | v.pos  | v.neg  |
|:---------:|:------:|:------:|
| **c.pos** | VP     | FP     |
| **c.neg** | FN     | VN     |
|           | **TP** | **TN** |

### Costante positivo (1, 1) spec:0, sens:1

|           | v.pos | v.neg |
|:---------:|:-----:|:-----:|
| **c.pos** | TP    | TN    |
| **c.neg** | 0     | 0     |

### Costante negativo (0, 0) spec:1, sens:0

|           | v.pos | v.neg |
|:---------:|:-----:|:-----:|
| **c.pos** | 0     | 0     |
| **c.neg** | TP    | TN    |

### Classificatore ideale (0, 1) spec:1, sens:1

|           | v.pos | v.neg |
|:---------:|:-----:|:-----:|
| **c.pos** | TP    | 0     |
| **c.neg** | 0     | TN    |

### Classificatore errato (1, 0) spec:0, sens:0

|           | v.pos | v.neg |
|:---------:|:-----:|:-----:|
| **c.pos** | 0     | TN    |
| **c.neg** | TP    | 0     |

## Grafico

- **asse x = 1 - specificita'**

- **asse y = sensibilita'**
  
  - **(1 - specificita', sensibilita')**
  
  - **(1 - VN/TN, VP/TP)**
  
  - **(FP/TN, VP/TP)**

# Classificatori a soglia

Un classificatore a soglia **effettua il procedimento di classificazione di un generico oggetto calcolando una quantità e verificando poi che quest'ultima sia superiore a una soglia prefissata**. Chiaramente, la costruzione di un tale tipo di classificatore richiede anche di fissare questo valore per la soglia. Gli indici di sensibilità e specificità possono essere utilizzati proprio per questo scopo: indicato con $\theta$. Una volta fissato, individuo un intervallo di ampiezza $[\theta_{\text{min}}, \theta_{\text{max}}]$ in cui faccio variare il valore. Ogni volta che vario il valore, rifaccio la classificazione e mi calcolo sensibilita' e specificita' con quella data soglia. Unendo tutti i punti di (sensibilita', specificita') al variare della soglia creo quella che si chiama una **curva ROC**. Ha sempre origine (0, 0) = (CN) e (1,1) = (CP) come estremi. **L'area sotto la curva ROC viene chiamata AUC (Area Under the Curve)**, piu' si avvicina a 1, piu' il classificatore con quella determinata soglia approssima il classificatore ideale. Piu' la curva ROC si avvicina alla bisettrice, piu' il classificatore sara' vicino a quello casuale, piu' l'area AUC sara' prossima a 0.5.

## Classificatori probabilistici

Un caso speciale di classificatori a soglia è costituito dai cosiddetti **classificatori probabilistici** che associano a un oggetto una stima della **probabilità** che questo appartenga alle varie classi. Questo classificatore quindi dati degli oggetti sputa fuori delle probabilita' per ognuno degli oggetti, e quella probabilita' descrive appunto il grado di fiducia che quell'oggetto sia di tale classe o meno

**Un classificatore probabilistico puo' essere convertito in un classificatore a soglia**, semplicemente usando come soglia un certo grado di probabilita', e assegnando le classi in base a quella soglia. Se nel problema considerato ci sono solo due classi (e in questi casi si parla di **classificazione binaria**), un classificatore probabilistico emetterà la sola probabilità di appartenenza alla classe positiva, nell'idea che l'appartenenza alla classe negativa si ottenga in modo complementare.