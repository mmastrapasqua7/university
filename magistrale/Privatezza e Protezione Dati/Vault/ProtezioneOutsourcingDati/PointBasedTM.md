# Point-based trust management

Non usi un singolo certificato ma più certificati. A ogni certificato associo dei punti. Sono punti che il server da ai certificati. Non è una stima del client ma il server che li associa. Il server poi chiede **una soglia minima di punti (minimal threshold)** da presentare per garantire il servizio

ATTENZIONE:
- il server associa dei punti a delle credenziali. Questi punti sono **fissati e privati**
- il client associa dei punti alle proprie credenziali. Questi punti sono **personali e privati**
- il client sceglie cosa usare per soddisfare la **soglia punti imposta dal server**

**goal: trovare un sottoinsieme di credenziali del client che soddisfano la soglia fissata dal server che ha il minimo valore di privacy PER IL CLIENT**

In questo modo il client valuta le possibili opzioni con un **private score** e quindi decide quali, tra quelle nel portfolio, dare.

CONTRO:
- supporta solo credenziali, no fine-grained
- il client e il server devono aderire sull'universo possibile di credenziali a disposizione
- programmazione dinamica