## Processes And Threads

### Threads

composed of:

- share the same address space with the process

- own program counter (PC)

- own stack

- own registers
  
  - a context switch must take place if switching from T1 to T2
  
  - we use a TCB (Thread Control Block) to save informations about the thread
  
  - on context switch, the address space remain the same

pros:

- parallelism

- avoid I/O blocking

### Process

composed of:

- address space
  
  the memory that a process can address

- registers (machine state)
  
  - program counter (PC) or instruction pointer (IP): points to the next instruction to be fetched and executed
  
  - stack pointer
  
  - frame pointer

- I/O tables (opened files)

**PROCESS STATES**

- **running** (OS can run only ready process)

- **blocked** (a process blocked must be set to ready before it can be scheduled)

- **ready**

on fork():

- the child has a new fully separated address space, but it is an **exact copy of all the memory segments of the parent process**

- the child process has a full copy of its parent's file descriptors for interprocess communication.

## Problems

### Race Condition

when the result depends on the timing of execution of the code, so it depends on the scheduler. Thus the result is **indeterminate**. It happens when multiple threads enter the critical section at the same time

### Critical Section

is a piece of code that accesses a shared variable and must not be executed by more than 1 thread per time

### Mutual exclusion

a guarantee that if one thread is executing within the critical section, the other will be prevented from doing so
