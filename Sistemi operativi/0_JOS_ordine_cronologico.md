# JOS: Ordine cronologico del boot

## (1) ```0xffff0```: BIOS

## (2) ```0x7c00```: boot/boot.S

```nasm
gdt:
  SEG_NULL
  SEG(STA_X | STA_R, 0x00000000, 0xFFFFFFFF) ; code segment descriptor
  SEG(STA_W, 0x00000000, 0xFFFFFFFF)         ; data segment descriptor
gdtdesc:
  .word   0x17 # sizeof(gdt) - 1
  .long   gdt  # address gdt

.set PROT_MODE_CSEG, 0x8  ; kernel code segment selector (1)
.set PROT_MODE_DSEG, 0x10 ; kernel data segment selector (2)
.set CR0_PE_ON,      0x1  ; protected mode enable flag

start:
.code16                     ; Assemble for 16-bit mode
  cli                       ; Disable interrupts
  cld                       ; String operations increment

  xorw    %ax, %ax          ; NULL segment selector
  movw    %ax, %ds          ; Data segment selector -> SEG NULL
  movw    %ax, %es          ; Extra segment selector -> SEG NULL
  movw    %ax, %ss          ; Stack segment selector -> SEG NULL

seta20.1:
  inb     $0x64, %al        ; Wait for not busy
  testb   $0x2, %al
  jnz     seta20.1

  movb    $0xd1, %al        ; 0xd1 -> port 0x64
  outb    %al, $0x64

seta20.2:
  inb     $0x64, %al        ; Wait for not busy
  testb   $0x2, %al
  jnz     seta20.2

  movb    $0xdf, %al        ; 0xdf -> port 0x60
  outb    %al, $0x60

  lgdt    gdtdesc           ; gdtr <- gdtdescriptor
  movl    %cr0, %eax
  orl     $CR0_PE_ON, %eax
  movl    %eax, %cr0        ; cr0 <- protection enabled
  ljmp    $PROT_MODE_CSEG, $protcseg ; Code segment selector -> cs
    ; Switches CPU into 32-bit mode.

protcseg:
.code32
  movw    $PROT_MODE_DSEG, %ax    ; Data segment selector
  movw    %ax, %ds                ; Data segment selector -> ds
  movw    %ax, %es                ;
  movw    %ax, %fs                ;
  movw    %ax, %gs                ;
  movw    %ax, %ss                ; Stack segment selector -> ss

  movl    $start, %esp ; %start = 0x7c00
  call    bootmain
```

## (3) cont'd: boot/main.c

```c
#define SECTSIZE    512
#define ELFHDR        ((struct Elf *) 0x10000) // scratch space

void bootmain() {
  struct Proghdr *ph, *eph;

  // read 1st page off disk
  readseg((uint32_t) ELFHDR, SECTSIZE*8, 0); // read 4KB from disk

  // is this a valid ELF?
  if (ELFHDR->e_magic != ELF_MAGIC) {
    goto bad;
  }

  // load each program segment (ignores ph flags)
  ph = (struct Proghdr *) ((uint8_t *) ELFHDR + ELFHDR->e_phoff);
  eph = ph + ELFHDR->e_phnum;
  for (; ph < eph; ph++) {
    // p_pa is the load address of this segment (as well
    // as the physical address)
    readseg(ph->p_pa, ph->p_memsz, ph->p_offset);
  }

  ((void (*)(void)) (ELFHDR->e_entry))();
}

// Read 'count' bytes at 'offset' from kernel into physical address 'pa'.
// Might copy more than asked
void readseg(uint32_t pa, uint32_t count, uint32_t offset) {
  uint32_t end_pa;

  end_pa = pa + count;

  // round down to sector boundary
  pa &= ~(SECTSIZE - 1);

  // translate from bytes to sectors, and kernel starts at sector 1
  offset = (offset / SECTSIZE) + 1;

  // If this is too slow, we could read lots of sectors at a time.
  // We'd write more to memory than asked, but it doesn't matter --
  // we load in increasing order.
  while (pa < end_pa) {
    // Since we haven't enabled paging yet and we're using
    // an identity segment mapping (see boot.S), we can
    // use physical addresses directly.  This won't be the
    // case once JOS enables the MMU.
    readsect((uint8_t*) pa, offset);
    pa += SECTSIZE;
    offset++;
  }
}

void waitdisk(void) {
  // wait for disk reaady
  while ((inb(0x1F7) & 0xC0) != 0x40) {
    /* do nothing */
    ;
  }
}

void readsect(void *dst, uint32_t offset) {
  // wait for disk to be ready
  waitdisk();

  outb(0x1F2, 1);        // count = 1
  outb(0x1F3, offset);
  outb(0x1F4, offset >> 8);
  outb(0x1F5, offset >> 16);
  outb(0x1F6, (offset >> 24) | 0xE0);
  outb(0x1F7, 0x20);    // cmd 0x20 - read sectors

  // wait for disk to be ready
  waitdisk();

  // read a sector
  insl(0x1F0, dst, SECTSIZE/4);
}
```

