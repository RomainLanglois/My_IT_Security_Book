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
```

## How to fix relative mouse pointer position
- https://superuser.com/questions/291650/problem-with-kvm-switch-and-erratic-mouse-movement-on-windows-server-2008

#### Using virt-manager
Open up the virtual machine details 
- Add Hardware > Input > EvTouch USB Graphics Tablet.

## Bash script to  convert vmdk file to qcow2
```bash
#!/bin/bash

if [ $# -eq 0 ]
then
    	echo "No arguments supplied"
        exit 1
fi

filename_no_extension=$(echo $1 | cut -d "." -f1)
echo "Extracting vmdk file from OVA..."
tar xvf $1
echo "Converting vmdk file to qcow2"
vmdk_file=$(ls $filename_no_extension*.vmdk)
qemu-img convert -O qcow2 $vmdk_file $filename_no_extension.qcow2
```

## Make Copy & Paste Working
 ```bash
#### Linux
sudo apt install spice-vdagent
reboot
```

#### WIndows
- https://www.spice-space.org/download/windows/spice-guest-tools/
```bash
wget https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe
```


## How to mount a share folder
### WINDOWS
#### Set-up a SMB folder (from the Linux machine) 
Based on my note from the OSCP book (From a Linux machine):
```bash
# Git clone impacket
sudo python3 -m pip3 install impacket
git clone https://github.com/SecureAuthCorp/impacket.git

# A password needs to be set on newer version of Windows
sudo python3 /usr/share/doc/python3-impacket/examples/smbserver.py kali -smb2support -username kali -password kali .
```

#### Set-up a SMB folder (from the Windows machine)
- Create a new user 
- Create a folder
- Properties / Sharing / Share / Attribute permissions to the newly created user
```bash
# Accès depuis un gestionnaire de bureau (e.g. thunar)
smb://<IP>/<share_folder>

# Accès depuis un montage réseau permanent
sudo mount -t cifs -o "username=toto,password=tutu" //<ip>/<folder> <local_folder>
cd <local_folder>
```

#### Set-up a HTTP server (From the Linux machine)
```bash
python3 -m http.server
```

### LINUX
#### Create the share folder
```bash
mkdir /share
chmod 777 /share
```

#### Add the share folder to the VM configuration
![[KVM_configure_share_folder.png]]

#### Mount the share folder on the VM
```bash
mkdir /share
mount -t 9p -o trans=virtio /sharepoint /share
```

Or permanently add it to /etc/fstab file:

```bash
cat /etc/fstab
...
/sharepoint   /share    9p  trans=virtio,version=9p2000.L,rw    0   0
```

#### Configure SELinux to let the VM access the share folder
```bash
semanage fcontext -a -t svirt_image_t "/share(/.*)?"
restorecon -vR /share
```


## Interesting links
- https://doc.fedora-fr.org/wiki/Virtualisation_:_KVM,_Qemu,_libvirt_en_images
- https://doc.fedora-fr.org/wiki/DNF,_le_gestionnaire_de_paquets_de_Fedora#Utilisation_des_groupes
- https://pled.fr/?p=15131
- https://wiki.hackzine.org/sysadmin/kvm-import-ova.html
- https://www.linux-kvm.org/page/9p_virtio
- https://ostechnix.com/setup-a-shared-folder-between-kvm-host-and-guest/
- https://nts.strzibny.name/how-to-set-up-shared-folders-in-virt-manager/
