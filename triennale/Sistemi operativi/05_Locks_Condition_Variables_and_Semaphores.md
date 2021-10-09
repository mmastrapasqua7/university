## Problems:

### Race Condition

when the result depends on the timing of execution of the code, so it depends on the scheduler. Thus the result is **indeterminate**. It happens when multiple threads enter the critical section at the same time

### Critical Section

is a piece of code that accesses a shared variable and must not be executed by more than 1 thread per time

### Mutual exclusion

a guarantee that if one thread is executing within the critical section, the other will be prevented from doing so

## Synchronization

### Locks

Provide the **mutual exclusion** to a critical section.

```c
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_lock(&lock);
// critical section
pthread_mutex_unlock(&lock);
```

If another thread does hold the lock, the thread trying to grab the lock **wil not return from the call until it has acquired the lock**. To build this lock, there's a need of hardware support.

#### Metrics:

- **CORRECTNESS**: does the lock provide mutual exclusion?

- **FAIRNESS**: can you guarantee that a waiting thread will ever enter the critical section?

- **PERFORMANCE**: what are the costs of using the lock?

#### Building the locks: SPIN-WAIT LOCKS

##### 1st approach (fail): load and stores (flag)

```c
void init(lock_t *mutex) {
  mutex->flag = 0;
}

void lock(lock_t *mutex) {
  while(mutex->flag == 1) {
    ; // spin-wait
  }
  mutex->flag = 1;
}

void unlock(lock_t *mutex) {
  mutex->flag = 0;
}
```

- NOT CORRECT
  
  2 thread can set the flag = 1 (in case of interrupt)

- NOT FAIR

- NOT PERFORMANT
  
  spin-wait

##### 2nd approach: test-and-set (atomic exchange)

```c
int test_and_set(int *old_value, int new_value) {
  int ov = *old_value;
  *old_value = new_value;
  return ov;
}

void init(lock_t *lock) {
  lock->flag = 0;
}

void lock(lock_t *lock) {
  while (test_and_set(&lock->flag, 1) == 1) { // while old_value == 1
    ; // spin-wait
    // test_and_set continues to return 1 until the other thread is
    // holding the lock. When the lock is released, 0 is returned
    // and this thread immediatly acquire the lock (the set part)
  }
}

void unlock(&lock) {
  lock->flag = 0;
}
```

- CORRECT

- NOT FAIR: requires preemptive scheduler, requires more than 1 CPU

- NOT PERFORMANT: if there are N thread using the same lock to access the same critical section, we will have N-1 thread spin-waiting, wasting CPU cycles.

##### 3rd approach: compare-and-swap (compare-and-exchange)

```c
int compare_and_swap(int *current_value, int expected, int new_value) {
  int cv = *current_value;
  if (cv == expected) {
    *current_value = new_value; 
  }
  return cv;
}

void lock(lock_t *lock) {
  while (compare_and_swap(&lock->flag, 0, 1) == 1) {
    ; // spin-wait
  }
}
```

identical to test-and-set

- CORRECT

- NOT FAIR

- NOT PERFORMANT

##### 4th approach: load-linked and store-conditional

```c
int load_linked(int *ptr) {
  return *ptr;
}

int store_conditional(int *ptr, int new_value) {
  if (/* NO UPDATE TO *ptr SINCE LOAD LINKED TO THIS ADDRESS */) {
    *ptr = new_value;
    return 1; // success 
  } else {
    return 0; // failed
  }
}

void lock(lock_t *lock) {
  while (true) {
    while (load_linked(&lock->flag) == 1) {
      ; // spin-wait
    }

    if (store_conditional(&lock->flag, 1) == 1) {
      return; // if no update, return value is 1, so success
              // if an update occurred, repeat again
    }
  }
}
```

same as above

- CORRECT

- NOT FAIR

- NOT PERFORMANT but has **less memory writes**

##### 5th approach: fetch-and-add