## (4) ```0x10000c```: kern/entry.S

```nasm
.data
  .p2align PGSHIFT ; PGSHIFT = 12 (log2(PGSIZE)) where PGSIZE = 4KB
  .globl bootstack
bootstack:
  .space KSTKSIZE ; KSTKSIZE = 8 * PGSIZE = 8 * 4KB = 32KB stack
  .globl bootstacktop
bootstacktop:

.globl _start
_start = RELOC(entry)

.globl entry
entry:
  movl   $(RELOC(entry_pgdir)), %eax ; reloc entry_pgdir to lower address too
  movl   %eax, %cr3

  movl   %cr0, %eax
  orl    $(CR0_PE|CR0_PG|CR0_WP), %eax
  movl   %eax, %cr0

  mov    $relocated, %eax ; still low address
  jmp    *%eax            ; still low address

relocated:                ; high address (above KERNBASE)
  ...
  movl    $(bootstacktop), %esp
  call    i386_init
```

## (4.1) cont'd: kern/entrypgdir.c

```c
// NPDENTRIES = 1024 (page directory/table entries per page directory/table)
pde_t entry_pgdir[NPDENTRIES] = {
  // map VA [0, 4MB) to PA [0, 4MB)
  [0] = ((uintptr_t) entry_pgtable - KERNBASE) + PTE_P,

  // Map VA [KERNBASE, KERNBASE  +4MB) to PA [0, 4MB)
  [KERNBASE >> PDXSHIFT] = ((uintptr_t)entry_pgtable - KERNBASE) + PTE_P + PTE_W
  // where KERNBASE = 0xF0000000
  // where PDXSHIFT = 22
  // [960] = [0x3c0]
};

pte_t entry_pgtable[NPTENTRIES] = {
  0x000000 | PTE_P | PTE_W,
  0x001000 | PTE_P | PTE_W,
  ...
  0x3fe000 | PTE_P | PTE_W,
  0x3ff000 | PTE_P | PTE_W,
};
```

## (5) cont'd: kern/init.c

```c
void i386_init(void) {
  mem_init();

  env_init();  

  trap_init();
}
```

## (5.1) cont'd: kern/pmap.c

