## I/O

### Canonical Device

composed of

- **INTERFACE**: 3 registers:
  
  - **STATUS** register
  
  - **COMMAND** register
  
  - **DATA** register

- **INTERNAL STRUCTURE**
  
  - MCU
  
  - DRAM
  
  - **firmware**
  
  - ecc...

### Using I/O device

#### Polling

continously asking the device what's going on and if it has finished the work

cons:

- Very slow, waste of CPU cycles

#### Interrupts

instead of polling the device repeatedly, the OS can put the calling process to sleep. When the device finishes its work, it will raise an interrupt, and the OS will wake up the sleeping process to proceed.

pros:

- better CPU utilization

cons:

- the CPU still need to copy the data it wants to write to disk before issuing the I/O request. When the data to write is very huge, is a waste of time

#### DMA (Direct Memory Access)

can orchestrate the transfers between the RAM and the DISK **directly**, without much CPU intervention. When the DMA is finished, it will raise an interrupt.

### Device Interaction

- I/O instructions in the instruction set of the CPU **privileged**

- memory-mapped I/O
  
  if we issue load/store (RAM instruction) at a certain address, the hardwaire will automatically redirect those instruction to some mapped device, thus making little holes in the main memory

x86 use both methods:

- **in** and **out** instruction

- memory mapped some chunk of memory
  
  - BIOS reserved memory (low memory, < 1MB)
  
  - VGA memory (low memory, < 1MB)

### Drivers

to keep the OS device-neutral and make every device look like a common abstract one, we need **abstraction**

- HIGH LEVEL: **abstraction** (POSIX API, block read/write)

- LOW LEVEL: **driver**
  
  - interact with the device interface (registers)

### IDE Disk Driver

#### Protocol for interaction

1. **wait for drive to be ready**:
   
   **READ** status register ```0x1F7``` until drive is **READY** **and** **NOT BUSY**

2. **write parameters to command registers**
   
   - **WRITE** sector count to ```0x1F2```
   
   - **WRITE** logical block address (```0x1F3``` to ```0x1F5```, low-mid-high) 
   
   - **WRITE** drive number (master or slave) to ```0x1F6```

3. **start I/O**
   
   **WRITE** to command register ```0x1F7``` the **READ** or **WRITE** command
   
   - in case of **WRITE**:
     
     1. wait drive until status register ```0x1F7``` is **READY and DRQ**
     
     2. **WRITE** data to data port ```0x1F0```

4. **handle interrupts**

5. **error handling**
