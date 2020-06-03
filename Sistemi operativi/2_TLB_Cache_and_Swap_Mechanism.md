## TLB (Translation-Lookaside Buffer)

is part of the MMU (Memory Management Unit) and is also called **address-translation cache** because it caches popular virtual-to-physical address translations. Is **fully associative** so it's accessed in parallel. When switching to other process, the hardware (or OS) must **flush** the TLB, but it is a slow operation: it simply **invalidate** all the entries

### Algorithm:

1. extract the VPN (Virtual Page Number) from the virtual address

2. check if TLB holds the translation
   
   1. case SUCCESS (**TLB HIT**): extract the PFN (Page Frame Number) and concatenate it with the OFFSETT of the virtual addres and you obtain the physical address.
   
   2. case FAILURE: (**TLB MISS**): save the IP (Instruction Pointer), access the page table to find the correct translation. If it finds the correct translation (valid and have permission), **update the TLB and retry the instruction**, a.k.a, return to point 2 (check if TLB holds the translation)

3. use the physical address to access the memory

### Types of TLB

#### Software-managed TLB (RISC: ARM)

the hardware rise an exception on TLB MISS.

pros:

- flexibility: the OS can use any data structure it wants to implement the page table

- simplicity: hardware simply rise an exception

cons:

- difficult to implement it correctly. Can cause infinite chain of TLB MISS

#### Hardware-managed TLB (CISC: x86)

## Page Faults and Swap Space

The **SWAP SPACE** is a reserved space on disk where the OS swap pages from memory (memory -> disk). Is not the only place where there's a swap traffic. Example: the code, which is static, can be moved away from memory without being saved on the swap space on disk because it can refetched from where the program resides in the disk.

**PAGE FAULT** is the act of accessing a page that is not in physical memory (ON TLB MISSES). On a page fault, the OS is invoked to serve the page fault. Code for page fault is commonly called **page fault handler**. The OS uses bits from the page table entry (PTE) for a disk address, like the PFN. When the disk I/O completes, the OS **will update the page table** to mark the page as present, **update the PFN field** of the PTE to record the new memory location, and retry the instruction.

- VALID: Ok, fetch the page

- INVALID: Terminate the offending process.

**PAGE REPLACEMENT POLICY** when the memory is full, the OS page out one or more pages to make room fro new pages. This action is called **REPLACE**.

example: PAGE FAULT

1. **TLB MISS** (PRESENT = 0, VALID = 1 in PTE)
   
   1. **PAGE FAULT occurs**
      
      1. the OS try to find a free page in memory for the new page. If it doesn't find any space, it will call the **replacement algorithm** to kickout some pages from memory and then retry to find a free page in memory
      
      2. now, with a free page in memory, OS issues the I/O request to read that page from **swap space** to **ram**.
      
      3. the OS updates the page table (PRESENT = TRUE, PFN = PFN of free page found in PTE)
      
      4. **retries the instruction**

2. **TLB MISS**. (PRESENT = 1, VALID = 1 in PTE) The TLB cache the VPN-PFN translation from the page table

3. **TLB HIT**

The OS use some kind of limits to track the usage of the memory. These limits are called

- **high watermark (HW)** 

- **low watermark (LW)**
  
  If there are less then (<) LW-pages available, a background daemon is responsible for freeing memory. This daemon evict pages until there are (>=) HW-pages available. This daemon is also called **swap daemon / page daemon**