```c
struct PageInfo {
  struct PageInfo *pp_link;
  uint16_t pp_ref;
};

void mem_init(void) {
  i386_detect_memory();

  kern_pgdir = (pde_t *) boot_alloc(PGSIZE);
  memset(kern_pgdir, 0, PGSIZE);

  // where npages is the number of free pages (free memory)
  pages = (struct PageInfo *) boot_alloc(npages * sizeof(struct PageInfo));
  memset(pages, 0, npages * sizeof(struct PageInfo));

  envs = (struct Env *)boot_alloc(NENV * sizeof(struct Env));
  memset(envs, 0, NENV * sizeof(struct Env));

  page_init();

  boot_map_region(
    kern_pgdir, // page directory
    KERNBASE,   // virtual address 0xF0000000
    ROUNDUP((0xFFFFFFFF) - KERNBASE + 1, PGSIZE), // size
    0x00000000, // physical address
    PTE_W | PTE_P); // permissions

  boot_map_region(
    kern_pgdir, // page directory
    UPAGES,     // virtual address 0xEF000000
    ROUNDUP(sizeof(struct PageInfo) * npages, PGSIZE),
    PADDR(pages),
    PTE_U);

  boot_map_region(
    kern_pgdir,
    UENVS,      // virtual address 0xEEC00000
    ROUNDUP(sizeof(struct Env) * NENV, PGSIZE),
    PADDR(envs),
    PTE_U);

  boot_map_region(
    kern_pgdir,
    KSTACKTOP - KSTKSIZE, // where KSTACKTOP = 0xEFC00000,
    KSTKSIZE,             // where KSTKSIZE = 8 * PGSIZE = 8 * 4KB = 32KB
    PADDR(bootstack),
    PTE_W);

  lcr3(PADDR(kern_pgdir));

  check_page_free_list(0); // reverse page_free_list order

  // CR0_PE = protection enabled
  // CR0_PG = paging enabled
  // CR0_AM = alignment mask
  // CR0_WP = write protect
  // CR0_NE = numeric error
  // CR0_MP = monitor coprocessor
  // CR0_TS = task switched
  // CR0_EM = emulation
  cr0 = rcr0();
  cr0 |= CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_MP;
  cr0 &= ~(CR0_TS | CR0_EM);
  lcr0(cr0);
}

static void *boot_alloc(uint32_t n) { // number of bytes to alloc  static char *nextfree; // virtual address of next byte of free memory
  if (!nextfree) {
    // 'end' is a magic symbol automatically generated by the linker,
    // which points to the end of the kernel's bss segment:
    // the first virtual address that the linker did not assign
    // to any kernel code or global variables.
    extern char end[];
    nextfree = ROUNDUP((char *) end, PGSIZE);
  }

  char *result = nextfree;
  if (n > 0) { // i want to alloc memory
    uint32_t alloc_size = ROUNDUP(n, PGSIZE);
    nextfree += alloc_size

    if ((uintptr_t) nextfree >= 0xf0400000) {
      panic("boot_alloc: out of memory");
    }
  } // else just return nextfree

  return result;
}

void page_init(void) {
  for (size_t i = 0; i < npages; i++) {
    physaddr_t pa = page2pa(&pages[i]);
    char *va = page2kva(&pages[i]);

    // at IOPHYSMEM (640K = 0xA0000) there is a 384K hole for I/O (LOW MEM)
    if (i == 0
        || (IOPHYSMEM <= pa && va < (char *)boot_alloc(0))
        || (MPENTRY_PADDR <= pa && pa < MPENTRY_PADDR + PGSIZE)) {
      pages[i].pp_ref = 1;
      pages[i].pp_link = NULL;
      // used pages, both mapped and already in use
    } else {
      pages[i].pp_ref = 0;
      pages[i].pp_link = page_free_list;
      page_free_list = &pages[i];
      // free pages
    }
  }
}

struct PageInfo *page_alloc(int alloc_flags) {
  // alloc
  if (page_free_list == NULL) {
    return NULL;
  }
  struct PageInfo *allocated_page = page_free_list;

  // clean
  if (alloc_flags & ALLOC_ZERO) {
    memset(page2kva(page_free_list), 0, PGSIZE);
  }

  // update local structures and return
  page_free_list = page_free_list->pp_link;
  allocated_page->pp_link = NULL;
  return allocated_page;
}

void page_free(struct PageInfo *pp) {
  if (pp->pp_ref == 0) {
    memset(page2kva(pp), 0, PGSIZE);
    pp->pp_link = page_free_list;
    page_free_list = pp;
  }
}

void page_decref(struct PageInfo* pp) {
  pp->pp_ref -= 1;
  if (pp->pp_ref == 0) {
    page_free(pp);
  }
}

struct PageInfo *page_lookup(pde_t *pgdir, void *va, pte_t **pte_store) {
  pte_t *pte = pgdir_walk(pgdir, va, 0);
  if (!pte || !(*pte & PTE_P)) { // if pte doesn't exist or is not present
    return NULL;   
  }

  if (pte_store) { // save pte
    *pte_store = pte;
  }

  return pa2page(PTE_ADDR(*pte));
}

int page_insert(pde_t *pgdir, struct PageInfo *pp, void *va, int perm) {
  pte_t *pte = pgdir_walk(pgdir, va, 1);
  if (pte == NULL) {
    return -E_NO_MEM;
  }

  perm &= 0xFFF;
  if (*pte & PTE_P) {
    if (PTE_ADDR(*pte) != page2pa(pp)) { // present but different mapping
      page_remove(pgdir, va); // remove old mapping
      *pte = page2pa(pp) | perm | PTE_P;
      pp->pp_ref += 1;
      tlb_invalidate(pgdir, va);
    } else { // present but same mapping, just change the permission
      *pte = PTE_ADDR(*pte) | perm | PTE_P;
    }
  } else { // not present at all, add it
    *pte = page2pa(pp) | perm | PTE_P;
    pp->pp_ref += 1;
  }

  return 0;
}

void page_remove(pde_t *pgdir, void *va) {
  pte_t *pt_element;  
  struct PageInfo *page_to_remove = page_lookup(pgdir, va, &ptelement);
  if (page_to_remove == NULL) {
    return;
  }

  *ptelement = 0;
  page_decref(page_to_remove);
  tlb_invalidate(pgdir, va);
  return;
}

pte_t *pgdir_walk(pde_t *pgdir, const void *va, int create) {
  struct PageInfo *new_page;
  if ((pgdir[PDX(va)] & PTE_P) != 0) { // if present return its address
    return &(((pte_t *)KADDR(PTE_ADDR(pgdir[PDX(va)])))[PTX(va)]);
  } else {
    if (create == 0) {
      return NULL;
    } else { // else create a new one and return its address
      new_page = page_alloc(ALLOC_ZERO);
      if (new_page == NULL) {
        return NULL;
      }
      new_page->pp_ref = 1;

      pgdir[PDX(va)] = page2pa(new_page) | PTE_P | PTE_W | PTE_U;
      return &(((pte_t *)KADDR(PTE_ADDR(pgdir[PDX(va)])))[PTX(va)]);
    }
  }
}

static void boot_map_region(pde_t *pgdir, uintptr_t va, size_t size, physaddr_t pa, int perm) {
  for (size_t i = 0; i < size; i += PGSIZE) {
    pte_t *pte = pgdir_walk(pgdir, (void *)(va + i), 1);
    *pte = (pa + i) | perm | PTE_P;
  }
}

// where PGSHIFT = 12
physaddr_t page2pa(struct PageInfo *pp) {
  return (pp - pages) << PGSHIFT;
}

void* page2kva(struct PageInfo *pp) {
  return KADDR(page2pa(pp));
}
```

