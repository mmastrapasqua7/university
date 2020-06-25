## Scheduling

### Metrics

#### Turnaround Time

The time at which the job completes minus the time at which the job arrived in the system. Is a **performance** metric.

$$
T_{turnaround} = T_{completion} - T_{arrival}
$$

##### Average Turnaround Time

$$
T_{t\_average} = \frac{T_{t1} + T_{t2} + ... + T_{tn}}{n}
$$

#### Response Time

The time from when the job arrives in a system to the first time is scheduled. Is a **fair** metric.

$$
T_{response} = T_{first\_run} - T_{arrival}
$$

##### Average Response Time

$$
T_{r\_average} = \frac{T_{r1} + T_{r2} + ... + T_{rn}}{n}
$$

### Algorithms

#### FIFO / FCFS (First In First Out / First Come First Served)

Pros:

- turnaround time

Cons:

- response time

- convoy effect

#### SJF (Shortest Job First)

Pros:

- turnaround time

- optimal scheduling algorithm if all jobs arrive at the same time

Cons:

- response time

- non-preemptive

- convoy effect

- not optimal if the jobs don't arrive at the same time

#### STCF (Shortest Time-to-Complete First)

SJF **+ preemption**

Pros:

- turnaround time

- preemptive scheduling

- optimal scheduling even if jobs don't arrive at the same time

Cons:

- response time

#### RR (Round Robin / Time-Slicing)

Pros:

- response time

- the shorter the time slice is, the better response time is

Cons:

- turnaround time (worst scheduler)

- cache, tlb

#### MLFQ (Multi-Level Feedback Queue)

MLFQ approximates the SJF.

##### Rules:

###### Static Behavior Rules

- **(1) if Priority(A) > Priority(B), A runs, B doesn't**

- **(2) if Priority(A) = Priority(B), A and B run in RR using the time slice of the given queue**
  
  Cons:
  
  - lowest priority jobs (not interactives) never run.

- **(3) when the job enters the system, it is placed at the highest priority (topmost queue)**
  
  The scheduler assumes that every job entering the system is a short job, thus giving it the high priority, so it runs quickly and then it completes.

- **(5) after some period S, move all the jobs in the system to the topmost queue (BOOST)**
  
  <u>Solves 3 problems of rule 2, 4a and 4b in 1 shot: lowest priority job, starvation and behavior-change of job. A user can still gaming the scheduler</u>

###### Dynamic Behavior Rules

- **(4a) If a job uses up an entire time slice while running, its priority is reduced**

- **(4b) If a jobs gives up the CPU before the time slice is up, it stays at the same priority level**
  
  Cons:
  
  - STARVATION: if there are too many interactive jobs, they will consume all the CPU time and long-running CPU-intensive jobs will NEVER receive any CPU time (<u>solved by rule 5</u>)
  
  - GAMING THE SCHEDULER: A smart user can program the job to issue an IO operation, thus relinquishing the CPU before its time slice is done. This type of job could monopolize the CPU (<u>solved by rule 4 definitive</u>)
  
  - If a job changes its behavior over time, so a CPU-intensive job can transition to interactive, but the scheduler doesn't give a fuck and keeps it in the lowest queue (<u>solved by rule 5</u>)

- **(4 definitive) once a job uses up its time allotment at a given level, REGARDLESS of how many times it has given up the CPU, its priority is reduced**
  
  Solves the gaming problem.

## Memory Virtualization

### Base and Bound (Dynamic Hardware-based Relocation)

**base** and **bounds** registers per CPU. Each program is written and compiled as it is loaded at address 0, however the OS decides where in physical memory it should be loaded and sets the base and bound registers. The CPU first check that the memory reference is within bounds to make sure it is legal. If not, the CPU will raise an exception.

 **limit** can be:

- size of the address space

- physical address of the end of the address space

requires:

- privileged instruction to change these registers

cons:

- to relocate a process address space, the OS must deschedule the process, copy all the address space to a new location and then change the base and bound registers

- waste of memory: the memory between stack and heap is allocated in physical memory but unused. Waste of time for relocation and waste of memory overall

- difficult to run a program when the entire address space doesn't fit into memory

### Segmentation (generalized Base and Bound)

we divide the memory in logical segments:

1. code segment

2. data segment (heap)

3. stack segment

Instead of having one base bound pair per process, we have one base bound pair per logical segment. 2 approaches:

- **explicit**
  
  i.e., a 16 bit address is divided in top-2 bit and low-14 bit, where the top 2 bits are used as **segment selector**, so they select the segment (code, heap, stack).

