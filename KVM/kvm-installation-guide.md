# Installing KVM on Arch Linux, Debian and Fedora

This guide explains how to install and configure **KVM** (Kernel-based Virtual Machine) with **QEMU** and **libvirt** on three Linux distributions:

- [Arch Linux](#3-arch-linux)
- [Debian](#4-debian) (12 "Bookworm" / 13 "Trixie")
- [Fedora](#5-fedora) (Workstation / Server, recent releases)

Each section gives the bash commands to run. Commands that start with `sudo` need administrator rights.

---

## Table of contents

1. [Overview](#1-overview)
2. [Prerequisites (all distributions)](#2-prerequisites-all-distributions)
3. [Arch Linux](#3-arch-linux)
4. [Debian](#4-debian)
5. [Fedora](#5-fedora)
6. [Post-installation (all distributions)](#6-post-installation-all-distributions)
7. [Creating a first virtual machine](#7-creating-a-first-virtual-machine)
8. [Optional: nested virtualization](#8-optional-nested-virtualization)
9. [Troubleshooting](#9-troubleshooting)
10. [Quick reference](#10-quick-reference)

---

## 1. Overview

|Component|Role|
|---|---|
|**KVM**|Kernel module (`kvm`, `kvm_intel` or `kvm_amd`) that turns Linux into a type-1 hypervisor. Already in the kernel.|
|**QEMU**|Emulates the virtual hardware (disks, network cards, display) and uses KVM for acceleration.|
|**libvirt**|Management daemon and API (`virsh`) that controls VMs, networks and storage.|
|**virt-manager**|Graphical interface for libvirt (optional on servers).|
|**virt-install**|Command-line tool to create VMs.|
|**OVMF / edk2**|UEFI firmware for VMs (needed for Secure Boot, Windows 11, etc.).|
|**swtpm**|Software TPM 2.0 emulator (needed for Windows 11).|

---

## 2. Prerequisites (all distributions)

### 2.1 Check that the CPU supports hardware virtualization

```bash
# Number of CPU threads exposing Intel VT-x (vmx) or AMD-V (svm); must be > 0
grep -Ec '(vmx|svm)' /proc/cpuinfo

# Human-readable alternative
lscpu | grep -i virtualization
```

- `VT-x` → Intel CPU
- `AMD-V` → AMD CPU

If the result is `0` or nothing is printed, enable **Intel VT-x / AMD SVM** (sometimes named "Virtualization Technology") in the BIOS/UEFI firmware settings, then reboot.

### 2.2 Check that the KVM kernel modules are loaded

```bash
lsmod | grep kvm
```

Expected output (example for Intel):

```text
kvm_intel             458752  0
kvm                  1404928  1 kvm_intel
```

If nothing is shown, load the module manually:

```bash
sudo modprobe kvm_intel   # Intel CPU
# or
sudo modprobe kvm_amd     # AMD CPU
```

### 2.3 Check that `/dev/kvm` exists

```bash
ls -l /dev/kvm
```

### 2.4 Update the system first

Do this with your distribution's command (shown in each section below) before installing anything.

---

## 3. Arch Linux

### 3.1 Update the system

```bash
sudo pacman -Syu
```

### 3.2 Install the packages

```bash
sudo pacman -S --needed qemu-full libvirt virt-manager virt-viewer virt-install \
    dnsmasq openbsd-netcat edk2-ovmf swtpm
```

|Package|Purpose|
|---|---|
|`qemu-full`|QEMU with all architectures and features (use `qemu-desktop` or `qemu-base` for a lighter install)|
|`libvirt`|Virtualization daemon and `virsh`|
|`virt-manager`|Graphical manager|
|`virt-viewer`|Lightweight VM console viewer|
|`virt-install`|CLI tool to create VMs|
|`dnsmasq`|DHCP/DNS for the default NAT network|
|`openbsd-netcat`|Needed by virt-manager to manage remote hosts over SSH|
|`edk2-ovmf`|UEFI firmware for VMs|
|`swtpm`|Software TPM emulator|

> If `pacman` asks which `iptables` provider to use, choose `iptables-nft`.

### 3.3 Enable and start libvirt

```bash
sudo systemctl enable --now libvirtd.service
```

### 3.4 Allow your user to manage VMs without root

```bash
sudo usermod -aG libvirt "$USER"
```

Arch's `libvirt` package ships a polkit rule that grants members of the `libvirt` group access to the system instance (`qemu:///system`).

Make `virsh` use the system instance by default (otherwise it connects to `qemu:///session`):

```bash
echo 'export LIBVIRT_DEFAULT_URI="qemu:///system"' >> ~/.bashrc
```

**Log out and log back in** (or reboot) for the group change to take effect.

### 3.5 Continue

Go to [Post-installation](#6-post-installation-all-distributions).

---

## 4. Debian

Valid for Debian 12 (Bookworm) and Debian 13 (Trixie).

### 4.1 Update the system

```bash
sudo apt update && sudo apt full-upgrade -y
```

### 4.2 Install the packages

**Desktop (with graphical interface):**

```bash
sudo apt install -y qemu-system-x86 qemu-utils libvirt-daemon-system libvirt-clients \
    virtinst virt-manager virt-viewer bridge-utils ovmf swtpm-tools
```

**Headless server (no GUI):**

```bash
sudo apt install -y --no-install-recommends qemu-system-x86 qemu-utils \
    libvirt-daemon-system libvirt-clients virtinst bridge-utils ovmf swtpm-tools
```

|Package|Purpose|
|---|---|
|`qemu-system-x86`|QEMU for x86_64 guests, with KVM support|
|`qemu-utils`|Tools such as `qemu-img`|
|`libvirt-daemon-system`|libvirt daemon, systemd units, default config|
|`libvirt-clients`|`virsh` and other client tools|
|`virtinst`|`virt-install`|
|`virt-manager`|Graphical manager (desktop only)|
|`bridge-utils`|Tools to create network bridges|
|`ovmf`|UEFI firmware for VMs|
|`swtpm-tools`|Software TPM emulator|

Optional: Debian provides `kvm-ok` to check KVM support:

```bash
sudo apt install -y cpu-checker
kvm-ok
```

### 4.3 Enable and start libvirt

The service is normally started automatically by the package. To be sure:

```bash
sudo systemctl enable --now libvirtd
systemctl status libvirtd --no-pager
```

### 4.4 Allow your user to manage VMs without root

```bash
sudo usermod -aG libvirt,kvm "$USER"
echo 'export LIBVIRT_DEFAULT_URI="qemu:///system"' >> ~/.bashrc
```

**Log out and log back in** (or reboot) for the group change to take effect.

### 4.5 Continue

Go to [Post-installation](#6-post-installation-all-distributions).

---

## 5. Fedora

Fedora provides a ready-made **virtualization** package group.

### 5.1 Update the system

```bash
sudo dnf upgrade --refresh -y
```

### 5.2 Install the packages

**Recommended: install the package group**

```bash
# Fedora 41 and later (dnf5)
sudo dnf group install -y --with-optional virtualization

# Fedora 40 and earlier (dnf4)
sudo dnf groupinstall -y --with-optional virtualization
```

This installs `qemu-kvm`, `libvirt`, `virt-install`, `virt-manager`, `virt-viewer`, `edk2-ovmf`, `swtpm`, and related tools.

**Alternative: install packages individually (e.g. on a server without GUI)**

```bash
sudo dnf install -y qemu-kvm libvirt virt-install guestfs-tools edk2-ovmf swtpm
```

Add `virt-manager virt-viewer` if you want the graphical tools.

### 5.3 Enable and start libvirt

Recent Fedora releases use libvirt's **modular daemons** (one daemon per driver). The simplest way to start everything:

```bash
sudo systemctl enable --now libvirtd
```

Or, to use the modular daemons explicitly (the upstream-recommended approach):

```bash
for drv in qemu network nodedev nwfilter secret storage interface; do
    sudo systemctl enable --now virt${drv}d.socket
    sudo systemctl enable --now virt${drv}d-ro.socket
    sudo systemctl enable --now virt${drv}d-admin.socket
done
```

Use **one** of the two methods, not both.

### 5.4 Allow your user to manage VMs without root

```bash
sudo usermod -aG libvirt "$USER"
echo 'export LIBVIRT_DEFAULT_URI="qemu:///system"' >> ~/.bashrc
```

**Log out and log back in** (or reboot) for the group change to take effect.

> **SELinux:** Fedora enforces SELinux. Store disk images in `/var/lib/libvirt/images/` (the default) so they get the correct label. If you use another directory, relabel it:
> 
> ```bash
> sudo semanage fcontext -a -t virt_image_t "/path/to/vms(/.*)?"
> sudo restorecon -Rv /path/to/vms
> ```

### 5.5 Continue

Go to [Post-installation](#6-post-installation-all-distributions).

---

## 6. Post-installation (all distributions)

### 6.1 Validate the host

```bash
sudo virt-host-validate qemu
```

All important lines should show `PASS`. A `WARN` about IOMMU only matters for PCI passthrough.

### 6.2 Check that your user has access

After logging back in:

```bash
groups                     # should list "libvirt"
virsh list --all           # should run without sudo and without error
```

### 6.3 Enable the default NAT network

libvirt creates a NAT network called `default` (bridge `virbr0`, subnet `192.168.122.0/24`). Make sure it is active and starts at boot:

```bash
sudo virsh net-list --all
sudo virsh net-start default        # skip if already active
sudo virsh net-autostart default
```

If the `default` network does not exist:

```bash
# Path on Debian/Fedora/Arch
sudo virsh net-define /usr/share/libvirt/networks/default.xml
sudo virsh net-start default
sudo virsh net-autostart default
```

### 6.4 (Optional) Create a bridged network

A bridge gives VMs an IP address on your physical LAN. Example with **NetworkManager** (Fedora, most desktops; replace `enp3s0` with your interface name from `ip link`):

```bash
sudo nmcli connection add type bridge ifname br0 con-name br0
sudo nmcli connection add type bridge-slave ifname enp3s0 master br0
sudo nmcli connection modify br0 ipv4.method auto ipv6.method auto
sudo nmcli connection up br0
```

> ⚠️ Doing this over SSH can cut your connection. Run it from a local console.

On Debian servers using `ifupdown`, edit `/etc/network/interfaces` instead:

```text
auto br0
iface br0 inet dhcp
    bridge_ports enp3s0
    bridge_stp off
    bridge_fd 0
```

```bash
sudo systemctl restart networking
```

Then use `--network bridge=br0` when creating VMs.

---

## 7. Creating a first virtual machine

### 7.1 With the graphical interface

```bash
virt-manager
```

Click **File → New Virtual Machine** and follow the wizard.

### 7.2 From the command line

Download an installation ISO into the libvirt image directory:

```bash
sudo curl -L -o /var/lib/libvirt/images/debian.iso \
    https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.2.0-amd64-netinst.iso
```

> The exact ISO file name changes with each point release; check the download page for the current one.

Create and start the VM:

```bash
sudo virt-install \
    --name debian-test \
    --memory 2048 \
    --vcpus 2 \
    --disk size=20,format=qcow2 \
    --cdrom /var/lib/libvirt/images/debian.iso \
    --os-variant debian12 \
    --network network=default \
    --graphics spice \
    --boot uefi
```

List valid `--os-variant` values:

```bash
virt-install --osinfo list | grep -i debian
```

For a headless server, replace `--graphics spice` with:

```bash
    --graphics none --console pty,target_type=serial \
    --location /var/lib/libvirt/images/debian.iso --extra-args 'console=ttyS0'
```

(and remove `--cdrom`).

### 7.3 Common `virsh` commands

```bash
virsh list --all                 # list all VMs
virsh start debian-test          # start a VM
virsh shutdown debian-test       # clean shutdown (ACPI)
virsh destroy debian-test        # force power-off
virsh autostart debian-test      # start VM at host boot
virsh console debian-test        # serial console (exit with Ctrl+])
virsh dominfo debian-test        # VM details
virsh snapshot-create-as debian-test snap1   # create a snapshot
virsh undefine debian-test --remove-all-storage --nvram   # delete VM and its disks
```

---

## 8. Optional: nested virtualization

Allows running KVM **inside** a VM (useful for labs and testing).

Check the current state (`Y` or `1` = enabled):

```bash
cat /sys/module/kvm_intel/parameters/nested   # Intel
cat /sys/module/kvm_amd/parameters/nested     # AMD
```

Enable it permanently:

```bash
# Intel
echo "options kvm_intel nested=1" | sudo tee /etc/modprobe.d/kvm-nested.conf
# AMD
echo "options kvm_amd nested=1" | sudo tee /etc/modprobe.d/kvm-nested.conf
```

Reload the module (all VMs must be stopped) or reboot:

```bash
sudo modprobe -r kvm_intel && sudo modprobe kvm_intel   # Intel
sudo modprobe -r kvm_amd   && sudo modprobe kvm_amd     # AMD
```

Then give the guest the host CPU model: `--cpu host-passthrough` with `virt-install`.

---

## 9. Troubleshooting

|Symptom|Likely cause|Fix|
|---|---|---|
|`grep -Ec '(vmx\|svm)' /proc/cpuinfo` returns `0`|Virtualization disabled in firmware|Enable VT-x / AMD-V (SVM) in BIOS/UEFI|
|`/dev/kvm` missing|KVM module not loaded|`sudo modprobe kvm_intel` or `kvm_amd`; check `dmesg \| grep -i kvm`|
|`KVM: disabled by BIOS` in `dmesg`|Same as above|Enable virtualization in firmware|
|`Failed to connect socket to '/var/run/libvirt/libvirt-sock': Permission denied`|User not in `libvirt` group or session not refreshed|`sudo usermod -aG libvirt $USER`, then log out/in|
|`virsh list` shows nothing, but VMs exist|`virsh` connected to `qemu:///session`|Use `virsh -c qemu:///system list --all` or set `LIBVIRT_DEFAULT_URI`|
|`Network 'default' is not active`|Default network not started|`sudo virsh net-start default && sudo virsh net-autostart default`|
|VM has no network / no DHCP|`dnsmasq` missing (Arch) or firewall conflict|Install `dnsmasq`; restart `libvirtd`; check `firewalld`/`nftables` rules|
|`Permission denied` on disk image (Fedora)|Wrong SELinux label|Move image to `/var/lib/libvirt/images/` or run `restorecon` (see §5.4)|
|`Permission denied` on ISO in home folder|`qemu` user cannot read `$HOME`|Copy ISO to `/var/lib/libvirt/images/`|
|UEFI boot option missing|OVMF not installed|Install `edk2-ovmf` (Arch/Fedora) or `ovmf` (Debian)|

Useful logs:

```bash
journalctl -u libvirtd -b                    # libvirt daemon log
sudo tail -f /var/log/libvirt/qemu/<vm>.log  # per-VM QEMU log
dmesg | grep -i kvm                          # kernel messages
```

---

## 10. Quick reference

|Step|Arch Linux|Debian|Fedora|
|---|---|---|---|
|Update|`sudo pacman -Syu`|`sudo apt update && sudo apt full-upgrade`|`sudo dnf upgrade --refresh`|
|Install|`sudo pacman -S qemu-full libvirt virt-manager virt-install dnsmasq edk2-ovmf swtpm`|`sudo apt install qemu-system-x86 libvirt-daemon-system libvirt-clients virtinst virt-manager ovmf`|`sudo dnf group install --with-optional virtualization`|
|Start service|`sudo systemctl enable --now libvirtd`|`sudo systemctl enable --now libvirtd`|`sudo systemctl enable --now libvirtd`|
|User access|`sudo usermod -aG libvirt $USER`|`sudo usermod -aG libvirt,kvm $USER`|`sudo usermod -aG libvirt $USER`|
|UEFI package|`edk2-ovmf`|`ovmf`|`edk2-ovmf`|
|Validate|`sudo virt-host-validate qemu`|`sudo virt-host-validate qemu`|`sudo virt-host-validate qemu`|

**Remember:** after adding your user to the `libvirt` group, log out and log back in.