## (6) kern/trap.c

```c
struct Segdesc gdt[NCPU + 5] = {
  // 0x0 - unused (always faults -- for trapping NULL far pointers)
  SEG_NULL,

  // 0x8 - kernel code segment
  [GD_KT >> 3] = SEG(STA_X | STA_R, 0x0, 0xffffffff, 0),

  // 0x10 - kernel data segment
  [GD_KD >> 3] = SEG(STA_W, 0x0, 0xffffffff, 0),

  // 0x18 - user code segment
  [GD_UT >> 3] = SEG(STA_X | STA_R, 0x0, 0xffffffff, 3),

  // 0x20 - user data segment
  [GD_UD >> 3] = SEG(STA_W, 0x0, 0xffffffff, 3),

  // Per-CPU TSS descriptors (starting from GD_TSS0) are initialized
  // in trap_init_percpu()
  [GD_TSS0 >> 3] = SEG_NULL
};

struct Gatedesc idt[256] = {
  { 0 },
};

struct Pseudodesc idt_pd = {
  sizeof(idt) - 1,
  (uint32_t) idt
};

void trap_init(void) {
  extern void handler0();
  extern void handler0();
  ...
  extern void handler13();
  extern void handler14();

  extern void irq0_entry();
  extern void irq1_entry();
  ...
  extern void irq13_entry();
  extern void irq14_entry();

  // where SETGATE(gate, istrap, selector, offset, dpl)
  SETGATE(idt[T_DIVIDE], 0, GD_KT, handler0, 0);
  SETGATE(idt[T_DEBUG], 0, GD_KT, handler1, 0);
  ...
  SETGATE(idt[T_PGFLT], 0, GD_KT, handler14, 0);
  SETGATE(idt[T_FPERR], 0, GD_KT, handler16, 0);

  trap_init_percpu();
}

void trap_init_percpu() {
  ts.ts_esp0 = KSTACKTOP;
  ts.ts_ss0 = GD_KD;

  // Initialize the TSS slot of the gdt.
  gdt[GD_TSS0 >> 3] = SEG16(STS_T32A, (uint32_t) (&ts), sizeof(struct Taskstate), 0);
  gdt[GD_TSS0 >> 3].sd_s = 0;

  // Load the TSS selector (like other segment selectors, the
  // bottom three bits are special; we leave them 0)
  ltr(GD_TSS0);

  // Load the IDT
  lidt(&idt_pd);
}

void trap(struct Trapframe *tf) {
  // where 0x11 = USER MODE
  if ((tf->tf_cs & 0x11) == 0x11) {
    // if trapped from user mode
    assert(curenv);
    curenv->env_tf = *tf; // copy by value, data still on the stack
    tf = &(curenv->env_tf);
  }

  trap_dispatch(tf);

  // if we arrive there, than no other environment was scheduled
  if (curenv != NULL && curenv->env_status == ENV_RUNNING) {
    env_run(curenv);
  } else {
    sched_yield();  
  }
}

static void trap_dispatch(struct Trapframe *tf) {
  if (tf->tf_trapno == IRQ_OFFSET + IRQ_TIMER) { // if CLOCK INTERRUPT
    lapic_eoi();   // INTERRUPT ACKNOWLEDGE
    sched_yield(); // CALL THE SCHEDULER
    return;
  }

  if (tf->tf_cs == GD_KT) {
    panic("unhandled trap in kernel");
  }

  switch (tf->tf_trapno) {
    case T_PGFLT:
      page_fault_handler(tf);
      break;
    case T_BRKPT:
      monitor(tf);
      break;
    case T_SYSCALL:
      tf->tf_regs.reg_eax = syscall( // call syscall in kern/syscall.c
        tf->tf_regs.reg_eax, // syscall number
        tf->tf_regs.reg_edx,
        tf->tf_regs.reg_ecx,
        tf->tf_regs.reg_ebx,
        tf->tf_regs.reg_edi,
        tf->tf_regs.reg_esi);
      return;
    default:
      env_destroy(curenv);
      return;
  }
}
```

