# Methodology to reverse an ELF file
## Basics commands
```bash
file $filename
strings $filename
```

## Hexadecimal editor (Patching)
- ImHex 
	- https://github.com/WerWolv/ImHex
- wxHexEditor
- xxd

## CMD disassembly
```bash
objdump -d $filename
```

## Hashing
```bash
md5sum $filename
sha256sum $filename
```

## Convert hexadecimal to decimal
##### bash
```bash
echo $$((0xdeadbeef))
```
##### python
```bash
┌──(romain㉿fedora)-[~/Documents/RE/Crackme/MBE]
└─$ python  
Python 3.9.9 (main, Nov 19 2021, 00:00:00) 
[GCC 11.2.1 20210728 (Red Hat 11.2.1-1)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> 0x10
16
>>> 
```