```c
typedef lock_t {
  int ticket;
  int turn;
}

int fetch_and_add(int *ptr) {
  int old_value = *ptr;
  *ptr = old_value + 1;

  return old_value;
}

void lock(lock_t *lock) {
  int myturn = fetch_and_add(&lock->ticket);
  while (lock->turn != myturn) {
    ; // spin-wait
  }
}

void unlock(lock_t *lock) {
  lock->turn += 1;
}
```

- CORRECT

- FAIR: it ensures progress between threads. Every thread that want to acquire the lock gets a ticket, and they wait until it is its turn.

- NOT PERFORMAN but has **less memory writes**

#### Building the locks: NO MORE SPIN-WAIT

##### 1st: yield()

it simply gives up the CPU without spinning

- CORRECT

- NOT FAIR: can starve, lot of context switch

- NOT PERFORMANT: context switch costs a lot

##### 2nd: park() and unpark()

queue of sleeping threads. Resolve the performance problem of context switch

```c
typedef lock_t {
  int flag;
  int guard; // spin-wait lock around the flag
  queue_t *q;
}

void lock(lock_t *m) {
  while (test_and_set(&m->guard, 1) == 1) {
    ; // spin-wait
  }

  if (m->flag == 0) {
    m->flag = 1;
    m->guard = 0;
  } else {
    queue_add(m->q, gettid());
    setpark();
    m->guard = 0;
    // could sleep forever without setpark()
    park();
  }
}

void unlock(lock_t *m) {
  while (test_and_set(&m->guard, 1) == 1) {
    ; // spin-wait
  }

  if (queue_empty(m->q)) {
    m->flag = 0;
  } else {
    unpark(queue_remove(m->q));
  }

  m->guard = 0;
}
```

### Condition Variables

useful when some kind of signaling must take place between threads if one thread is waiting for another to do something before it can continue. A thread wishes to check whether a **condition** is true before continuing its execution.

```c
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;

pthread_mutex_lock(&lock);

while (ready == 0) {
  pthread_cond_wait(&cond, &lock);
}

pthread_mutex_unlock(&lock);
```

if a thread calls the wait routine, **the thread will be put on sleep AND release the lock**. **Before the thread will being woken from sleep, the wait routine will reacquire the lock**

#### CONDITION VARIABLE

is an explicit queue that threads can put themselves on when some state of execution (a **condition**) is not as desidered, so they wait for that condition. When a thread change that state/condition, can wake one of the waiting threads allowing it to continue.

```c
pthread_mutex_t m = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t c = PTHREAD_COND_INITIALIZER;
int done = 0;

// T1:
void *parent() {
  pthread_mutex_lock(&m);
  done = 1;
  pthread_cond_signal(&c);
  pthread_mutex_unlock(&m);
}

// T2
void *child() {
  pthread_mutex_lock(&m);

  while (done == 0) {
    pthread_cond_wait(&c, &m); // releases the lock and put itself to sleep
  }

  pthread_mutex_unlock(&m);
}
```

- importance of ```done```
  
  without the ```done``` variable it can happen that parent signal the condition when child is awake, then the child runs and put itself on sleep, sleeping forever.

- importance of the lock
  
  without the lock, if the child checks the done variable, which is 0, but before putting itself on sleep, it is interrupted and parent runs, setting done to 1. Then, child runs and sleeps forever.

### Semaphores

can be used as both locks and condition variables. A semaphore is an object with an integer value manipulated with 2 routines: sem_wait() and sem_post(). **The initial value of the semaphore determines its behavior**

```c
sem_t s;
sem_init(&s, 0, 1);

sem_wait(&s)
// critical section
sem_post(&s)
```

#### How Semaphores are made

```c
typedef struct sem_t {
  int value;
  pthread_cond_t cond;
  pthread_mutex_t lock;
}

void sem_init(sem_t *s, int value) {
  s->value = value;
  cond_init(&s->cond);
  mutex_init(&s->lock);
}

void sem_wait(sem_t *s) {
  mutex_lock(&s->lock);

  while (s->value <= 0) {
    cond_wait(&s->cond, &s->lock);
  }
  s->value -= 1;

  mutex_unlock(&s->lock);
}

sem_post(sem_t *s) {
  mutex_lock(&s->lock);

  s->value += 1;
  cond_signal(&s->cond);

  mutex_unlock(&s->lock);
}
```

