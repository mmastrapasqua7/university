# Selective encryption

L'accesso a una risorsa è tradotto nel possesso di una chiave. In questo modo i dati sono l'access control stesso. A ogni utente è comunicata la chiave di accesso che ha bisogno per cifrare quello per cui è autorizzato

Passi:
1. definisco un **Authorization Policy** $\mathscr{A}$ come un insieme di tuple (utente, risorsa). Posso rappresentarla come una **matrice di accesso** o un **grafo diretto bipartito**. Problema: per ogni risorsa mi servirebbero chiavi diverse in base
2. traduco l'authorization policy in **Encryption Policy**
	- usare una chiave per ogni risorsa non è l'ideale, l'utente ha bisogno di x chiavi
	- uso un meccanismo di **key derivation** per permettere agli utenti di derivare le chiavi che gli servono per accedere alle risorse per cui sono autorizzati. In questo modo ogni utente ha bisogno di 1 chiave

## Key derivation methods

Basato su gerarchia di derivazione chiavi. La conoscenza di una chiave $v_1$ mi permette di derivare tutte le chiavi sotto la sua gerarchia, tipo $v_2$

### Token-based

- A ogni vertice assegno una chiave $k_i$ e gli associo un label pubblico $l_i$
- Creo dei token $t_{i,j}$ per ogni arco, computato come $t_{i, j} = k_j \oplus h(k_i, l_j)$ dove $h$ è una funzione hash

La relazione può essere rappresentata da un **grafo chiavi e token** dove:
- ogni vertice è una tupla $(k, l)$
- ogni arco da un vertice $(k_i, l_i)$ a $(k_j, l_j)$ esiste se c'è un token $t_{i,j}$ che permette di derivare $k_j$ da $k_i$

PRO:
- ogni utente ha una chiave
- ogni risorsa è cifrata una sola volta con una singola chiave

## Traduzione AuthPolicy a EncPolicy

Naive: (fa schifo)
- ogni utente è associato a una chiave diversa
- ogni risorsa è cifrata con una chiave diversa
- genero un token per ogni permesso (u, r)

Exploit dell'acl e dei gruppi utenti:
- raggruppo utenti con lo stesso privilegio di accesso
- cifro la risorsa con una chiave associata a un set di utenti che può accedervi

Posso anche sfruttare le gerarchie, ma attenzione
- se il sistema ha un elevato numero di utenti, l'encryption policy può arrivare a $2^{|U|}-1$, quindi esponenziale

## Minimum encryption policy

**Osservazione**: gli utenti che non sono in nessuna acl non hanno bisogno di chiavi

**Goal**: computare la minima policy di cifratura che minimizza il numero di token che il server deve tenere

**Soluzione**: euristica
- solo gruppi di utenti associati a un acl hanno bisogno di una chiave
- creo vertici solo quando mi servono

### Algorithm

Partendo dalla Authorization Policy
- crea un vertice-chiave per ogni utente e per ogni ACL non singleton (**inizialization**)
- per ogni vertice $v$ corrispondente a una ACL non singleton, trova una copertura senza ridodndanza (**covering**)
	- per ogni utente $u$ in $v$, trova un antenato $v'$ di $v$ con $u \in v'$ 
- fattorizza gli antenati comuni

## Più proprietari e cambio di policy

Problema: se le autorizzazioni cambiano è un casino, devo riscaricare tutto, decifrare, ricifrare e rifare l'upload, bel casino. Soluzione: **OverEncryption**

### OverEncryption

Le risorse le cifro 2 volte:
- **Base Encryption Layer**: cifro le risorse con una chiave che conoscono solo gli utenti, ma non il server
- **Surface Encryption Layer**: il server cifra le risorse con una chiave condivisa con gli utenti

Un utente ha bisogno delle chiavi BEL e SEL per accedere. In questo modo, un **grant** e un **revoke** ha bisogno solo di:
- aggiungere un nuovo token a livello BEL
- aggiornare a livello SEL

#### BEL

Abbiamo una
- **chiave di derivazione $k$**
- **chiave di accesso $k_a$** derivata in questo modo: $k_a = h(k)$

Ogni nodo ha associato una tupla $(k, k_a)$ e dei label $(l, l_a)$
- $k$ e $l$ sono usate per derivare
- $k_a$ e $l_a$ sono usate per cifrare la risorsa associata al nodo

#### SEL

Encryption policy come fatta precedentemente

### Approcci OverEncryption

#### Full_SEL

si parte da SEL=BEL e aggiorno SEL in base alla policy corrente

#### Delta_SEL

si parte da SEL vuota e aggiungo elementi in base all'evoluzione, in questo modo la coppia BEL-SEL è la policy