## inc/mmu.h

```c
#define SETGATE(gate, istrap, sel, off, dpl) {
  (gate).gd_off_15_0 = (uint32_t) (off) & 0xffff;
  (gate).gd_sel = (sel);
  (gate).gd_args = 0;
  (gate).gd_rsv1 = 0;
  (gate).gd_type = (istrap) ? STS_TG32 : STS_IG32;
  (gate).gd_s = 0;
  (gate).gd_dpl = (dpl);
  (gate).gd_p = 1;
  (gate).gd_off_31_16 = (uint32_t) (off) >> 16;
}

// Task state segment format (as described by the Pentium architecture book)
struct Taskstate {
  ...
  uintptr_t ts_esp0;   // Stack pointers and segment selectors
  uint16_t ts_ss0;     // after an increase in privilege level
  ...
};

struct Trapframe {
  struct PushRegs tf_regs;
  uint16_t tf_es;
  uint16_t tf_ds;
  uint32_t tf_trapno;

  /* below here defined by x86 hardware */
  uint32_t tf_err;
  uintptr_t tf_eip;
  uint16_t tf_cs;
  uint32_t tf_eflags;

  uintptr_t tf_esp; // only when crossing rings, such as
  uint16_t tf_ss;   // from user to kernel
}
```

## kern/trapentry.S

