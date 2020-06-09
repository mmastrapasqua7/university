## 2: relocation.py

### Example 1

```
address space: 1KB
physical memory: 16KB

base: 0x3080
limit: 472 (decimal)


V.A. 0: 0x01AE (decimal: 430)
    430 < 472, OK (VALID)
    P.A. = 0x3080 + 0x01AE = 0x3230

V.A. 2: 0x020B (decimal: 523)
    523 > 472, NOT OK (SEGMENT VIOLATION)
```

## 3: segmentation.py

### Example 1

```
address space: 1KB
physical memory: 16KB

segment 0:
    base: 0x0745
    limit: 476
    grows positive: true
segment 1:
    base: 0x154B
    limit: 387
    grows positive: false

V.A. 1: 0x0380
    address space 1KB -> 2^10, 10 bit for address
    9th bit: segment selector
    0x0380 = 0011 1000 0000
               ^---> segment 1
    address space size: 1KB = 0x0400
    0x0400 - 0x0380 = 0x0080 (decimal: 128)
    128 < 387, OK (VALID)
    P.A. = 0x154B - 0x0080 = 0x14CB

V.A. 2: 0x0167
    0x0167 = 0001 0110 0111
               ^---> segment 0
    0x167 (decimal: 359)
    359 < 476, OK (VALID)
    P.A. = 0x0745 + 0x0167 = 0x08AC
```

### Example 2 (book)

```
address space: 16KB
physical memory: 64KB

address space layout:
    code segment: base at 0KB
    heap segment: base at 4KB
    stack segment: base at 16KB

code segment:
    base: 32KB
    size: 2KB
heap segment:
    base: 34KB
    size: 3KB
stack segment:
    base: 28KB
    size: 2KB

V.A. 1: 4200 (decimal)
    offsett = 4200 - 4096 = 104
    104 < 3KB, OK (VALID)
    P.A. = 34KB + 104 = 34920
V.A. 2: 15KB
    offset = 16KB - 15KB = 1KB
    1KB < 2KB, OK (VALID)
    P.A. = 28KB - 1KB = 27KB
```

## 4: paging-linear-translate.py

### Exaple 1

```
address space: 16KB
physical memory: 64KB
page size: 4KB

PAGE TABLE:  v---> PFN
    0x8000000b
    0x8000000f
    0x8000000e
    0x00000000
      ^---> valid bit

address space 16KB -> 2^14, 14 bit address space
16KB / 4KB = 4 pages -> 2 bit VPN, 12 bit offsett
64KB / 4KB = 16 pages -> 4 bit PFN

V.A. 1: 0x1DCC
    0x1DCC -> 00001 1101 1100 1100
                 ^^---> VPN = 1 (page 1)
    page_table[1] = 0x8000000F
                      ^---> PRESENT (OK)
    P.A. = 0xF << 12 | 0x0DCC = 0xF000 | 0x0DCC = 0xFDCC

V.A. 2: 0x3C5F
    0x3C5F -> 0011 1100 0101 1111
                ^^---> VPN = 3 (page 3)
    page_table[3] = 0x00000000
                      ^---> NOT PRESENT (NOT OK)

V.A. 3: 0x2988
    0x2988 -> 0010 1001 1000 1000
                ^^---> VPN = 2 (page 2)
    page_table[2] = 0x8000000e
                      ^---> PRESENT (OK)
    P.A. = 0xE << 12 | 0x0988 = 0xE000 | 0x0988 = 0xE988
```

## 5: paging-multilevel-translate.py

### Example 1

