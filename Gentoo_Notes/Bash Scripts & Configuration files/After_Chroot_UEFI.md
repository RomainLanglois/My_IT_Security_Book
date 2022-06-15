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
echo "Please select your locale"
read locale
eselect locale set $locale
env-update && source /etc/profile && export PS1="(chroot) ${PS1}"
echo "Done !"
echo "########################################"

echo "########################################"
echo "Configuring tthe keymap"
sed -i 's/keymap=\"us\"/keymap=\"fr\"/g' /etc/conf.d/keymaps
echo "Done !"
echo "########################################"

echo "########################################"
echo "Installing linux firmware and kernel sources"
echo "sys-kernel/linux-firmware linux-fw-redistributable no-source-code" >> /etc/portage/package.license
emerge -q sys-kernel/linux-firmware
emerge -q sys-kernel/gentoo-sources genkernel
eselect kernel list
echo "Please select the kernel:"
read kernel
eselect kernel set $kernel
echo "Done !"
echo "########################################"

echo "########################################"
echo "Installing lvm cryptsetup then the linux Kernel"
emerge -q sys-fs/cryptsetup sys-fs/lvm2
genkernel --luks --lvm --no-zfs all
genkernel --luks --lvm initramfs 
echo "Done !"
echo "########################################"

echo "########################################"
ip a
echo "DHCP configuration : please enter network interface"
read network_interface
emerge --noreplace --quiet net-misc/netifrc
echo 'config_'$network_interface="dhcp" >> /etc/conf.d/net
emerge -q net-misc/dhcpcd
cd /etc/init.d
ln -s net.lo net.$network_interface
rc-update add net.$network_interface default
echo "Done !"
echo "########################################"

echo "########################################"
blkid
echo "Please enter UUID LUKS for /boot then / then /home"
read UUID_boot
read UUID_luks_root
read UUID_luks_home
echo "UUID=$UUID_boot            /boot           vfat            noauto,noatime  1 2" >> /etc/fstab
echo "UUID=$UUID_luks_root       /               ext4            defaults        0 1" >> /etc/fstab
echo "UUID=$UUID_luks_home       /home           ext4            defaults        0 1" >> /etc/fstab
echo "Done !"
echo "########################################"

echo "########################################"
echo "Installing and configuring the bootloader (grub)"
emerge -q sys-boot/grub:2
echo "sys-boot/grub:2 device-mapper" >> /etc/portage/package.use/sys-boot
blkid | grep -i luks
echo "Please enter the UUID for the partion holding the LUKS container"
read luks_container

sed 's/GRUB_CMDLINE_LINUX=\"\"/GRUB_CMDLINE_LINUX=\"dolvm crypt_root=UUID=$luks_container\"/g' /etc/default/grub

grub-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
rc-update add lvm boot
echo "Done !"
echo "########################################"

echo "########################################"
echo "Changing box name and adding/configuring a new user"
echo "Please enter a name for the box"
read box_name

sed 's/hostname=\'GentooBox\'/hostname=\'$box_name\'/g' /etc/conf.d/hostname

emerge -q app-admin/sudo
useradd -m -G users,wheel,audio -s /bin/bash <username>
passwd
passwd <username>
echo "Done !"
echo "########################################"

echo "########################################"
echo "Umounting the environment"
cd
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