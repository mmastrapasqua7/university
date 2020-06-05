## Concurrency Problems

There are 2 types of bug related to concurrency programs:

- **DEADLOCK BUGS**

- **NON-DEADLOCK BUGS**
  
  - Atomic Violation
  
  - Order Violation

### NON-DEADLOCK BUGS

#### Atomic Violation

When a code region is intended to be atomic, but the atomicity is not enforced during execution. The solution is simple: just find in the shared resources / references and look at the access of these structures by different thread, then add a mutex

#### Order Violation

When a desired order between two memory access is flipped, i.e., for example A should be executed before B but the order is not enforced during execution. The solution: use condition variables.

### DEADLOCK BUGS

#### Conditions for a deadlock (all needed)

1. **mutual exclusion**: a thread claim exclusive control over a resource

2. **hold-and-wait**: a thread holds a lock but is waiting for another lock to be freed

3. **no preemption**: lock cannot be removed from a thread holding it with the force

4. **circular wait**: a circular chain of threads exist such that **every** thread in the chain holds one or more locks that are being requested by the next thread in the chain

**if any of these 4 conditions are not met, DEADLOCK CANNOT OCCUR**

#### Prevention of deadlock bugs

##### Preventing circular wait

total ordering on lock acquisition, but if there are many locks, even partial ordering can help preventing these

##### Preventing hold and wait

just acquire all locks at once, using a new lock that lock the locks. Example

```c
pthread_mutex_lock(prevention);
pthread_mutex_lock(lock1);
pthread_mutex_lock(lock2);
...
pthread_mutex_unlock(prevention);
```

cons:

- difficult to implement with the enormous number of modules and encapsulation

- can decrease the level of concurrency because all locks are acquired earlier than when they are truly needed

##### Preventing no preemption

```c
top:
  pthread_mutex_lock(L1);
  if (pthread_mutex_trylock(L2) != 0) {
    pthread_mutex_unlock(L1); // ROLLBACK
    goto top;
  }
```

a way to prevent the fact that we acquire a lock and then we wait for acquiring the other lock is using a new function call to **try to grab the lock** instead of waiting it. We use the ```pthread_mutex_trylock()``` so we either grab the lock or retry again by **releasing the lock we were holding**

cons:

- **livelock**: it is possible that 2 thread could both be repeatedly attempting this sequence, repeatedly failing to acquire the lock. They both loop indefinitely.
  
  - solution: add a random delay before looping back (like ethernet 802.1)

##### Preventing mutual exclusion
