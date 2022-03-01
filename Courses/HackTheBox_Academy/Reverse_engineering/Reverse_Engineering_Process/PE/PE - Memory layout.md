# PE - Memory layout
- Stack - region of memory is added or removed using "last-in-first-out" (LIFO) procedure
- Heap - region for dynamic memoru allocation
- Program Image - The PE executable code placed into memory
- DLLs - Loaded DLL images that are referenced by the PE
- TEB - Thread Environment Block stores information about the current running thread(s)
	- TODO : add link (malware unicorn)
- PEB - Process Environment Black stores information about loaded modules and processes
	- TODO : add link (malware unicorn)


## Schema to resume 
![[PE_memory_map.png]]