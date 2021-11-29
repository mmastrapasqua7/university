# Privacy degli utenti

Gli utenti del cloud vorrebbero rimanere anonimi e non rilasciare troppe informazioni

- Comunicazioni anonime (onion routing, tor, crowds, mix networks)
- Privacy nei servizi basati su geolocalizzazione
- Controllo d'accesso basato su attributi
- Preferenze privacy dell'utente

Gli utenti vogliono specificare, quando usano servizi esterni, la policy del rilascio di informazioni:
- **Sharing/Dissemination** dei propri dati
- **Digital Interactions** tipo salvataggio della carta di credito

## Protezione
- **Direct release**: Whom, When, What about release of user information
- **Secondary Usage**: further disseminatio (3rd parties)

### Direct release

Anche detto Attribute-Based AC, Credential-Based AC, Certificate-Based AC, Trust-Based AC...

**Attribute-based Access Control Mechanism**
- L'autorizzazione degli utenti dipende dall'asserzione di attributi che l'utente può provare, portando certificati
- Non ritorna risposa SI/NO, ma rappresentano dei requisiti di accesso che devono essere soddisfatti
- L'utente vuole privacy

Non solo il server deve essere protetto, ma anche l'utente vuole privacy, ma allora deve essere introdotto un meccanismo di **negoziazione**

- vecchio modello: ID -> AUTH -> ACL -> ENCRYPTION -> AUDIT
- nuovo modello: Mix

#### Interactive access control  

**Non ho negoziazione** in questo modello. C'è il desiderio della privacy dell'utente. In questo caso mi va stretto quando è sufficiente la policy. Attenzione: se la politica è sensibile, allora non devo rilevarla.

Assunzione: anche il client ha la sua politica di controllo di accesso, devide il client cosa comunicare al server.

Tutte le volte in cui l'utente è in gioco, si tiene in considerazione quello che dice, può fare un po' di opt-out, ma non può specificare tutta la policy a modo suo.
+ +espressive e potenti
+ +decide l'utente cosa rilasciare
+ -non permettono all'utente di esprimere che vorrebbe un'altra scelta

**Serve un modo per dare all'utente la possibilità di specificare preferenze sulla privacy rispetto al rilascio dei suoi dati**

### User privacy

Quello che non va bene con meccanismi classici di access control è che l'utente vuole mezzi per definire in modo efficace le sue preferenze:
- context based preferences: rilascio la carta di credito solo per fare pagamenti online, non per vedere se una camera d'albergo è libera
- forbidden disclosure: non voglio rilasciare sia nome reale che nickname, ovvero rilasciare informazioni per linkability, voglio mondi separati
- sensitive associations: possono agire da quasi identificatori, inoltre possono fare discriminazione, più dell'informazione richiesta
- limited disclosure: se devo dirti che sono maggiorenne, ti rilascio solo l'anno di nascita
- instance-based preference: rilascio dati sulla carta di credito se scade tra 1 anno
- history-based preference
- proof-based preference
- non-linkability preference

[[CostSensitiveTN]]
[[PointBasedTM]]
[[LogicalBasedMinCD]]
[[PrivacyPreferenceCBI]]