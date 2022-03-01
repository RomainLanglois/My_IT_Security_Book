# Segments in ELF file
Each segment is defined by a program header

![[ELF_File_Program_Header_&_Segments.png]]


## Program header
1. Specify location the program header table (e_phoff)
2. Specify the size of each program header (e_phentsize)
3. Specify the number of program header (e_phnum)

![[ELF_File_Program_Header.png]]

## Read all program segments
```bash
┌──(romain㉿fedora)-[~/Téléchargements]
└─$ readelf --segments /bin/ls | more

Type de fichier ELF est DYN (fichier objet partagé)
Point d'entrée 0x6b10
Il y a 13 en-têtes de programme, débutant à l'adresse de décalage 64

En-têtes de programme :
  Type           Décalage           Adr.virt           Adr.phys.
                 Taille fichier     Taille mémoire      Fanion Alignement
  PHDR           0x0000000000000040 0x0000000000000040 0x0000000000000040
                 0x00000000000002d8 0x00000000000002d8  R      0x8
  INTERP         0x0000000000000318 0x0000000000000318 0x0000000000000318
                 0x000000000000001c 0x000000000000001c  R      0x1
      [Réquisition de l'interpréteur de programme: /lib64/ld-linux-x86-64.so.2]
  LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x00000000000034f8 0x00000000000034f8  R      0x1000
  LOAD           0x0000000000004000 0x0000000000004000 0x0000000000004000
                 0x00000000000131b1 0x00000000000131b1  R E    0x1000
  LOAD           0x0000000000018000 0x0000000000018000 0x0000000000018000
  
 ETC ....
```