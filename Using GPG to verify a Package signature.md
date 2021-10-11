# Example with veracrypt 
## On Linux
```bash
# Download the public GPG key
wget https://www.idrix.fr/VeraCrypt/VeraCrypt_PGP_public_key.asc

# Verify the public key fingerprint
gpg --import --import-options show-only VeraCrypt_PGP_public_key.asc

# If the fingerprint is the expected one, import the public key
gpg --import VeraCrypt_PGP_public_key.asc
 
# Verify the signature
gpg --verify veracrypt-1.23-setup.tar.bz2.sig veracrypt-1.23-setup.tar.bz2
```

## On Windows 
- https://www.veracrypt.fr/en/Digital%20Signatures.html