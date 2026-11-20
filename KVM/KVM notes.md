# KVM notes
## Installation
#### Fedora (35/34/33/32/31/30)
- https://computingforgeeks.com/how-to-install-kvm-on-fedora/
```bash
# Install packages
sudo dnf install bridge-utils libvirt virt-install qemu-kvm virt-manager
```
#### Ubuntu (18.10 or later)
- https://help.ubuntu.com/community/KVM/Installation
```bash
sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
```

## Configuration
#### First step - Configure the deamon
```bash
# Check if KVM kernel module is loaded
lsmod | grep kvm

# Start the KVM daemon
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
```
#### Second step - Execute virt-manager as non root user
```bash
# check if libvirt group exits
grep -i libvirt /etc/group 

# Add the current user to the group
sudo usermod -aG libvirt $USER

# It is necessary to disconnect the user sesssion and then reconnect
# Check if the current user is a member of libvirt group
id
```

## Start KVM administration gui
```bash
virt-manager
```