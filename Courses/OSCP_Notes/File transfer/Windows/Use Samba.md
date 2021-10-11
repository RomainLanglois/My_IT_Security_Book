## Goal
- The main idea is find a way around the problems of rights when a Windows 10 box is trying to access a SMB share on the kali box

## Configuration (Kali Linux)
- /etc/samba/smb.conf
```bash
[SHARE]
path = /srv/samba/
browseable = yes
read only = no
create mask = 777
guest ok = yes
force user = nobody
force group = nogroup
```
### Note
- The user "nobody" must have all access on those folders/files

## Start the services (Kali Linux)
```bash
sudo service smbd restart
sudo service nmbd restart
```

## Access the SMB share from Windows
```powershell
copy \\10.10.14.6\share\test.txt c:\windows\temp\test.txt
```