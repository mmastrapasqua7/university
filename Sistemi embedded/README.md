# F1 Timer
Università degli Studi di Milano (A.S. 2018/2019, 2° semestre). Progetto per l'esame di Sistemi Embedded. 

## Descrizione
F1-Timer è un sistema di cronometraggio wireless in grado di misurare i tempi di percorrenza di piu' macchine su un circuito di gara. E' basato sul probing wifi da parte delle macchine verso un'antenna comune presente nel circuito. Questa antenna comune e' gestita da un server che si occupa di elaborare i dati ricevuti e di stendere una classifica real-time delle macchine in gara. Oltre ad elaborare i dati, il server si occupa di gestire altri servizi affini:
- visualizzazione real-time della classifica tramite una pagina web
- gestione del semaforo di partenza
- gestione delle spie di confronto tempi (attuali vs. precedenti)
- gestione del display per notificare il giro piu' veloce

## Hardware
- 2x NodeMCU-ESP32-S
- 1x Arduino Uno Rev3
- 8x LED
- 6x resistenza 220Ω
- 1x display LCD 16x2

> NB: Ho dedicato un'intera board Arduino Uno nella gestione del display per via di un apparente e irrisolta incompatibilita' tra il NodeMCU e il display LCD 16x2. Quando il server (NodeMCU) rileva il giro veloce, invia un messaggio seriale (tx->rx) contenente il nome del pilota e il suo tempo di percorrenza. 
