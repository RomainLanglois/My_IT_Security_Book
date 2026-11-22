# My IT Security Book

A personal knowledge base of IT and cybersecurity notes: course notes, cheat sheets, installation guides and scripts collected while studying (HackTheBox Academy, TryHackMe, OSCP) and administering Linux systems.

The repository is written in Markdown and organised as an [Obsidian](https://obsidian.md/) vault, but every note can be read directly on GitHub or in any text editor.

> **Disclaimer** — The offensive security content (enumeration, exploitation, privilege escalation, AV bypass, ...) is for educational purposes and authorised testing only (labs, CTFs, engagements with written permission).

---

## Repository structure

```text
.
├── Courses/                  # Course notes and cheat sheets (security, networking, scripting)
│   ├── HackTheBox_Academy/   #   BloodHound, CPTS (Active Directory), Python, Reverse engineering
│   ├── OSCP_Notes/           #   Pentest methodology: recon → enumeration → exploitation → privesc
│   ├── TryHackMe/            #   Networking, Wireshark, PowerShell, Regular expressions
│   ├── Git/                  #   Git crash course, useful GitHub repositories
│   └── Bash CheatSheet.md
├── Gentoo_Notes/             # Gentoo installation guides, config files and install scripts
├── KVM/                      # KVM / QEMU / libvirt virtualisation
├── Fedora/                   # Fedora specifics (DNF package manager)
├── Obsidian_Basics/          # Obsidian settings and hotkeys
├── IPRoute vs NetTools.md    # Linux network configuration with iproute2
└── Using GPG to verify a Package signature.md
```

## Content

### Courses

| Section | Topics |
| --- | --- |
| [OSCP_Notes](Courses/OSCP_Notes) | Full pentest methodology: Nmap/DNS reconnaissance, per-service enumeration (TCP/UDP ports, CMS), web exploitation (SQLi, LFI/RFI, command injection, file upload), Linux & Windows privilege escalation, stack buffer overflow, password cracking (Hashcat, John), file transfer, pivoting (SSH, Chisel, Socat), reverse shells, AV bypass |
| [HackTheBox_Academy / CPTS](Courses/HackTheBox_Academy/CPTS) | Active Directory: external recon, initial enumeration, LLMNR/NBT-NS poisoning, password policy & password spraying |
| [HackTheBox_Academy / Bloodhound](Courses/HackTheBox_Academy/Bloodhound) | BloodHound & SharpHound setup and usage, Cypher queries, lab answers |
| [HackTheBox_Academy / Reverse_engineering](Courses/HackTheBox_Academy/Reverse_engineering) | x86-64 assembly course, compilation process, ELF and PE file formats, Ghidra / IDA / x64dbg |
| [HackTheBox_Academy / Python](Courses/HackTheBox_Academy/Python) | Python basics for pentesters, small tools (bind shell, word extractor) |
| [TryHackMe](Courses/TryHackMe) | Networking (OSI/TCP-IP, ARP, DNS, ICMP, HTTPS), Wireshark, PowerShell, Regular expressions |
| [Git](Courses/Git) | Git crash course, list of useful offensive-security GitHub repositories |

### System administration

| Section | Topics |
| --- | --- |
| [Gentoo_Notes](Gentoo_Notes) | BIOS and UEFI installation guides, kernel upgrade, USE flags, GUI setup, TPM (WIP); reference `make.conf`, kernel and `dracut` configs; Bash scripts automating a hardened UEFI install |
| [KVM](KVM) | KVM/QEMU/libvirt installation on Arch, Debian and Fedora; Debian guest tools & virtiofs shared folder; `qemu:///system` vs `qemu:///session`; VMDK → QCOW2 conversion script |
| [Fedora](Fedora) | YUM vs DNF and common `dnf` commands |
| [IPRoute vs NetTools](<IPRoute vs NetTools.md>) | `ip` / `ss` equivalents of `ifconfig`, `route`, `arp`, `netstat`, and persistent network configuration |
| [Using GPG to verify a Package signature](<Using GPG to verify a Package signature.md>) | Verifying downloads and packages with GPG signatures |
| [Obsidian_Basics](Obsidian_Basics) | Recommended Obsidian settings and hotkeys |

## Usage

```bash
# Clone the repository
git clone <repository-url> IT_book
cd IT_book

# Search all notes for a keyword
grep -rni --include='*.md' "kerbrute" .

# List every note of a section
find "Courses/OSCP_Notes" -name '*.md' | sort
```

To browse it as a vault: open Obsidian → *Open folder as vault* → select the cloned folder. The `.obsidian/` folder (local settings) is ignored by Git.

> The Gentoo scripts in `Gentoo_Notes/Bash_Scripts/` partition and wipe disks. Read them before running them, and only run them on a machine you intend to reinstall.

## Conventions

- One topic per Markdown file; numbered prefixes (`1.`, `2.`, ...) give the reading order inside a folder.
- Screenshots are stored in an `images/` (or `Images/`) folder next to the notes that use them.
- Commands are given in fenced code blocks (`bash`, `powershell`, ...), ready to copy.
- Notes tagged `(WIP)` or `(TODO)` are unfinished.
- Most notes are in English; a few are in French.
