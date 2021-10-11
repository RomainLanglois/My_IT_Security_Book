## LDAP Enumeration

### NMAP (NSE scripts)
```bash
nmap -p 389 --script ldap-search 10.10.10.119
```

### Note :
- port 389 : LDAP en clair
- port 636 : LDAP en chiffré

### GUI
- https://directory.apache.org/

### Command Line
```bash
# -x: simple authentification
- ldapsearch -h 10.10.10.10 -x

# Give you the root tree name
- ldapsearch -h 10.10.10.10 -x -s base namingcontexts

# All ldap informations we can query
- ldapsearch -h 10.10.10.10 -x -b "DC=HTB,DC=local"

# Dump all informations related to people
# Look for password informations:
  # whenCreated
  # pwdLastSet (google: windows timestamp to human) -> windows timestamp is weird
  # sAMAccountName
- ldapsearch -h 10.10.10.10 -x -b "DC=HTB,DC=local" '(objectClass=Person)'

# Get the usernames store inside the ldap server
- ldapsearch -h 10.10.10.10 -x -b "DC=HTB,DC=local" '(objectClass=Person)' sAMAccountName | grep sAMAccountName
 ```