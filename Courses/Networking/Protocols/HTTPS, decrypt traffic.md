## Wireshark decrypt TLS/SSL traffic using the private key
1. Edit > Preferences > Protocols > TLS >  RSA Keys list [EDIT]

![[Decrypting TLS fist step.png]]

2. Enter the necessary information
	* IP Address: 127.0.0.1
	* Port: start_tls
	* Protocol: http
	* Keyfile: RSA key location

![[Decrypting TLS second step.png]]