#### Binary Semaphore (Locks)

```c
int sem_wait(semt_t *s) {
  // wait value to be 1
  // set value to 0
}

int sem_post(sem_t *s) {
  // set value to 1
}
```

#### Semaphore for ordering

can be used to order events in a concurrent program

```c
sem_t s;

// T1
void parent() {
  sem_init(&s, 0, 0);
  pthread_t c;
  pthread_create(&c, NULL, child, NULL);

  sem_wait(&s) // waiting the child to finish

  printf("child finished")  
}

void child() {
  sem_post(&s) // finished
}
```

### Producer/Consumer problem (bounded-buffer)

#### Single Element

```c
int buffer;

sem_t empty;
sem_t full;

void put(int value) {
  buffer = value;
}

int get() {
  return buffer;
}

void *producer(void *arg) {
  for (int i = 0; i < loops; i++) {
    sem_wait(&empty);
    put(i);
    sem_post(&full);
  }
}

void *consumer(void *arg) {
  int tmp = 0;

  while (tmp != -1) {
    sem_wait(&full);
    tmp = get();
    sem_post(&empty);
  }
}

int main(int argc, char *argv[]) {
  sem_init(&empty, 0, 1);
  sem_init(&full, 0, 0);
}
```

#### Multi-element

```c
void *producer(void *arg) {
  for (int i = 0; i < loops; i++) {
    sem_wait(&empty);
    sem_wait(&mutex);
    put(i);
    sem_post(&mutex);
    sem_post(&full);
  }
}

void *consumer(void *arg) {
  int tmp = 0;

  while (tmp != -1) {
    sem_wait(&full);
    sem_wait(&mutex);
    tmp = get();
    sem_post(&mutex);
    sem_post(&empty);
  }
}
```

#### Multiple Readers Single Writer Lock

```c
typedef struct rwlock_t {
  sem_t lock;
  sem_t writelock;
  int readers;
}

void rwlock_init(rwlock_t *rw) {
  sem_init(&rw->lock, 0, 1);       // basic lock
  sem_init(&rw->writelock, 0, 1);  // allow 1 writer and MANY readers
  rw->readers = 0;                 // # of readers in critical section
}

void rwlock_acquire_readlock(rwlock_t *rw) {
  sem_wait(&rw->lock);
  rw->readers += 1;
  if (rw->readers == 1) { // I'm the first reader? Block the writer!
    sem_wait(&rw->writelock)
  }
  sem_post(&rw->lock);
}

void rwlock_release_readlock(rwlock_t *rw) {
  sem_wait(&rw->lock);
  rw->readers -= 1;
  if (rw->readers == 0) { // I'm the last reader? Unblock the writer!
    sem_post(&rw->writelock);
  }
  sem_post(&rw->lock);
}

void rwlock_acquire_writelock(rwlock_t *rw) {
  sem_wait(&rw->writelock);
}

void rwlock_release_writelock(rwlock_t *rw) {
  sem_post(&rw->writelock);
}
```

first reader acquires the lock. In this case, the reader also acquires the write lock by calling sem_wait(rw->writelock). If a writer want to acquire the lock, it must wait until all readers are finished. In this case, the last reader will post the writelock, giving the writer the lock

## Peterson's algorithm

```c
 //'' dichiarazione delle variabili globali comuni''
 boolean flag[2] = {false, false};
 int turno;

Process CS1 {
  while(true) {
    flag[0] = true;
    turno = 1;
    while (flag[1] && turno == 1) {
      ; // spin wait
    }

    // critical section 1
    flag[0] = false;
    // end critical section 1
  }
}

Process CS2 {
  while(true) {
    flag[1] = true;
    turno = 0;
    while (flag[0] && turno == 0) {
      ; // spin wait
    }

    // critical section 2
    flag[1] = false;
    // end critical section 2
  }
}
```

## x86 xchg

```nasm

```