```
page size: 32B
address space: 32KB
physical memory: 4KB

address space: 2^15 -> 15 bit address space
32KB / 32B = 1024 = 2^10 = 10 bit VPN, 5 bit offset
4KB / 32B = 128 = 2^7 = 7 bit PFN

10 bit VPN = 5 PD_INDEX, 5 PT_INDEX
PD[PD_INDEX] = PAGE_WHERE_PAGE_TABLE_RESIDES

PDBR (Page Directory Base Address = 108)

page   0: 1b 1d 05 05 1d 0b 19 00 1e 00 12 1c 19 09 19 0c 0f 0b 0a 12 18 15 17 00 10 0a 06 1c 06 05 05 14 
page   1: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page   2: 12 1b 0c 06 00 1e 04 13 0f 0b 10 02 1e 0f 00 0c 17 09 17 17 07 1e 00 1a 0f 04 08 12 08 19 06 0b 
page   3: 7f 7f 7f 7f cd 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 88 7f 7f 7f 7f 7f 7f 7f 7f b9 
page   4: 0b 04 10 04 05 1c 13 07 1b 13 1d 0e 1b 15 01 07 08 05 07 07 1b 0e 1b 04 11 00 1c 00 0c 18 1e 00 
page   5: 17 13 1d 0a 12 02 11 19 06 08 15 07 08 1d 1e 04 1b 11 01 12 13 01 17 19 02 14 0e 07 0e 04 0a 14 
page   6: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page   7: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page   8: 11 10 1a 12 0f 10 18 0a 11 15 1e 15 1d 0c 12 17 0a 08 1e 0a 1e 1a 06 19 1e 08 14 17 02 19 09 15 
page   9: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  11: 09 10 14 1d 04 01 1a 18 17 0e 15 0c 05 0c 18 18 1d 1b 15 10 16 05 1c 16 12 0d 13 13 1b 11 06 0d 
page  12: 06 0b 16 19 1c 05 14 1d 01 14 1a 0a 07 12 0d 05 0e 0c 11 0f 09 0b 19 07 11 00 16 0a 01 08 07 1d 
page  13: 19 10 0b 0e 00 06 14 14 0f 1d 0e 09 1a 08 12 15 19 18 0b 01 01 16 1d 0a 0d 16 14 08 14 09 0b 10 
page  14: 12 18 14 0b 00 0d 1c 0a 07 04 0f 10 02 0c 14 1d 0d 0d 0e 06 0c 14 0c 12 19 1e 1b 0b 00 12 0e 07 
page  15: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  16: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f ea 7f 7f 7f 
page  17: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  18: 7f 7f 7f 7f 7f 7f ab 7f 7f 7f 8e 7f 7f 7f dd 7f 7f 7f 7f 7f 7f 7f 8b 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page  19: 00 13 00 01 06 14 02 01 1e 0d 1b 06 0d 0b 05 0a 1e 17 0b 0c 08 10 16 15 0e 01 1c 0c 0c 00 04 1a 
page  20: 1a 19 04 02 02 0c 1d 11 08 07 03 04 19 04 1a 19 04 11 00 1a 11 17 0f 15 1c 11 1b 0a 03 00 07 19 
page  21: 0b 08 1b 0e 1c 15 1e 12 1e 05 0d 11 1e 11 1a 13 0f 0c 0b 09 06 1d 10 1a 1b 1d 07 0a 13 09 04 17 
page  22: 12 12 15 0f 08 1b 0a 0e 13 0f 1d 1d 1c 1c 12 0f 15 06 08 01 05 00 14 04 18 15 1e 0c 1c 0e 0a 03 
page  23: 1d 0f 03 0b 0c 0f 1e 1e 11 13 14 0f 0f 09 15 02 09 1b 07 1d 1e 11 01 02 06 0a 03 18 0b 07 01 0b 
page  24: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  25: 03 03 1c 03 1b 0e 0e 0a 0c 0b 11 0a 19 07 07 0e 1c 00 16 00 0c 17 0d 0d 07 0e 07 08 14 12 1c 1e 
page  26: 09 0e 1d 18 08 11 15 18 0d 0c 17 0d 07 0e 1d 04 0e 13 0e 06 00 15 13 00 09 17 13 10 04 15 0e 15 
page  27: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  28: 0f 1d 0f 0a 02 11 07 0b 0b 17 07 1d 17 0e 1b 0b 0b 04 18 0c 0f 0e 14 0b 1c 0d 0b 0c 17 1e 1a 0e 
page  29: 17 08 1e 03 1b 01 07 10 12 0c 03 07 08 17 1c 12 01 18 09 0a 10 07 1c 05 0c 08 10 11 13 10 0c 13 
page  30: 7f 7f 7f 7f 7f 84 7f 7f 7f 7f 97 7f bd 7f 7f f4 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 9c 7f 
page  31: 7f 7f 7f 7f 7f 7f d0 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page  32: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  33: 7f 7f 7f 7f 7f 7f 7f 7f b5 7f 9d 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f f6 b1 7f 7f 7f 7f 
page  34: 04 13 05 0d 0c 02 16 15 18 10 11 05 06 07 10 19 0b 1b 16 16 0a 03 1d 1a 0c 1a 1b 0a 0f 0a 15 1c 
page  35: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  36: 1d 13 13 16 0c 0c 14 00 05 0a 07 13 0b 1b 11 0c 0c 15 0c 14 01 0d 08 04 10 0f 11 17 1b 0f 09 0e 
page  37: 1e 0f 0a 0d 0c 10 0c 02 1e 1e 05 07 0d 15 00 19 13 08 1a 14 09 10 1e 01 15 1a 15 04 12 18 0c 12 
page  38: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  39: 1b 11 1e 17 11 08 15 0e 16 0c 0f 00 16 01 15 12 18 08 15 06 10 0a 1e 1e 06 11 0a 1e 1c 12 16 15 
page  40: 0d 03 0b 10 07 19 0b 07 09 19 1c 1d 00 17 10 03 07 08 0c 0e 1d 01 15 1a 0b 07 06 09 04 11 07 00 
page  41: 7f 7f 7f 7f 7f 7f 7f 7f e5 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 8d 7f 7f 7f 7f 7f 
page  42: 03 04 15 01 11 1c 10 15 00 13 12 11 0c 0b 1e 01 00 1d 05 03 06 18 1d 00 0d 03 08 06 14 0a 05 0f 
page  43: 19 08 02 04 13 11 01 1e 0e 09 16 00 0d 14 1d 17 1b 03 0d 00 08 0b 0a 0b 18 05 19 10 0a 11 05 0f 
page  44: 7f 7f 7f 7f 7f 7f cc 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f a2 7f 7f 7f 7f 7f 7f 
page  45: 7f b2 7f ef 7f 7f 7f 7f a4 f5 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page  46: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  47: 07 0a 0f 10 02 09 0b 0c 0e 0d 02 06 13 19 0f 04 02 04 0b 11 14 10 11 0a 14 16 0c 19 17 1c 0e 0a 
page  48: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  49: 1e 0a 0f 07 02 03 0d 13 10 10 03 01 0b 1d 05 08 0e 1c 1d 00 14 07 14 17 1b 15 1a 18 04 01 16 10 
page  50: 16 1b 04 07 06 01 1a 0f 02 0d 0d 18 17 04 13 0f 00 04 14 0b 1d 0f 15 04 0e 16 19 06 0c 0e 0d 0e 
page  51: 14 00 0f 1a 07 0a 1a 05 11 07 1d 18 0d 02 09 0f 1c 03 11 15 10 19 10 1d 12 12 0d 12 0b 11 09 05 
page  52: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  53: 0f 0c 18 09 0e 12 1c 0f 08 17 13 07 1c 1e 19 1b 09 16 1b 15 0e 03 0d 12 1c 1d 0e 1a 08 18 11 00 
page  54: 19 01 05 0f 03 1b 1c 09 0d 11 08 10 06 09 0d 12 10 08 07 03 18 03 16 07 08 16 14 16 0f 1a 03 14 
page  55: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  56: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  57: 1c 1d 16 02 02 0b 00 0a 00 1e 19 02 1b 06 06 14 1d 03 00 0b 00 12 1a 05 03 0a 1d 04 1d 0b 0e 09 
page  58: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  59: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  61: 01 05 10 02 0c 0a 0c 03 1c 0e 1a 1e 0a 0e 15 0d 09 16 1b 1c 13 0b 1e 13 02 02 17 01 00 0c 10 0d 
page  62: 7f 7f 7f a8 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page  63: 06 12 06 0a 1d 1b 19 01 04 07 18 1a 12 16 19 02 02 1a 01 06 01 00 1a 0a 04 04 14 1e 0f 1b 0f 11 
page  64: 18 12 17 08 08 0d 1e 16 1d 10 11 1e 05 18 18 1a 17 04 14 1c 11 0b 1d 11 0c 13 18 07 00 10 1d 15 
page  65: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 99 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page  66: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f d7 7f 7f 
page  67: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  68: 12 12 16 02 0f 06 0c 0f 0a 0c 16 01 1d 12 05 11 02 0f 15 0d 09 14 1c 1b 0b 1a 03 01 1e 17 13 11 
page  69: 19 0a 19 02 0d 0a 0d 19 0f 1e 1a 03 09 00 16 00 1b 05 0c 01 09 0c 01 17 16 0b 19 02 01 0b 1b 17 
page  70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  71: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 85 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page  72: 18 0c 00 18 05 0c 0b 03 0a 05 13 14 00 0e 11 1b 0f 02 01 1a 18 1a 08 14 02 19 0a 1d 0e 01 1c 13 
page  73: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  74: 0d 0b 1e 08 18 0d 0b 01 1a 15 1b 0d 14 03 0c 06 01 1d 06 04 06 0b 10 04 1e 1e 04 0c 15 1b 0f 1c 
page  75: 1a 1c 01 1b 00 14 1c 0f 0c 0a 1c 1c 13 16 0a 04 1e 14 08 1e 12 0a 1b 02 18 04 03 08 16 12 0d 04 
page  76: 0c 11 15 0c 1b 1d 1e 01 19 1b 04 1d 03 06 1d 19 11 08 07 0c 00 13 01 17 02 00 08 17 19 0f 1d 03 
page  77: 1c 06 16 06 00 1b 1a 02 05 07 1c 0b 19 0d 0b 17 13 08 12 15 19 14 13 12 02 1d 16 08 15 13 14 0b 
page  78: 0e 02 17 1b 1c 1a 1b 1c 10 0c 15 08 19 1a 1b 12 1d 11 0d 14 1e 1c 18 02 12 0f 13 1a 07 16 03 06 
page  79: 1e 1b 15 16 07 17 08 03 0e 0a 05 0d 1b 0d 0d 15 10 04 1c 0d 18 0c 19 0c 06 06 1d 12 01 0c 07 02 
page  80: 1b 08 1d 1c 02 0d 17 0d 0f 19 15 1d 05 1c 1c 13 1d 07 1b 17 12 02 00 00 07 17 0b 18 13 0c 1b 01 
page  81: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f e2 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f fa 
page  82: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  83: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  84: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 94 7f 7f 7f 7f 7f ce 
page  85: 7f 7f 7f 7f 7f 7f 7f 7f 9a 7f bf 7f 7f 7f 7f 7f 7f 7f 7f 7f af 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page  86: 7f 7f 7f 7f 7f 7f 7f c5 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f ca 7f 7f ee 7f 7f 7f 7f 7f 7f 7f 7f 
page  87: 18 05 18 0d 17 0e 18 02 01 1c 0f 1b 1d 14 11 06 02 19 1b 18 15 0d 09 03 0d 11 1c 1d 0c 03 17 16 
page  88: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f c4 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page  89: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  90: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f c0 7f 7f 7f 7f 7f 7f 7f 7f de 7f 7f 7f 7f 7f 7f 
page  91: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f a5 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page  92: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page  93: 0a 1a 19 07 00 19 05 18 15 05 02 1c 12 13 0e 04 12 07 18 16 00 1c 01 02 09 04 07 0b 16 0c 08 0f 
page  94: 14 06 19 07 10 14 07 13 08 05 19 11 0a 12 00 04 0c 1e 0f 02 17 18 18 11 15 06 16 19 17 0a 12 13 
page  95: 0a 1d 0f 1d 1e 19 15 04 00 12 15 1d 10 15 14 06 13 1e 03 15 13 0b 18 00 1b 19 0e 03 0e 12 07 0f 
page  96: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f b6 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page  97: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f c8 7f 7f 7f 7f 7f e7 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page  98: 15 19 18 03 17 1a 17 0e 15 03 17 08 18 13 0f 10 02 01 00 18 04 03 0b 1e 1b 09 19 02 0c 11 1e 01 
page  99: 09 0b 13 04 15 0b 12 04 14 0a 0e 0c 0e 15 09 14 01 09 17 01 13 00 0e 1b 00 10 02 1a 15 17 14 00 
page 100: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f a7 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f e3 7f 7f 
page 101: 0e 0a 00 01 0b 06 10 05 06 14 16 09 1a 07 0a 16 01 1c 02 0e 16 01 19 1e 0e 03 02 03 17 0c 1c 0d 
page 102: 1d 03 1b 01 16 00 0d 1a 0c 1c 16 12 05 0a 0c 12 1e 08 0f 1c 0a 13 17 13 17 06 1d 05 12 09 13 09 
page 103: 1e 17 1c 06 10 12 19 0e 18 0c 12 1a 18 14 00 05 0f 07 02 1a 1d 09 0c 19 01 13 03 08 19 01 01 0c 
page 104: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 80 aa 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f f0 7f 7f 7f 
page 105: b3 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 93 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page 106: 16 0a 00 0e 10 01 11 0a 00 05 03 10 01 1c 1a 1d 09 1c 1e 17 08 14 12 0c 09 01 03 04 0e 13 17 01 
page 107: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f f1 7f 7f 7f 7f 7f 7f 7f 7f 7f f3 7f 7f 7f 7f 7f 7f 7f 
page 108: 83 fe e0 da 7f d4 7f eb be 9e d5 ad e4 ac 90 d6 92 d8 c1 f8 9f e1 ed e9 a1 e8 c7 c2 a9 d1 db ff 
page 109: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 82 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page 110: 16 14 04 1e 0c 12 0b 01 0e 04 01 13 13 03 11 0a 0b 18 0f 1b 12 0e 13 0a 03 15 13 18 03 1c 18 1c 
page 111: 08 00 01 15 11 1d 1d 1c 01 17 15 14 16 1b 13 0b 10 06 12 00 04 0a 18 16 0a 13 01 05 1e 08 0c 11 
page 112: 19 05 1e 13 02 16 1e 0c 15 09 06 16 00 19 10 03 03 14 1b 08 1e 03 1a 0c 02 08 0e 18 1a 04 10 14 
page 113: 1d 07 11 1b 12 05 07 1e 09 1a 18 17 16 18 1a 01 05 0f 06 10 0f 03 02 00 19 02 1d 1e 17 0d 08 0c 
page 114: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page 115: 11 06 01 04 0d 14 06 15 1a 17 0d 14 1e 1b 0a 15 05 11 0b 0d 0d 14 1a 0e 04 17 17 1d 0c 0e 10 1b 
page 116: 0a 13 0b 11 15 0f 14 17 1a 05 06 0f 0f 19 10 1b 18 0f 19 0e 0a 0d 0e 14 01 16 1e 0e 02 06 03 07 
page 117: 1b 0a 17 00 19 11 1d 0b 13 0a 18 12 1e 00 04 01 03 1c 1d 0e 1d 19 18 17 05 11 0d 1d 05 05 14 04 
page 118: 11 19 02 1a 1c 05 19 1a 1b 10 12 06 15 0c 00 04 0c 1b 11 1c 1c 02 12 0a 0f 0e 0e 03 19 0f 13 0e 
page 119: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page 120: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f cb 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 
page 121: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page 122: 05 1e 03 12 04 1b 1d 18 09 07 17 09 0d 01 04 00 02 02 0d 11 16 04 0d 13 02 0d 0b 1d 01 0c 0c 16 
page 123: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page 124: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page 125: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
page 126: 7f 7f 7f 7f 7f 7f 7f 7f 8c e6 cf 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 96 7f 7f 7f 7f 7f 
page 127: 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f df 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 7f 95 7f 7f

V.A. 1: 0x611C
    0x611C -> 0110 0001 0001 1100
               ^^^ ^^---> PD_INDEX = 0x18 = 24
                     ^^ ^^^---> PT_INDEX = 0x8 = 8
                           ^ ^^^^---> OFFSET = 0x1C = 28
    PDE = PDBR[24] = 0xA1

    0xA1 = 1010 0001
           ^---> VALID
            ^^^ ^^^^---> PFN = 0x21 = 33 = PT_ADDRESS

    PTE = PT_ADDRESS[8] = 0xB5

    0xB5 = 1011 0101
           ^---> VALID
            ^^^ ^^^^---> PFN = 0x35 = 53

    P.A. = PFN << 5 | OFFSET = 0x35 << 5 | 0x1C =
         = 0011 0101 << 5 | 0001 1100 = 0110 1010 0000 | 0001 1100 =
         = 0110 1011 1100 = 0x6BC

    0x6BC = 0110 1011 1100
            ^^^^ ^^^---> PAGE = 53
                    ^ ^^^^---> OFFSET = 28

    VALUE = 53[28] = 0x08 = 8

v.A. 2: 0x3DA8
    0x3DA8 = 0011 1101 1010 1000
              ^^^ ^^---> PDE_INDEX = 15
                    ^^ ^^^---> PTE_INDEX = 13
                          ^ ^^^^---> OFFSET = 8

    PDE = PDBR[15] = 0xD6

    0xD6 = 1101 0110
           ^---> VALID
            ^^^ ^^^^---> PFN = 0x56 = 86 = PTE_ADDRESS

    PTE = PTE_ADDRESS[13] = 0x7F

    0x7F = 0111 1111
           ^---> INVALID

V.A. 3: 0x17F5
    0x17F5 = 0001 0111 1111 0101
              ^^^ ^^---> PDE_INDEX = 5
                    ^^ ^^^---> PTE_INDEX = 31
                          ^ ^^^^---> OFFSET = 21

    PDE = PDBR[5] = 0xD4

    0xD4 = 1101 0100
           ^---> VALID
            ^^^ ^^^^---> PFN = 0x54 = 84 = PTE_ADDRESS

    PTE = PTE_ADDRESS[31] = 0xCE

    0xCE = 1100 1110
           ^---> VALID
            ^^^ ^^^^---> PFN
    
    P.A. = 0100 1110 << 5 | 0001 0101 = 1001 1100 0000 | 0001 0101 =
         = 1001 1101 0101 = 0x9D5

    0x9D5 = 1001 1101 0101
            ^^^^ ^^^---> PFN = 78
                    ^ ^^^^---> OFFSET = 21

    VALUE = 78[21] = 0x1C
```

