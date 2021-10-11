   
## SSH (Linux / Windows):
Note :  it is possible to execute SSH forwarding commands by taping : "Enter" THEN "~C"
### Local:
```bash 
# -f : Put the process in foreground
# -N : No command are executed, usefull for port forwarding
ssh -L sourcePort:forwardToHost:onPort connectToHost -f -N

ssh -L 10000:192.168.1.1:445 test@192.168.1.10  
```

![[SSH_local_port_forwarding.png]]

### Remote:
```bash 
ssh -R sourcePort:forwardToHost:onPort connectToHost

ssh -R 10000:192.168.1.1:445 test@192.168.1.10  
```

![[SSH_remote_port_forwarding.png]]


### Proxy chains:  
Important link:  
* [https://netsec.ws/?p=278](https://netsec.ws/?p=278)  
  
Commands:  
```bash
ssh -f -N -D 9050 test@192.168.1.1
```

![[SSH_Proxy_chains.png]]