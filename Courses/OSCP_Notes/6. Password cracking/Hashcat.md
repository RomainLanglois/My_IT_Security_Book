# Hashcat usage
## Hashcat password examples
- https://hashcat.net/wiki/doku.php?id=example_hashes

## Hashcat basic commands
```bash
# hashcat skeleton
.\hashcat -m <Hash-mode> <files_holding_hashes> <wordlist>
# Example
.\hashcat.exe -m 0 .\hash.txt .\rockyou.txt
```

#### Note
- Running a full rockyou.txt on a MD5 hash takes around 20 seconds (pretty fast)
	- Done on a laptop (No GPU and only a core i5)
- However a "md5crypt" takes around 20/25 minutes