### Algoritmo per l'evoluzione di SEL e BEL

- **over-encryption**: regola l'aggiornamento facendo over-encrypt della risorsa a livello SEL
- **grant & revoke**: serve per fare grant e revoke dei privilegi

#### Procedura di over-encrypt (SEL)

Mi arrivano richieste **over-encrypt(U, R)** per garantire l'accesso degli utenti U alle risorse R
1. per ogni risorsa R, se è over-encrypted, la decifro
2. se U = ALL, fermati
3. se esiste una chiave $s$ derivabile solo dagli utenti in U. Se non esiste, la creo e la aggiungo a SEL
4. cifro ogni risorsa in R con la chiave $s$ e faccio l'aggiornamento $\phi_s(r)$

#### Procedura di grant (BEL)

su richiesta di fare grant dell'utente $u$ per la risorsa $r$ al momento cifrata con la chiave $b_j$
1. aggiungo $u$ ad $acl(r)$
2. se $u$ non può derivare $b_j$, aggiungo un token dalla chiave di $u$ a $b_j$ nel grafo di BEL
3. se c'è un insieme di risorse R' cifrate con $b_j$ che non deve essere accessibile a $u$
	1. partiziono R' in set in accordo con l'$acl$
	2. per ogni set S, richiedo **over-encrypt($acl_s$, S)** a SEL
4. rendo $r$ accessibile da $u$ a livello SEL
	- In caso di Delta_SEL: se il set di utenti che può derivare $b_j$ è in $acl$, chiamo **over-encrypt($ALL, {r}$)**, altrimenti chiamo **over-encrypt($acl(r), {r}$)**
	- In caso di Full_SEL: chiamo **over-encrypt($acl(r), {r}$)**

#### Procedura di revoke (BEL)

su richiesta di fare revoke dell'utente $u$ della risorsa $r$
1. rimuovo $u$ da $acl(r)$
2. richiedo **over-encrypt($acl(r), {r}$)** a SEL per rendere $r$ accessibile solo ad $acl(r)$

### Protezione

#### Collusion attacks

Se 2 entità combinano la loro conoscienza per avere accesso a qualcosa per cui entrambi non hanno accesso
- tra utenti
- col server

I problemi dipendono dalla vista che un utente ha rispetto alla risorsa $r$

##### Vista su $r$

- **Open**: chiave SEL e BEL conosciute
- **Locked**: chiave SEL e BEL sconosciute
- **SEL_Locked**: chiave BEL conosciuta, chiave SEL sconosciuta
- **BEL_Locked**: chiave SEL conosciuta, chiave BEL sconosciuta

**Il server ha sempre la vista BEL_Locked**

##### Classificazione utenti

Considero la risorsa $r$ e la storia della sua $acl(r)$. Nella ACL possono essere categorizzati in
- $acl(r)$
- Past_acl
- BEL_Accessibile
- All

**Rischio di collusione su $r$** se e solo se ci sono utenti in BEL_Accessibile che non appartengono a Past_acl

##### Vista su $r$ in Full_SEL

Un utente può avere una SEL_Locked view su $r$ se
- Past_acl
- policy split: $u$ è autorizzato all'accesso di $r'$ e non di $r$, cifrato a livello BEL con **la stessa chiave** di $r$

##### Collusion attacks nel Full_SEL

- **tra utenti**
	- non è un problema, l'utente non guadagna nulla nello scambio
- **con il server**
	- gli utenti in BEL_Accessible che hanno la vista SEL_Locked e che non hanno mai avuto l'autorizzazione di accesso sulla risorsa
	- l'esposizione è **limitata alla risorsa in gioco nella policy split** per permettere all'utente di accedere ad altre risorse, cifrate con la stessa chiave di BEL
		- facilmente identificabile, può essere aggirata ricifrando

##### Vista su $r$ in Delta_SEL

La vista dell'utente $u'$ su $r$ può evolvere dallo stato BEL_Locked se
- policy split: policy split: $u$ è autorizzato all'accesso di $r'$ e non di $r$, cifrato a livello BEL con **la stessa chiave** di $r$

##### Collusion attacks nel Delta_SEL

L'utente può essere solamente **SEL_Locked** o **BEL_Locked**

- un utente può prelevare la risorsa al tempo iniziale quano non ha accesso, salvando la vista BEL_Locked
	- se acquisisce la vista SEL_Locked sulla risorsa $r$, può aprire la vista su $r$
- l'esposizione è **limitata alla risorsa in gioco nella policy split** per permettere all'utente di accedere ad altre risorse, cifrate con la stessa chiave di BEL
	- facilmente identificabile, può essere aggirata ricifrando