## 6: disk.py

### Example 1

```
FIFO
Seek Time Between Tracks: 40
Rotation Time: 360 (degree) per round
Sectors per Track: 12 (30 degree from one another)

REQUESTS ['10', '9', '13']

SECTOR 10: seek 0, rotation 105, transfer 30, total 135
SECTOR 9: seek 0, rotation 300, transfer 30, total  330
SECTOR 13: seek 40, rotation 50, transfer 30, total 120
                                               toal 585
```

### Example 2

```
SSTF

REQUESTS ['10', '6', '13']

SECTOR 10: seek 0, rotation 105, transfer 30, total  135
SECTOR 6: seek 0, rotation 210, transfer 30, total   240
SECTOR 13: seek 40, rotation 140, transfer 30, total 210
                                               total 585
```

```
SSTF

REQUESTS ['10', '9', '13']

SECTOR 9: (SSTF orders the requests)
SECTOR 10:
SECTOR 13:
```

### Example 3

```
SATF

REQUESTS ['10', '6', '13']

SECTOR 10: seek 0, rotation 105, transfer 30, total 135
SECTOR 13: seek 40, rotation 20, transfer 30, total  90
SECTOR 6: seek 40, rotation 80, transfer 30, total  150
                                             total  375
```

## 7: vsfs.py

