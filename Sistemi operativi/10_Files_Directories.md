## Files and Directories

### File

#### Facts

- they are managed inside the OS by **file descriptors**, pointers to file objects. A file descriptor is **private per process**.

- Read to files can be issued sequentially or at random. In fact, every file object has an **offset**. This offset can be incremented implicitly (sequential read) or explicitly (```lseek()```). 

- **rename** of a file is atomic

- to guarantee that ```fsync()``` empties the buffer and effectively write to disk, you have also to ```fsync()``` the directory that contains the file

- every file has a **reference count**

### Hard Links

simply creates **another name in the directory** (**DOES NOT ALLOCATE ANY NEW FILE NOT INODE**) but refers to **the same inode number** of the file hardlinked. The file, so the content, is not copied. It's simply a second human-readable name for the same inode, thus underlying content. ```link()```

#### Facts

- when removing a file, the OS will simply call the function ```unlink()``` that decrements the reference count of the file. If this count reaches 0, it will be deleted

cons:

- can't refers to files in other disk partitions

### Symbolic Links

**it is actually a new file,** but of different type. The size of this file depends on the name of the link. So, the actual data inside a file of type symbolic link is the string of the path to the linked file

### Directory

you can never write to a directory directly: its is considered file system metadata, thus the OS is considered responsible for the integrity of directories

## File System Implementation

### CONSTRUCTION

suppose we have a disk

- N blocks (0 through N - 1)
  
  - 64 blocks in this example

- each block of size 4KB

we use 56 blocks for **pure data blocks**.

- 56 data blocks, each of 4KB in size

we assume 256 bytes per-**inode**

- a block can hold 16 inodes

we reserve 5 blocks for inodes

- thus, our system has 80 inodes (5 \* 16 inodes), which is the maximum number of files for this partition

we reserve 2 block for **inode bitmap** and **data bitmap**

- 1 block can track 4KB * 8bit = 32K blocks

last block is reserved for a **superblock** which contains metadata informations like

- special number to identify the file system type

- where the inode table begins

- how many inodes are in the system

- how many data blocks are in the system

### FILE (INODE)

to read the inode number 32 for example, we calculate the address with:

```c
phys_addr = inode_start_addr + (sizeof(inode_struct) * inode_number);
sector_to_read = phys_addr / sector_size
inode = readsect(sector_to_read)
```

#### Indirect Blocks

assuming 4B per pointer to block in the disk:

- 12 direct pointers to data blocks

- 1 indirect pointer
  
  - points to a block that contains more direct pointers (1024 pointers).
    
    with a direct pointer, you can point 1 block of 4KB. With an indirect pointer, you can have (4KB / 4B) pointers, so 1024 pointers to data blocks, for a total of 4MB

- 1 double indirect pointer
  
  - points to a block that contains more indirect pointers (1024 indirect pointers)
    
    can address up to: 1024 indirect pointers \* 1024 pointers = 1024 indirect pointers \* 4MB = 4GB

- 1 triple indirect pointer
  
  - point to a block that contains more double pointers (1024 double pointers)
    
    can address up to: 1024 double indirect pointers \* 1024 indirect pointers = 1024 indirect pointers \* 4GB = 4TB

MAXIMUM FILE SIZE:

- (12 \* 4KB) + 4MB + 4GB + 4TB ~= 4TB

### DIRECTORY

a directory is a file that contains, inside the data block, a list of (entry_name, inode_number) pairs. For each file or directory inside a given directory, there is a string and a number in the data block(s) of the directory. For each string there may also be a length

## READING FILE FROM DISK

the root directory (/) is a well-known inode-number. In UNIX the root inode is always 2

How to **open and read** 12KB (3 blocks) of  ```/foo/bar``` file

**OPEN**

1. read **root inode** (dir)

2. read **root data**

3. read **foo inode** (dir)

4. read **foo data**

5. read **bar inode** (dir)

**READ**

1. read **bar inode**
   
   1. read **bar data[0]**
   
   2. write back **bar access time to inode**

2. read **bar inode**
   
   1. read **bar data[1]**
   
   2. write back **bar access time to inode**

3. read **bar inode**
   
   1. read **bar data[2]**
   
   2. write back **bar access time to inode**

## WRITING FILE TO DISK

How to **create and write** 12KB (3 blocks) of ```/foo/bar``` file

**CREATE**

1. read **root inode** (dir)

2. read **root data**

3. read **foo inode** (dir)

4. read **foo data**

5. read **inode bitmap**

6. write **inode bitmap** (allocate file)

7. write **foo data** (add (name, inode) pair of the newly created file bar to the /foo dir)

8. read **bar inode** (initialize inode)

9. write **bar inode**

10. write **foo inode** (update size of directory)

**WRITE**

1. read **bar inode**

2. read **data bitmap** (find space for file)

3. write **data bitmap** (update)

4. write **bar data** ("ciao come stai?")

5. write **bar inode** (update block, size and access)
