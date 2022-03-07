# PE - MISC
## Import
- KERNEL32.dll -> Handles memory management, input/output operations and interrupts
- msvcrt.dll -> DLL containing C library function (e.g. printf, memcpy, etc.) 
- ntdll.dll -> DLL containing NT system functions 

## Sections
- .text -> Contains the executable code of the program
- .data -> Contains the initialized data 
- .rdata -> Contains read-only initialized data
- .edata -> Contains the export tables
- .idata ->  Contains the import tables
- .reloc -> Contains image relocation information
- .bss -> Contains uninitialized data
- .rsrc -> Contains resources used by the program, these include images, icons or even embeded librairies
- .tls (Thread Local Storage) -> Provides storage for every executing thread of the program