```nasm
/* TRAPHANDLER defines a globally-visible function for handling a trap.
 * It pushes a trap number onto the stack, then jumps to _alltraps.
 * Use TRAPHANDLER for traps where the CPU automatically pushes an error
 * code.
 */

#define TRAPHANDLER(name, num)
  .globl name
  .type name, @function
  .align 2
  name:
    pushl $(num)
    jmp _alltraps

/* Use TRAPHANDLER_NOEC for traps where the CPU doesn't push an error
 * code. It pushes a 0 in place of the error code, so the trap frame
 * has the same format in either case.
 */

#define TRAPHANDLER_NOEC(name, num)
    .globl name
    .type name, @function
    .align 2
    name:
      pushl $0
      pushl $(num)
      jmp _alltraps

.text

TRAPHANDLER_NOEC(handler0, T_DIVIDE);
TRAPHANDLER_NOEC(handler1, T_DEBUG);
..
TRAPHANDLER(handler13, T_GPFLT);
TRAPHANDLER(handler14, T_PGFLT);
TRAPHANDLER_NOEC(handler16, T_FPERR);
TRAPHANDLER_NOEC(irq0_entry, IRQ_OFFSET + 0);
TRAPHANDLER_NOEC(irq1_entry, IRQ_OFFSET + 1);
...
TRAPHANDLER_NOEC(irq13_entry, IRQ_OFFSET + 13);
TRAPHANDLER_NOEC(irq14_entry, IRQ_OFFSET + 14);

_alltraps:
  push %ds
  push %es
  pusha ; push ax, bx, cx...

  mov $GD_KD, %ax
  mov %ax, %ds
  mov %ax, %es

  pushl %esp ; Trapframe *tf, is the pointer to a struct of Trapframe
  call trap  ; needed by the trap() function

.data
.globl handlers
handlers:
  .long handler0
  .long handler1
  ...
  .long handler254
  .long handler255
```

## (7) kern/env.c