- **implicit**
  
  i.e., in case of instruction fetch, the address resides in the code segment. When the stack or break pointer is used as base, the address resides in the stack segment. Any other address is in the heap segment

What we need to save inside segment registers:

- segment id (code = 00, heap = 01, stack = 11)

- base address

- size (max 4kB)

- grows positive (1 = yes, 0 = no)

- protection (read-execute, read-write)

pros:

- code sharing

- better memory accounting

cons:

- malloc() must check the size of the segment to accomplish the request. If there isn't enough space, it must grow the segment, non a trivial task

- **external fragmentation**: different sizes for every segment

- free space management is difficult

### Paging

The idea is to chop up space into **fixed-size pieces**. This idea is called paging. Each fixed-size unit is called page. The memory is viewed as and array of fixed-size pages called **page frames**. Per farlo viene creata una **page table** (array lineare di pagine) per ogni processo che mantiene traccia delle pagine usate.

Cosa serve salvare nelle **page table entries**:

- Page Frame Number (PFN): indirizzo fisico della pagina

- valid bit: se quella pagina di memoria e' valida (e' stata allocata oppure no)

- protection bits: read-write read-execute

- present bit: indicates whether the page is in memory or in disk (has been swapped out)

- dirty bit: indicates thether the page has been modified since it was brought into memory

- reference bit / access bit: how many times the page has been accessed.

ATTENZIONE: CASO INTEL (valid e present bit sotto un unico bit)

- present bit:
  
  - P = 1: page both present AND valid
  
  - P = 0: not present OR not valid. The OS will figure it out

esempio:

1. instruction fetch:
   
   1. virtual_addr = VPN | OFFSET
   
   2. pte_addr = pg_table_base_register + (VPN * sizeof(PTE))
   
   3. pfn = read_pfn(pte_addr) (**FIRST READ**)
   
   4. phys_addr = pfn | OFFSET
   
   5. instruction = read_instr(phys_addr) (**SECOND READ**)

pros:

- no more "grows positive". We don't give a fuck about how processes use the memory (pages)

- free space management is very easy, just keep a free list of all free pages

cons:

- page tables are a waste of memory: in a typical 32 bit address space with 20 bit for page number, there are 2^20 page table entries to manage (more than 1 Million), where each entry is 4B in size, for a total of 4MB per page table (per process). A typical system has circa 100 process running. 400MB of memory to store only for memory management. Madness.

- for every memory reference (instruction fetch and load/store), paging requires to perform **1 extra memory reference**.

### Paging: bigger pages

The solution is to increase the size of a page from 4KB to 16KB. So now, for a typical address space of 32 bit, we have 18 bit for page number, for a total of 2^18 page table entries of about 4B, for a total of 1MB per page table. For 100 processes, the total of memory used is 100MB.

cons:

- **internal fragmentation**: most of the processes use less then 4KB

- waste of memory

### Paging and Segments (Hybrid approach, smaller tables)

Instead of having a **single page table** for the entire addresss space, we have a page table **per logical segment** (code, stack, heap). Instead of having **base** and **bound** registers per logical segment, we use the base register to point to the physical address of the page table of that segment. Bound register is used to indicate **the end of the page table**.

pros:

- no more waste: saves memory by using dynamic sized page tables (and not fixed-size) such that unused pages no longer occupy memory in form of page table entries

cons:

- **external fragmentation**: since we have page tables of arbitrary size and no more fixed-size page tables, finding free space for them is difficult.

- sparsely-used memory waste page table space

### Multi-level Page Tables (Page Directory Tables)

1. create a normal page table, page-sized. We call this **page directory table**

2. create another page table that can map **all** the address space (huge page table)

3. chop-up this page table in page-sized units (fixed-size), so now we have many page tables

4. if a page table is valid (is in use), add his address to the page directory table in form of **page directory entry**. If it is not, don't allocate it at all.

Cosa serve salvare:

- Page Directory Entry:
  
  - valid bit: if a PDE is valid, it means that **at least** one of the Page Table Entry (PTE) is valid, a.k.a, one page pointed by the page table is valid. If a PDE is not valid (valid bit = 0), PDE is undefined

pros:

- save space

- easy management of memory

- indirection: we no longer need to place a page table in a contiguously portion of memory

cons:

- or every memory reference (instruction fetch and load/store), paging requires to perform **2 extra memory reference**.

### Inverted Page Tables (HashMaps)

From single Paging, instead of having many page tables in memory, 1 page table per process, we keep a single huge page table that **has an entry for each physical page**. The entry tell us which process is using this page, which virtual page of that process maps to this physical page and so on. To find the correct entry, an hash table data structure is used.