## Example 1

```
inode bitmap  10000000
inodes        [d a:0 r:2] [] [] [] [] [] [] [] 
data bitmap   10000000
data          [(.,0) (..,0)] [] [] [] [] [] [] [] 

===== INITIAL STATE =====
a root directory / with only . and .. dir. Ref. count = 2

inode bitmap  11000000
inodes        [d a:0 r:3] [d a:1 r:2] [] [] [] [] [] [] 
data bitmap   11000000
data          [(.,0) (..,0) (g,1)] [(.,1) (..,0)] [] [] [] [] [] [] 

Which operation took place?
mkdir("/g"), new directory in / with inode 1 and data block 1

inode bitmap  11100000
inodes        [d a:0 r:3] [d a:1 r:2] [f a:-1 r:1] [] [] [] [] [] 
data bitmap   11000000
data          [(.,0) (..,0) (g,1) (q,2)] [(.,1) (..,0)] [] [] [] [] [] [] 

Which operation took place?
open("/q"), new empty file in / with inode 2

inode bitmap  11110000
inodes        [d a:0 r:3] [d a:1 r:2] [f a:-1 r:1] [f a:-1 r:1] [] [] [] [] 
data bitmap   11000000
data          [(.,0) (..,0) (g,1) (q,2) (u,3)] [(.,1) (..,0)] [] [] [] [] [] [] 

Which operation took place?
open("/u"), new empty file in / with inode 3

inode bitmap  11110000
inodes        [d a:0 r:3] [d a:1 r:2] [f a:-1 r:1] [f a:-1 r:2] [] [] [] [] 
data bitmap   11000000
data          [(.,0) (..,0) (g,1) (q,2) (u,3) (x,3)] [(.,1) (..,0)] [] [] [] [] [] [] 

Which operation took place?
hard_link("/u", "/x")

inode bitmap  11111000
inodes        [d a:0 r:4] [d a:1 r:2] [f a:-1 r:1] [f a:-1 r:2] [d a:2 r:2] [] [] [] 
data bitmap   11100000
data          [(.,0) (..,0) (g,1) (q,2) (u,3) (x,3) (t,4)] [(.,1) (..,0)] [(.,4) (..,0)] [] [] [] [] [] 

Which operation took place?
mkdir("/t"), new directory in / with inode 4 and data block 2

inode bitmap  11111100
inodes        [d a:0 r:4] [d a:1 r:2] [f a:-1 r:1] [f a:-1 r:2] [d a:2 r:2] [f a:-1 r:1] [] [] 
data bitmap   11100000
data          [(.,0) (..,0) (g,1) (q,2) (u,3) (x,3) (t,4)] [(.,1) (..,0) (c,5)] [(.,4) (..,0)] [] [] [] [] []

Which operation took place?
open("/g/c"), new empty file in /g with inode 5
```
