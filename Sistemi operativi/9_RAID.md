## RAID (Redundant Array of Inexpensive Disks)

pros:

- **performance**

- **capacity**

- **reliability**

- **REDUNDANCY**

- **transparency**: RAIDs look like a normal disk to the OS, while it works undercover

when a RAID system receives a **logical I/O request**, it first calculates the real address (of the disk/disks) in order to complete the request, and then issue one or more **physical I/O requests**.

### FAIL-STOP Model

A disk can be exactly in 2 states:

- **working**

- **failed**

**it assumes FAULT DETECTION**

### RAID Properties

- **capacity**
  
  given a set of N disks, each with B blocks, how much capacity is available to the system (the OS) of the RAID?
  
  - Without redundancy, the answer is simply N \* B
  
  - With **mirroring**, is (N \* B) / 2

- **reliability**
  
  how many disk faults can the design tolerate?

- **performance**

### TYPE OF RAIDs

#### RAID 0 (striping)

the array if blocks are spread across the disks in a round-robin fashion

- **CHUNK SIZE**: the number of blocks on each disk before moving to the next
  
  - **little chunk size**
    
    pros:
    
    - increase parallelism of reads and writes to a single file
    
    cons:
    
    - increase positioning time: is determined by the maximum positioning time of the request across all disks
  
  - **large chunk size**
    
    pros:
    
    - reduce positioning time: is determined by the positioning time of a single disk
    
    cons:
    
    - reduces intra-file parallelism

- capacity:
  
  N \* B

- reliability:
  
  0: a disk failure is a system failure (LOSS OF DATA)

- performance:
  
  - latency: single disk
  
  - sequential throughput: (N = number of disks multiplied by the S = sequential bandwith of a single disk)
    
    - read
      
      N * S
    
    - write
      
      N * S
  
  - random throughput: (R = random bandwith)
    
    - read
      
      N * R
    
    - write
      
      N * R

#### RAID 1 (mirroring)

- capacity:
  
  (N \* B) / 2

- reliability:
  
  1 disk loss
  
  - upper bound: N / 2 disk failures if you're very lucky

- performance:
  
  - latency: single disk (circa)
  
  - sequential throughput
    
    - read
      
      (N / 2) * S
    
    - write
      
      (N / 2) * S
  
  - random throughput
    
    - read:
      
      N \* R
    
    - write
      
      (N / 2) \* R

#### RAID 4 (saving space with parity)

1 disk is reserved for only parity blocks (XOR function)

- capacity:
  
  (N - 1) \* B

- reliability:
  
  1 disk loss

- performance
  
  - sequential throughput:
    
    - read
      
      (N - 1) \* S
    
    - write
      
      (N - 1) \* S
  
  - random
    
    - read
      
      (N - 1) \* R
    
    - write
      
      (N / N) \* (R / 2) = R / 2

#### RAID 5 (rotating parity)

the disk reserved for parity with RAID 4 is spread across disks

- capacity
  
  (N - 1) \* B

- reliability
  
  1 disk loss

- performance
  
  - sequential
    
    - read
      
      (N - 1) \* S
    
    - write
      
      (N - 1) \* S
  
  - random
    
    - read
      
      N \* R
    
    - write
      
      (N / 4) \* R
