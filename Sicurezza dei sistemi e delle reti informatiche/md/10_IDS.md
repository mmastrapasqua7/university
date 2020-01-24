# Intrusion Detection System (IDS)
Ha come scopo monitorare il traffico di rete per evidenziare e riportare eventi critici per la sicurezza. E' un estensione del normale sistema di log. Identifica individui che usano rete o computer in modo non autorizzato. **Non protegge, ma rileva**.

**OBIETTIVO**
- rilevare attacchi e violazioni
- fornire informazioni su intrusioni avvenute
- diagnosi al fine di correggere debolezze
- eventuali risposte automatiche

**MODALITA**
- **ACTIVE**
	- **learning** analisi statistica del funzionamento del sistema
	- **monitoring** analisi traffico dati, sequenze, azioni
	- **reaction** confronto coi parametri statistici
- **PASSIVE**
uso di checksum crittografici, riconoscimento di pattern (aka **attack signature**)

**COSA SERVE**
- **network scan**
- **traffico sospetto**
- **host sospetti**
- **host compromessi nella LAN**

**COSA NON SERVE**
- **prevenzione intrusioni**
- **prevenzione DoS**
- **attacchi dall'interno della LAN**

**VALUTAZIONE PRESTAZIONI**
- **accuratezza**: allarmi_corretti / allarmi_totali
- **completezza**: allarmi_corretti / numero_intrusioni_totali

Per usufruire dei benefici di un IDS occorre bilanciare il numero di falsi negativi (FN, ovvero attacchi non rilevati) e di falsi positivi (FP, attacco inesistente, corrisponde a un attivita' normale della rete). Il problema e' che tendenzialmente FP e FN sono inversamente correlati: se si cerca di diminuire uno aumenta l'altro.

TIPOLIGIE:
## Host-based IDS (HIDS)
analisi dei log di sistema o log delle applicazioni. E' un ottimo strumento di monitoraggio all'interno del SO.

## Network-based IDS (NIDS)
attivazione di strumenti di monitoraggio del traffico
**COMPONENTI**
- **Sensors** controlla traffico e log, individua pattern sospetti, attiva security event e interagisce col sistema con ACL, TCP RST
- **Director** coordina il lavoro dei sensors e gestisce il security database
- **IDS Message System** consente la comunicazione sicura e affidabile tra i componenti IDS

## System Integrity Verifier
controlla file e filesystem, in modo da rilevarne i cambiamenti, come file di configurazione, privilegi utente etc. Esempio software linux: **tripwire**

## Log File Monitor
controlla file di log del SO e delle applicazioni. Rileva pattern conosciuti derivanti da attacchi. Esempio software linux: **swatch**

## Intrusion Prevention System
e' composto da un IDS + Dynamic Firewall distrubuito. Non e' un singolo prodotto ma un aggregato di tecnologia. E' anche pericoloso perche' prendendo la decisione sbagliata si blocca il traffico innocuo.

## HONEY POT





















