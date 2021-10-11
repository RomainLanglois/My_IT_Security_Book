# Use Base64 to transfer a file from a victim machine
```bash
# On local system:
cat filetoupload | base64 -w 0; echo
# Double click on output to copy
# On Target System:
echo <copiedContent> | base64 -d > filetoupload

# It is also interesting to use base64 to download a huge file
base64 -w 0 <filename>
base64 -d <filename>
```