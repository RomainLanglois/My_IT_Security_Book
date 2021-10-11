# Drupal Enumeration

## Checks
- Look for exploit using the version number
- launch a Droopscan
	- Look for plugins vulnerability
- Try credentials and if possible connect as an admin
	- Inject PHP code inside a template to get code execution

## Get Drupal version
- The drupal version can be found inside the following file CHANGELOG.txt

## Droopscan's Github
- https://github.com/droope/droopescan 

#### Command
```bash
droopescan scan drupal -u http://10.11.1.50/
```

## Getting code execution
1. Activate the PHP module
	- Click on "Modules"
	- Check if the "PHP filter" is enabled
2. Insert malicious PHP code
	- Click on "Add new content"
	- Click on "Basic page"
	- Insert the PHP code inside the Body of the page
	- Access the web page to get code execution