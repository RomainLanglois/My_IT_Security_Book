 # DNS Enumeration
  
## Checks
- Try zone transfer
- Brute force subdomains

## Commands
do DNS lookup specifying the DNS server
```bash
nslookup
# Set nameserver to ip of box
>  server 10.10.10.13
# Ask for dns of box ip address
>  10.10.10.13
```

subdomain enumeration / brute force
```bash
# AXFR Zone transfer
dnsrecon -d <dns_server> -r <range_to_recon>  
dig axfr @$ip test.htb
host -l <domain_name> 10.10.10.10

# Subdomain Brute Force
fierce -dns ext.recon.lan -dnsserver 172.16.90.53
gobuster dns -d <domain_name> -r 172.16.90.53 -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt
gobuster dns -d google.com -w ~/wordlists/subdomains.txt
```

## Scripts
```bash
# Make a DNS reverse lookup
for ip in {1..255}; do host 10.11.1.$ip 10.11.1.220; done | grep "domain name"
```