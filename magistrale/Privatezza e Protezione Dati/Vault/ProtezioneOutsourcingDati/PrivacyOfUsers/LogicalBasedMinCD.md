# Logic-based Minimal Credential Disclosure  

Quello che si avvicina di più al mondo reale e all'user empowerment. Ogni credenziale contiene un **singolo attributo**. Si fanno delle espressioni booleane AND e OR per esprimere le cose che richiedo. A ogni servizio si associa un espressione booleana che deve diventare VERO, true.

Ci mancano le specifiche di sensibilità, ovvero il valore soggettivo. In questa tecnica non dico quanto è sensibile il singolo e poi faccio la somma. Qui si ragiona in termini di preferenze dell'utente. Evito di dare cose che non servono.

Se 2 strategie differiscono per un solo bit, allora cerco di trovare quella che da meno, quella che da informazioni in più che sono inutili. Discorso di **dominanza** tra vettori. Una strategia $S_i$ domina una strategia $S_j$ se $S_i$ mostra qualità uguale o migliore a $S_j$ con rispetto di tutte le preferenze di credenziali ed è strettamente migliore.

$S_i$ domina se riesce a sostituire degli 1 nel vettore $S_j$ con degli 0

PRO:
- Prima c'era un concetto di costo associato alla credenziale e alla somma. Qui invece si tratta di preferenze. Si possono creare delle **gerarchie**. Esempio, preferisco l'identità al passaporto. Le preferenze dell'utente sono transitive per via delle gerarchie.
- l'utente è coinvolto nella scelta
- assume solamente attributi e non su credenziali
CONTRO:
- la specifica delle preferenze sui gruppi di attributi non è semplice