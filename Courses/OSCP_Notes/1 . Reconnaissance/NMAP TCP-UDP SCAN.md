## Ping Sweep :
```bash 
nmap -sn 10.10.10.0/24 -oN ping_sweep.txt  
```

## TCP Scan :
Look and scan for all opened TCP ports : 
```bash
ports=$(nmap -p- --min-rate=1000 -T4 10.10.10.27 | grep ^\[0-9\] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//)

nmap -sC -sV -O -p$ports 10.10.10.27 -oN nmap_allports.txt  
```



## UDP Scan :
```bash
nmap --reason -sU -A --top-ports=20 --version-all 192.168.115.132 -oN nmap_UDP_scan.txt
```