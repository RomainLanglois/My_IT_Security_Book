# Using GPG to verify a package signature

A checksum (`sha256sum`) only proves that a file was **not corrupted**. If an attacker can replace the file, they can replace the checksum too.
A GPG signature also proves **who published it**: only the holder of the private key can produce a signature that matches the public key.

The workflow is always the same:

1. Get the publisher's **public key**.
2. Check its **fingerprint** against a second, independent source (official website over HTTPS, documentation, keyserver, a person you trust).
3. **Import** the key.
4. **Verify** the signature of the downloaded file.

> A key is only as trustworthy as the way you checked its fingerprint. Never trust a key just because it is on the same page as the download.

## 1. Get and inspect the public key

```bash
# Download the key from the official website...
wget https://www.idrix.fr/VeraCrypt/VeraCrypt_PGP_public_key.asc

# ...or fetch it from a keyserver / via WKD (Web Key Directory)
gpg --keyserver hkps://keys.openpgp.org --recv-keys <FINGERPRINT>
gpg --locate-keys security@example.org

# Display the key and its fingerprint WITHOUT importing it
gpg --show-keys --with-fingerprint VeraCrypt_PGP_public_key.asc
```

Compare the full 40-character fingerprint with the one published by the vendor (for VeraCrypt: <https://www.veracrypt.fr/en/Digital%20Signatures.html>). Do not rely on the short 8-character key ID: those are easy to forge.

## 2. Import the key

```bash
gpg --import VeraCrypt_PGP_public_key.asc

# Optional: once the fingerprint is checked, certify the key locally
# (non-exportable) to remove the "not certified" warning
gpg --lsign-key <FINGERPRINT>

# List the imported keys
gpg --list-keys --with-fingerprint
```

## 3. Verify the signature

### Detached signature (`.sig` / `.asc` next to the file)

```bash
VERSION=1.26.24   # example
gpg --verify veracrypt-${VERSION}-setup.tar.bz2.sig veracrypt-${VERSION}-setup.tar.bz2
```

### Signed checksum file (Debian, Ubuntu, Arch ISOs, ...)

Many projects sign a list of checksums instead of each file:

```bash
# 1. Check that the checksum list is authentic
gpg --verify SHA256SUMS.sign SHA256SUMS

# 2. Check that the downloaded file matches the list
sha256sum --check --ignore-missing SHA256SUMS
```

## 4. Read the result

| Output | Meaning | Action |
| --- | --- | --- |
| `Good signature from "..."` | File intact, signed by this key | OK |
| `WARNING: This key is not certified with a trusted signature!` | Signature is valid, but you never certified the key | Normal if you checked the fingerprint manually (or use `--lsign-key`) |
| `BAD signature from "..."` | File modified or corrupted | **Delete the file**, do not use it |
| `Can't check signature: No public key` | Key not imported | Import the key (step 1–2) |

`gpg --verify` returns exit code `0` on a good signature and `1` on a bad one, which is handy in scripts.

## 5. Scripted verification

For automation, use `gpgv` with a dedicated keyring and pin the expected fingerprint:

```bash
#!/bin/bash
set -euo pipefail

EXPECTED_FPR="<40_CHARACTERS_FINGERPRINT>"
FILE="$1"
SIG="$1.sig"

# Keyring that contains ONLY the trusted publisher key
gpg --export "$EXPECTED_FPR" > trusted.gpg

# gpgv only trusts the given keyring; --status-fd gives machine-readable output
if gpgv --keyring ./trusted.gpg --status-fd 1 "$SIG" "$FILE" 2>/dev/null \
     | grep -q "^\[GNUPG:\] VALIDSIG $EXPECTED_FPR"; then
    echo "[+] Valid signature for $FILE"
else
    echo "[-] INVALID signature for $FILE" >&2
    exit 1
fi
```

## 6. Package managers

Package managers do this automatically for every package, using the repository keys:

```bash
# Debian / Ubuntu: repository key pinned per source
curl -fsSL https://example.org/repo.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/example.gpg
echo "deb [signed-by=/etc/apt/keyrings/example.gpg] https://example.org/debian stable main" \
  | sudo tee /etc/apt/sources.list.d/example.list

# Fedora / RHEL: import a repository key and check an RPM manually
sudo rpm --import https://example.org/RPM-GPG-KEY-example
rpm --checksig package.rpm        # or: rpm -K package.rpm
grep gpgcheck /etc/dnf/dnf.conf   # must be gpgcheck=1
```

## On Windows

Install [Gpg4win](https://www.gpg4win.org/): the same `gpg` commands work in PowerShell, or use the **Kleopatra** GUI (*File > Decrypt/Verify*).
VeraCrypt specific instructions: <https://www.veracrypt.fr/en/Digital%20Signatures.html>
