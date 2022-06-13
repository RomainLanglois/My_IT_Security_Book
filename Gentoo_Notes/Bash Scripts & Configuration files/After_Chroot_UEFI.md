```bash
#!/bin/bash
echo "########################################"
echo "Preparing the environment and emerging @world"
source /etc/profile
export PS1="(chroot) ${PS1}"

echo "Please enter disk partion to mount boot"
read boot_partition
mount /dev/$boot_partition /boot
emerge-webrsync
# Coffe break, it can take a long time
emerge --verbose --update --deep --newuse @world 
echo "Done !"
echo "########################################"

echo "########################################"
echo "Configuring timezone and locale"
echo "Europe/Paris" > /etc/timezone
echo "en_US ISO-8859-1" >> /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "fr_FR ISO-8859-1" >> /etc/locale.gen
echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
eselect locale list
eselect locale set 5
env-update && source /etc/profile && export PS1="(chroot) ${PS1}"
echo "Done !"
echo "########################################"


sed -i 's/keymap=\"us\"/keymap=\"fr\"/g' /etc/conf.d/keymaps

echo "sys-kernel/linux-firmware linux-fw-redistributable no-source-code" >> /etc/portage/package.license

emerge -q sys-kernel/linux-firmware
emerge -q sys-kernel/gentoo-sources genkernel
mv /usr/src/linux*/usr/src/linux
emerge -q sys-fs/cryptsetup sys-fs/lvm2

# NEED SED !!
(chroot) livecd /etc # vim genkernel.conf
...
LVM="yes"
...
LUKS="yes"
...

genkernel --luks --lvm --no-zfs all
genkernel --luks --lvm initramfs 

echo "########################################"
echo "DHCP configuration : please enter network interface"
read network_interface
emerge --noreplace --quiet net-misc/netifrc
echo 'config_$network_interface="dhcp"' >> /etc/conf.d/net
emerge -q net-misc/dhcpcd
cd /etc/init.d
ln -s net.lo net.$network_interface
rc-update add net.$network_interface default
echo "Done !"
echo "########################################"

# TODO
nano /etc/fstab

emerge -q sys-boot/grub:2
echo "sys-boot/grub:2 device-mapper" >> /etc/portage/package.use/sys-boot

blkid | grep -i luks
nano /etc/default/grub
	GRUB_CMDLINE_LINUX="dolvm crypt_root=UUID=(REPLACE ME WITH sdb3 UUID from above) root=/dev/mapper/vgO-root"
echo 'GRUB_PLATFORMS="efi-64"' >> /etc/portage/make.conf
grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
rc-update add lvm boot # -> Not sure for 'default' parameter 

echo "########################################"
echo "Changing box name and adding a new user"
nano /etc/conf.d/hostname
	hostname='GentooBox' -> MachineName
emerge -q app-admin/sudo
useradd -m -G users,wheel,audio -s /bin/bash <username>
passwd
passwd <username>
echo "Done !"
echo "########################################"

echo "########################################"
echo "Umounting the environment"
lsblk
umount /dev/$boot_partition
exit
source /etc/profile
umount /mnt/gentoo/home
umount -R /mnt/gentoo
lsblk
echo "Done !"
echo "########################################"
```
