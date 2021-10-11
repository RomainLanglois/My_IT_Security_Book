# JohnTheRipper usage
## List of hash formats for john
- http://pentestmonkey.net/cheat-sheet/john-the-ripper-hash-formats

## Cracking linux passwords
```bash
unshadow /etc/passwd /etc/shadow > pass.txt
john pass.txt 
```

## Cracking MD5 hashes using John and rockyou.txt
```bash
john --format=raw-md5 --wordlist=/usr/share/wordlists/rockyou.txt hash.txt
```

## John Benchmark
```bash
john --test
```

## Cracking an encrypted SSH key
1) Find the converter
```bash
# In general, everything is in 
/usr/share/john
# Example
locate ssh2john.py
```
2) We convert SSH key to a format John can understand
```bash
# Usage: /usr/share/john/ssh2john.py <RSA/DSA/EC/OpenSSH private key file(s)>
python /usr/share/john/ssh2john.py <SSH_key_file>
```

3) We use john to crack the password
```powershell
# Be carefull, for whatever reason on Windows, the wordlist and the file to crack need to be in the same directory
john.exe --wordlist=rockyou.txt matt_ssh_key.txt
```

## Note :
Cracked passwords can be found inside the following file 
- /home/[nom_utilisateur]/.john/john.pot