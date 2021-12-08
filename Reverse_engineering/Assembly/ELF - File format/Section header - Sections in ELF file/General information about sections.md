# Sections in ELF file
Each section is defined by a section header
![[ELF_File_Sections_Header_&_Sections.png]]

## Section header
1.  Specify location the program header table (e_shoff)
2.  Specify the size of each program header (e_shentsize)
3.  Specify the number of program header (e_shnum)

![[ELF_File_Section_Headers.png]]

## Important note
Sections are not necessary to run a program. They are used to debug.
```bash
┌──(romain㉿fedora)-[~/Téléchargements]
└─$ readelf --sections /bin/ls                                                                                   
Il y a 31 en-têtes de section, débutant à l'adresse de décalage 0x22308:

En-têtes de section :
  [Nr] Nom               Type             Adresse           Décalage
       Taille            TaillEntrée      Fanion Lien  Info  Alignement
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .interp           PROGBITS         0000000000000318  00000318
       000000000000001c  0000000000000000   A       0     0     1
  [ 2] .note.gnu.pr[...] NOTE             0000000000000338  00000338
       0000000000000030  0000000000000000   A       0     0     8
  [ 3] .note.gnu.bu[...] NOTE             0000000000000368  00000368
       0000000000000024  0000000000000000   A       0     0     4

ETC .....
```