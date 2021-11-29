# Privacy Preference Credential-Based Interaction

Abilita gli utenti a regolare efficacemente la pubblicazione delle sue proprietà e credenziali
- identifica i requisiti e i concetti che devono essere catturati
- organizza le proprietà e le credenziali nel portfolio dell'utente
- abilita l'utente a specificare quanto valuta la pubblicazione di componenti diversi nel portfolio (sensibilità del rilascio)

## Client portfolio

Tutte le **informazioni** del client, si dividono in
- **Credential**: certificato erogato e firmato da una terza parte, certifica un set di proprietà, ha un tipo, identificatore, ed erogatore
	- **Atomiche**
		- rilasciate nella sua totalità
	- **Non-atomiche**
		- possono essere rilasciate singolarmente, e posso certificare il fatto che io le abbia
- **Declaration**
	- proprietà salvate come self-signed credential

Le **proprietà** si dividono in
- **Credential-independent**
	- I valori dipendono solo dal possessore della credenziale (DoB)
- **Credential-dependent**
	- I valori dipendono dal certificato (numero di carta di credito)

Un **Disclosure** è un sottoinsieme del portfolio del client che soddisfa
- **Certificabilità**: ogni proprietà è certificata da una credenziale
- **Atomicità**: se una proprietà di una credenziale atomica è rilasciata, allora tutte le proprietà devono essere rilasciate di quella credenziale atomica

## Portfolio sensitivity

### Proprietà e credenziali

- $\lambda(A)$: sensibilità della proprietà A presa individualmente
- $\lambda(c)$: sensibilità dell'esistenza della credenziale c

### Assocazioni

- $\lambda(A)$ è il costo di un associazione A definita come $A = {A_i, ..., A_j, c_k, ..., c_n}$ la quale divulgazione contemporanea (joint release) porta a
	- **più informazione** del rilascio di ogni singolo elemento A
		- **sensitive view**: rilascio di **più informazioni** di quanto ne rilascia l'informazione $A$ o la combinazione. Ovvero, se prendo singolarmente nome e cognome mi danno tot, ma se prendo nome e cognome tramite patente, so anche la tua età (+18) e che hai una patente
	- **meno informazione** del rilascio di ogni singolo elemento A
		- **dipendenza**: rilascio di **meno informazioni** di quanto ne rilascia la somma: se dico che abito a New York e vivo negli Stati Uniti, quest'ultima è un informazione inutile, mi dice di meno.

### Disclosure constraint

Insieme $A = {A_i, ..., A_j, c_k, ..., c_n}$ il quale rilascio **deve essere controllato**
- **forbidden view**: il rilascio ne è proibito (di A)
- **disclosure limitation**: al massimo $n$ elementi in A possono essere rilasciati

**Un disclosure è valido se nessun disclosure constraint è violato**

## Disclosure sensivity

La sensibilità $\lambda(D)$ di un disclosure $D$ è la **somma** dei sensitivity label delle
- proprietà rilasciate
- credenziali rilasciate
- associazioni rilasciate

## Server request

$\mathscr{R}$ è una richiesta, ovveri disgiunzione di **richieste semplice**

$R$ è una richiesta semplice, ovvero disgunzione di **termini**

un termine è la disclosure delle proprietà $A_1, ..., A_m$ da una credenziale c

esempio: una richiesta $\mathscr{R} = r_1 \land r_2$ è fatta da due richieste semplici. Queste richieste semplici richiedono che vengano pubblicati dei termini, ovvero delle proprietà di credenziali, tipo: $r_1 = id.\{Name, Address\}$, ovvero id è la credenziale, Name e Address sono le proprietà della credenziale id.

### Min-disclosure problem

Un disclosure $\mathscr{D}$
- soddisfa $\mathscr{R}$ se soddisfa almeno una richiesta semplice R in essa
- soddisfa una richiesta semplice R se per ogni termine in R, viene rilasciato un certificato che certifica le proprietà $A_1, ..., A_m$
- è **minimo** se non esiste nessun altro disclosure valido per cui il costo è minore

CONTRO:
è un problema NP-hard, si fa uso di Max-SAT resolver e rappresentazione graph-based.