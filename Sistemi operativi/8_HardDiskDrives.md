## Hard Disk Drives

array of sectors (512B blocks)

- Spindle: motor that spins the platters (1 per HD)

- Disk head: (1 per surface)

- Disk arm: (1 per head)

- Platter: circular hard surface

- Surface: side of a platter (2 per platter)

- Track: concentric circle of sectors

- Cilinder: all the tracks that have the same distance from the center

- Sector: 512B block

An hard drive is composed of a spindle, which moves 1 or more platter. Every platter have 1 or 2 surface. On every surface there are various track of sectors, each sector of 512B.

### Engineering

- **TRACK SKEW**
  
  The hard disk can implement some sort of **track skew** to make sure that sequential reads can be properly serviced even when crossing track boundaries

- **MULTI-ZONED**
  
  Because outer tracks have more sectors than inner tracks, the hard drive is zoned. Every zone has the same number of tracks. Outer zones have more tracks than inner zones.

- **CACHE** (**TRACK BUFFER**)
  
  - **write back**: immediate acknowledge, but without doing the job instantly. Data is written in the cache of the hard drive but still need to be written to disk
  
  - **write through**: true acknowledge, it signal ACK **after** data is actually written to the disk

### Math

#### Components

- **Rotational Delay**
  
  - wait for the desired sector to rotate under the disk head
  
  - T_rotation = R / 2 (average of 1 round)
  
  - Example:
    
    - 15000 RPM (round/minute)
    
    - 15000 / 60s = 250 RPS (round/second)
    
    - 1000ms / 250 = 4ms (1 round every 4ms)
    
    - T_rotation = 4ms / 2 = 2ms

- **Seek Time**
  
  - acceleration
  
  - coasting
  
  - deceleration
  
  - settling (significant)

- **Transfer**

#### Formulas

$$
T_{I/O} = T_{seek} + T_{rotation} + T_{transfer}
$$

$$
R_{I/O} = \frac{Size_{transfer}}{T_{I/O}}
$$

### Disk Scheduling (Algorithm)

#### SJF Family (Shortest Job First)

##### SSTF (Shortest Seek Time First) SSF

orders the queue of I/O requests by picking requests on the **nearest track to complete first**

cons:

- geometry of the HD is not available to the OS
  
  - solution: the OS can simply implement the **nearest block first**

- **starvation**
  
  if we stream a huge number of requests of (for example) inner traks, the OS will never go to the outer stracks, thus let some of the requests to starve

##### SCAN (Elevator)

simply move back and forth across the disk servicing the requests in order across the tracks.

- **SWEEP**: a single pass across the disk (from outer to inner track, or reverse)

if a track has already been serviced, the request for that track will be served on the next sweep

cons:

- **starvation**

##### FSCAN (Freeze SCAN)

freexes the queue to be serviced when it is doing a sweep.

pros:

- **avoid starvation** 

##### CSCAN (Circular SCAN)

instead of moving sweeping in both directions back and forth, the CSCAN only sweep from one side to the other, and then reset its head back to the start.

pros:

- **fair**: SCAN/FSCAN favors middle tracks, because going back and forth requires to pass from middle tracks. In this case, every track has the same mean time to be accessed

#### SPT Family (Shortest Path First)

the problem with the SJF family is that they all **ignore rotation time**.

##### SPTF / SATF (Shortest Positioning/Access Time First)

this algorithm simply try to calculate wich of the requests require less time to accomplish. To do so it must know the geometry of the disk, i.e., how many tracks there are, how many sectors they contain ecc... Unfortunately, the OS can't know this information, because of various types of HD.

pros:

- faster

cons:

- impracticable by the OS (can't know the geometry of the HD)
  
  - **solution: this algorithm is implemented INSIDE THE HD (HARDWARE-FIRMWARE)**

### Issues

- some of the requests can be grouped together to have better performance
  
  - schedulers perform **merge** to increment the throughput

- how much the OS should wait before issuing I/O requests? 2 approaches
  
  - **work-conserving**: immedately, without delay
  
  - **non-work-conserving**: after a delay to wait other requests and increment the throughput
