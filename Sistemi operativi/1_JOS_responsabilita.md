# 1. accensione

1. power good signal -> timer chip

2. timer chip -> PIN RESET CPU

# 2. CPU jump

1. cs: 0xF000, ip: 0xFFF0, **real mode**
   
   il processore parte con questi due registri settati.
   
   gli indirizzi di memoria vengono calcolati come:
   
   $$
   addr = 16*cs + ip
   $$

2. jump 0xFFFF0

# 3. BIOS (0xFFFF0)

1. jump backward

2. se:
   
   1. **cold boot (hardware)**: avvia il POST
   
   2. **warm boot (riavvio sistema)**: salta il POST

3. carica a partire da 0x7C00 fino a 0x7DFF i primi 512 byte del disco (disco scelto dal CMOS). Carica in memoria il **boot loader**

4. cs: 0x0000, ip=0x7C00

5. jump 0x7C00

# 4. boot loader (0x7C00): boot/boot.S

predispone l'hardware per poter caricare in memoria centrale il kernel

1. **abilitazione A20: abilitazione 21esimo bit sul bus**

2. creazione GDT con all'interno i descrittori di segmenti

3. settare **PE_ON** nel registro CR0

4. **real mode -> protected mode** forzata con un jump in cui viene specificato il CS da usare e l'offset

5. call bootmain

# 5. IDE driver + kernel loader: boot/bootmain.c

1. legge 4KB dal disco IDE e li mette in memoria a partire dall'indirizzo 0x10000
2. 4KB letti vengono parsati come se fosse un binario di tipo ELF HEADER
3. vengono fatti i check sull'ELF HEADER
4. dall'ELF HEADER, si ricava l'indirizzo di partenza del PROGRAM HEADER e il numero di PROGRAM HEADER presenti (gia' caricati in memoria)
5. a 1 a 1 si leggono tutti gli indirizzi del PROGRAM HEADER e tramite ph->p_pa e si caricano in memoria ii rispettivi segmenti dall'indirizzo ph->p_pa trovandoli sul disco all'indirizzo ph->p_offset
6. si esegue un jump leggendo l'indirizzo entry dall'ELF HEADER
7. ELFHDR->e_entry()

# 6. kern/entry.S (0x1000c)

1. carica una page directory essenziale che mappa 4MB sia in KERNBASE sia in low memory

2. **protected mode -> paging**

3. viene usata una jump \*%eax per saltare a un indirizzo alto del kernel, quindi sopra KERNBASE. Dopo questa jump, gli indirizzi di esecuzione sono tutti ALTI

4. prepara 32KB di stack a partire da KERNBASE verso il basso

5. call i386_init()

# 7. kern/init.c

1. mem_init()

2. env_init()

3. trap_init()

# 8. kern/pmap.c (tramite mem_init())

1. mem_init()
   
   1. i386_detect_memory()
      
      1. inizializza variabili globali che dicono quante pagine libere di memoria ci sono (npages, npages_basemem)
   
   2. boot_alloc()
      
      1. alloca una pagina (4KB) di memoria prendendola dalla parte alta del kernel. Non e' da usare in via definitiva perche' non ha una corrispondenza con le pagine, da usare solo in fase di boot
   
   3. tramite boot_alloc() viene allocata una kern_pgdir, quindi page directory del kernel
   
   4. mappa all'interno della kernpgdir se stessa all'indirizzo UVPT verso PADDR(kern_pgdir), in sola lettura U/K
   
   5. tramite boot_alloc() viene allocato un array di pagine (PageInfo), con npages-elementi. 
   
   6. tramite boot_alloc() viene allocato un array di PCB, ovvero di environment (Eenv), contenente NENV-elementi
   
   7. page_init()
      
      1. viene inizializzato l'array di pagine (che poi e' una linked list), assegnando a ogni physical frame di memoria (da 4KB) la pagina corrispondente, segnandola come libera (ref=0) o occupata (ref=1 e non linkata)
   
   8. mappa all'interno della kern_pgdir l'indirizzo di PADDR(pages) all'indirizzo virtuale UPAGES in sola lettura U/K, e pages stessa in scrittura K
   
   9. stessa cosa con l'array di ENV: da UENVS a PADDR(envs)
   
   10. stessa cosa con lo KSTACK: da KSTACKTOP a PADDR(bootstack)
   
   11. stessa cosa con KERNBASE, a PADDR(KERNBASE)
   
   12. lcr3(PADDR(kern_pgdir))

# 9. kern/trap.c

1. trap_init()
   
   1. inizializza la IDT con i rispettivi handlers
   
   2. aggiunge poi alcune entry per trap user level
   
   3. trap_init_percpu()
      
      1. inserisce nella GDT il segment descriptor del Task State Segment, dove nel TSS c'e' esp0=KSTACKTOP e SS0=GD_KD;
      
      2. ltr(GDT_TSS0) inserisce l'index all'interno della GDT per trovare il TSS descriptor dal quale tirare fuori tutto l'occorrente
      
      3. lidt(idt_pd) inserisce il descriptor della IDT nel suo registro

# 10. kern/env.c

1. env_init()
   
   1. inizializza l'array di envs, ognuno free, linkati uno con l'altro (linked list)
   
   2. env_init_percpu()
      
      1. crea una nuova GDT con kernel data e text segment descriptor, user  data e text segment segment descriptor e il descriptor del task state segment (TSS) (inizializzato da trap)
      
      2. lgdt(gdt_pd)
      
      3. lldt(0) perche' la LDT e' inutilizzata in JOS
