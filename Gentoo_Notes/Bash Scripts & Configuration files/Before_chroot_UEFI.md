```bash
#!/bin/bash
echo "########################################"
echo "Formating and encrypting the designated disk"
lsblk
echo "Please enter the disk to partition:"
read disk
wipefs -a /dev/$disk

parted -a optimal /dev/$disk -s 'mklabel gpt'
parted -a optimal /dev/$disk -s 'unit mib'
parted -a optimal /dev/$disk -s 'mkpart primary 1 3' 
parted -a optimal /dev/$disk -s 'name 1 grub'
parted -a optimal /dev/$disk -s 'set 1 bios_grub on'
parted -a optimal /dev/$disk -s 'mkpart primary fat32 3 515 '
parted -a optimal /dev/$disk -s 'name 2 boot'
parted -a optimal /dev/$disk -s 'set 2 boot on'
parted -a optimal /dev/$disk -s 'mkpart primary 515 -1'
parted -a optimal /dev/$disk -s 'name 3 lvm'
parted -a optimal /dev/$disk -s 'set 3 lvm on'
parted -a optimal /dev/$disk -s 'print'

lsblk
modprobe dm-crypt
echo "Please enter the partion to encrypt with luks"
read luks_partition
cryptsetup luksFormat /dev/$luks_partition
cryptsetup luksOpen /dev/$luks_partition lvm 
lvm pvcreate /dev/mapper/lvm 
vgcreate vg0 /dev/mapper/lvm 
lvcreate -L 25G -n root vg0 
lvcreate -l 100%FREE -n home vg0
mkfs.fat -F 32 /dev/$disk\2
mkfs.ext4 /dev/mapper/vg0-root 
mkfs.ext4 /dev/mapper/vg0-home 
mount /dev/mapper/vg0-root /mnt/gentoo
mkdir /mnt/gentoo/home
mount /dev/mapper/vg0-home /mnt/gentoo/home
echo "Formating encrypting and mounting done !"
echo "########################################"

echo "############################################"
echo "Date configuration"
date
echo "Please : enter a date (Example : date -s '13 JUN 2022 20:59:00')"
read date
date -s $date
echo "Done !"
echo "########################################"

echo "############################################"
echo "Downloading and decompressing Stage3 TarBall"
cd /mnt/gentoo
links https://www.gentoo.org/downloads/mirrors/
tar xpvf stage3-amd64-hardened-openrc-*.tar.xz --xattrs-include='*.*' --numeric-owner
rm -f stage3-amd64-hardened-openrc-*.tar.xz
echo "Done !"
echo "###########################################"

echo "############################################"
echo "Setting-up make.conf"
echo 'COMMON_FLAGS="-march=native -O2 -pipe"' >> etc/portage/make.conf
echo 'GRUB_PLATFORMS="efi-64"' >> etc/portage/make.conf
echo 'MAKEOPTS="-j4"' >> etc/portage/make.conf
echo "done !"
echo "########################################"

echo "############################################"
echo "Configuring mirrors"
echo 'GENTOO_MIRRORS="ftp://ftp.free.fr/mirrors/ftp.gentoo.org/ http://ftp.free.fr/mirrors/ftp.gentoo.org/ https://mirrors.ircam.fr/pub/gentoo-distfiles/"' >> etc/portage/make.conf
# mirrorselect -i -o >> /mnt/gentoo/etc/portage/make.conf
mkdir --parents etc/portage/repos.conf
cp usr/share/portage/config/repos.conf etc/portage/repos.conf/gentoo.conf
cp --dereference /etc/resolv.conf etc/
echo "done !"
echo "########################################"

echo "############################################"
echo "Moving inside the chroot !"
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run
chroot /mnt/gentoo /bin/bash
```

