## Using socat:
* [https://www.cyberciti.biz/faq/linux-unix-tcp-port-forwarding/](https://www.cyberciti.biz/faq/linux-unix-tcp-port-forwarding/)  

Command:  
```bash
socat TCP-LISTEN:4444,fork TCP:127.0.0.1:8080 &  
```

### Proxychains:
* [https://phackt.com/tor-proxychains](https://phackt.com/tor-proxychains)  
* [https://online-it.nu/how-to-use-proxychains-kali-linux/](https://online-it.nu/how-to-use-proxychains-kali-linux/)  
  
  
Note:  
* A pretty interesting point, I saw, on the “Servmon” video from Ippsec. Even if a web application is accessible, sometimes it is impossible to connect to it. Even with the right password. However, it is possible to use SSH forwarding (or other kind of forwarding like chisel) to make the authentication process works.