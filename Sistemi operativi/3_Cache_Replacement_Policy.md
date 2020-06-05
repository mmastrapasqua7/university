## Page Replacement Policy

Is the act of deciding which page to **evict** in case of full memory (LW reached). The goal of the policy is to minimize the number of **cache misses**, i.e., to **minimize the numbers of PAGE FAULTS**, so the number of times the OS have to fetch a page from disk.

### Metric

#### AMAT (Average Memory Access Time)

$$
T_M = cost\_of\_accessing\_memory
$$

$$
T_D = cost\_of\_accessing\_disk
$$

$$
P_{miss} = probability\_of\_cache\_miss
$$

$$
AMAT = T_M + (P_{miss} * T_D)
$$



#### Hitrate

$$
Hitrate = \frac{Hits}{Hits + Misses}
$$

### Policies

#### Optimal

replaces the page that will be accessed *furthest in the future*. This is why is also called the **oracle policy**, because it can see the future, thus reaching the fewest-possible cache misses. Even if this is the best policy, it suffer from **cold-start miss (compulsory miss)**.

#### FIFO (First In First Out)

pros:

- simple

cons:

- has no memory

- can't determine the importance of a block

#### RANDOM

pros:

- better than FIFO, worse than OPTIMAL

- best performane on random workload

cons:

- depends on luck

- has no memory

- can't determine the importance of a block

#### LRU / LFU (Least Recently/Frequently Used) (Family)

Family of policies that record historycal information about blocks. They are based on the **principle of locality**, in fact they use parameters like **frequency** and **recency**

pros:

- has memory, use history

cons:

- difficult to implement efficiently: extra work of updating on every memory reference

- waste of memory

- slow

#### Clock Algorithm (LRU approximation)

requires hardware support (**use bit** or **reference bit**). Every page in the system has a **use bit** that is set to 1 by the hardware **every time is accessed (read and write)** and never cleared by hardware. The clock algorithm starts

1. it points to a page

2. if **use bit = 1**, set the use bit to 0 and points to the next page

3. the algorithm continues until it finds a **use bit = 0**. In the best case, the page has not been accessed recently, in the worst case, that all pages have been looked so every page has been cleared.

### Dirty Pages

every page has a **dirty bit** that is set every time a page is accessed. If a page has not been accessed, the evict of the page is clear, so it doesn't require any I/O operations to save it again in the disk (swap space).