```c
// Global descriptor table.
//
// Set up global descriptor table (GDT) with separate segments for
// kernel mode and user mode.  Segments serve many purposes on the x86.
// We don't use any of their memory-mapping capabilities, but we need
// them to switch privilege levels.
//
// The kernel and user segments are identical except for the DPL.
// To load the SS register, the CPL must equal the DPL.  Thus,
// we must duplicate the segments for the user and the kernel.
//
// In particular, the last argument to the SEG macro used in the
// definition of gdt specifies the Descriptor Privilege Level (DPL)
// of that descriptor: 0 for kernel and 3 for user.
//
struct Segdesc gdt[NCPU + 5] = {
  // 0x0 - unused (always faults -- for trapping NULL far pointers)
  SEG_NULL,

  // 0x8 - kernel code segment
  [GD_KT >> 3] = SEG(STA_X | STA_R, 0x0, 0xffffffff, 0),

  // 0x10 - kernel data segment
  [GD_KD >> 3] = SEG(STA_W, 0x0, 0xffffffff, 0),

  // 0x18 - user code segment
  [GD_UT >> 3] = SEG(STA_X | STA_R, 0x0, 0xffffffff, 3),

  // 0x20 - user data segment
  [GD_UD >> 3] = SEG(STA_W, 0x0, 0xffffffff, 3),

  // Per-CPU TSS descriptors (starting from GD_TSS0) are initialized
  // in trap_init_percpu()
  [GD_TSS0 >> 3] = SEG_NULL
};

struct Pseudodesc gdt_pd = {
    sizeof(gdt) - 1, (unsigned long) gdt
};

enum {
  ENV_FREE = 0,
  ENV_DYING,
  ENV_RUNNABLE,
  ENV_RUNNING,
  ENV_NOT_RUNNABLE
};

struct Env {
  struct Trapframe env_tf;    // Saved registers
  struct Env *env_link;        // Next free Env
  envid_t env_id;            // Unique environment identifier
  envid_t env_parent_id;    // env_id of this env's parent
  enum EnvType env_type;    // Indicates special system environments
  unsigned env_status;        // Status of the environment
  uint32_t env_runs;        // Number of times environment has run
  int env_cpunum;            // The CPU that the env is running on

  // Address space
  pde_t *env_pgdir;            // Kernel virtual address of page dir

  // Exception handling
  void *env_pgfault_upcall;    // Page fault upcall entry point

  // Lab 4 IPC
  bool env_ipc_recving;        // Env is blocked receiving
  void *env_ipc_dstva;        // VA at which to map received page
  uint32_t env_ipc_value;    // Data value sent to us
  envid_t env_ipc_from;        // envid of the sender
  int env_ipc_perm;            // Perm of page mapping received
};

struct Env *envs = NULL;          // All environments
struct Env *curenv = NULL;        // Current environment
static struct Env *env_free_list; // Free environment list

void env_init(void) {
  // Set up envs array
  env_free_list = envs;
  int i;
  for (i = 0; i < NENV; i++) {
    envs[i].env_id = 0;
    envs[i].env_status = ENV_FREE;
    envs[i].env_link = (envs + i + 1);
  }
  (envs + i - 1)->env_link = NULL;

  // Per-CPU part of the initialization
  env_init_percpu();
}

static envid_t sys_exofork(void) {
  struct Env *newenv;

  int result = env_alloc(&newenv, thiscpu->cpu_env->env_id);
  if (result) {
    panic("sys_exofork: problems with env_alloc\n")
    return result;
  }

  newenv->env_status = ENV_NOT_RUNNABLE;
  newenv->env_tf = thiscpu->cpu_env->env_tf;
  newenv->env_tf.tf_regs.reg_eax = 0;

  return newenv->env_id;
}

int env_alloc(struct Env **newenv_store, envid_t parent_id) {
  // Allocate env
  struct Env *e = env_free_list;
  if (e == NULL) {
    return -E_NO_FREE_ENV;
  }

  // Allocate and set up the page directory for this environment.
  int rc = env_setup_vm(e);
  if (rc < 0) {
    return r; // error
  }

  // Generate an env_id for this environment.
  int32_t generation = (e->env_id + (1 << ENVGENSHIFT)) & ~(NENV - 1);
  if (generation <= 0) {
    generation = 1 << ENVGENSHIFT;
  }
  e->env_id = generation | (e - envs);

  // Set the basic status variables.
  e->env_parent_id = parent_id;
  e->env_type = ENV_TYPE_USER;
  e->env_status = ENV_RUNNABLE; // ready
  e->env_runs = 0;

  // Clear out all the saved register state,
  // to prevent the register values
  // of a prior environment inhabiting this Env structure
  // from "leaking" into our new environment.
  memset(&e->env_tf, 0, sizeof(e->env_tf));

  // Set up appropriate initial values for the segment registers.
  // GD_UD is the user data segment selector in the GDT, and
  // GD_UT is the user text segment selector (see inc/memlayout.h).
  // The low 2 bits of each segment register contains the
  // Requestor Privilege Level (RPL); 3 means user mode.  When
  // we switch privilege levels, the hardware does various
  // checks involving the RPL and the Descriptor Privilege Level
  // (DPL) stored in the descriptors themselves.
  e->env_tf.tf_ds = GD_UD | 3;
  e->env_tf.tf_es = GD_UD | 3;
  e->env_tf.tf_ss = GD_UD | 3;
  e->env_tf.tf_esp = USTACKTOP;
  e->env_tf.tf_cs = GD_UT | 3;

  // Enable interrupts while in user mode.
  e->env_tf.tf_eflags = FL_IF;
  e->env_pgfault_upcall = 0;
  e->env_ipc_recving = 0;

  // Update local structures and return
  env_free_list = e->env_link;
  *newenv_store = e;
  return 0;
}

void env_create(uint8_t *binary, enum EnvType type) {
  struct Env *e;
  if (env_alloc(&e, 0) < 0) {
    panic("env_create: env_alloc failed");
  }
  load_icode(e, binary);
  e->env_type = type;
}

// 1. Initialize the kernel virtual memory layout for environment e.
// 2. Allocate a page directory, set e->env_pgdir accordingly,
// and initialize the kernel portion of the new environment's address space.
static int env_setup_vm(struct Env *e) {
  struct PageInfo *p = page_alloc(ALLOC_ZERO);
  if (p == NULL) {
    return -E_NO_MEM;
  }

  // Now, set e->env_pgdir and initialize the page directory.
  p->pp_ref++;
  e->env_pgdir = (pde_t *)page2kva(p);
  for (int i = PDX(UTOP); i < NPDENTRIES; i++) {
    e->env_pgdir[i] = kern_pgdir[i];
  }

  // UVPT maps the env's own page table read-only.
  // Permissions: kernel R, user R
  e->env_pgdir[PDX(UVPT)] = PADDR(e->env_pgdir) | PTE_P | PTE_U;

  return 0;
}

static void region_alloc(struct Env *e, void *va, size_t len) {
  uint32_t virt_add = ROUNDDOWN((uint32_t)va, PGSIZE);
  uint32_t size = ROUNDUP((uint32_t)len, PGSIZE);

  for (int i = 0; i < size; i += PGSIZE) {
    int rc = page_insert(
      e->env_pgdir, page_alloc(size),(void *)virt_add + i, PTE_U | PTE_W);
    if (rc) {
      panic("page_insert failed\n")
    }
  }
}

static void load_icode(struct Env *e, uint8_t *binary, size_t size) {
  struct Proghdr *ph, *eph;
  ph = (struct Proghdr *)((uint8_t *)PROGHDR + PROGHDR->e_phoff);
  eph = ph + PROGHDR->e_phnum;
  lcr3(PADDR(e->env_pgdir));

  for (; ph < eph; ph++) {
    if (ph->p_type == ELF_PROG_LOAD) {
      region_alloc(e, (void*)ph->p_va, ph->p_memsz);
      memset((void *)ph->p_va, 0, ph->p_memsz);
      memcpy((void *)ph->p_va, binary + ph->p_offset, ph->p_filesz);
    }
  }

  lcr3(PADDR(kern_pgdir));
  e_env_tf.tf_eip = PROGHDR->e_entry;
  region_alloc(e, (void *)USTACKTOP - PGSIZE, PGSIZE);
}

void sched_yield() {
  int i;
  if (thiscpu->cpu_env == NULL) {
    i = 0;
  } else {
    i = ENVX(thiscpu->cpu_env->env_id) + 1;
  }

  for (int k = 0; k < NENV; k++) {
    if (envs[i].env_status == ENV_RUNNABLE) {
      env_run(&envs[i]); // context switch from curenv to envs[i]
    }
    i = (i + 1) % NENV;
  }

  if ((thiscpu->cpu_env != NULL) &&
      (thiscpu->cpu_env->env_status == ENV_RUNNING)) {
    env_run(thiscpu->cpu_env);
  }
}

void env_run(struct Env *e) {
  if (curenv != e) {
    if (curenv && curenv->env_status == ENV_RUNNING) {
      curenv->env_status = ENV_RUNNABLE;
    }

    e->env_status = ENV_RUNNING;
    e->env_runs += 1;
    curenv = e;
    lcr3(e->env_cr3);    
  }

  env_pop_tf(&(e->env_tf));
}

void env_pop_tf(struct Trapframe *tf) {
  asm volatile(
    "movl   %0, %%esp   \n\t"
    "popal              \n\t"
    "popl   %%es        \n\t"
    "popl   %%ds        \n\t"
    "addl   $0x8, %%esp \n\t" // skip tf_trapno and tf_errcode
    "iret               \n"   // return from interrupt, KERNEL_MODE -> USER_MODE
    : : "g" (tf) : "memory");
  panic("iret failed");  // mostly to placate the compiler
}
```

## (8) lib/syscall.c

```c
static inline int32_t syscall(
    int num, int check, uint32_t a1, uint32_t a2, uint32_t a3, uint32_t a4, uint32_t a5) {
  uint32_t ret;

  asm volatile(
      "int %1    \n"
      : "=a" (ret)          // mov  num, %eax
      :  "i" (T_SYSCALL)    // mov   a1, %edx
         "a"                // mov   a2, %ecx
         "d"                // mov   a3, ebx
         "c"                // mov   a4, edi
         "b"                // mov   a5, esi
         "D"                // int   T_SYSCALL
         "S"                // mov %eax, ret
       : "cc", "memory");
  )

  if (check && ret > 0) {
    panic("syscall returned an error");
  }

  return ret;
}
```
