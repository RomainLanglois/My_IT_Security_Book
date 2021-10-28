# Basics about the ELF format
ELF : Executable and Linkable Format
Runs on Unix, Linux, BDS, PS4, WiiU and many more

## What ELF can be used for
- Executable
- Shared library
- Object file
- Core dumps
- etc...

## Segments and Sections
Each ELF can be composed of zero or more Segments / Sections
- Segments are only relevant at runtime
- Sections are only relevant at link time
- An ELF executable can only contain segments while an Object file can only contain sections

#### Other big difference
Segments also specify where and how they should be loaded in Virtual / Physical memory

## Example 
The red cross is the position of the main function
#### Static link binary
![[Pasted image 20211011164319.png]]

#### Dynamically linked binary
![[Pasted image 20211011164503.png]]