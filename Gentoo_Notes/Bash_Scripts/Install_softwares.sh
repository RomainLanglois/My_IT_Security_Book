# This list is based on my current /var/lib/portage/world file
# Bash one liner to retrieve and format all packages inside the world file
# while read -r line; do echo "\"$line\""; done < /var/lib/portage/world

## Already existing packages
# "app-admin/sudo"
#"net-misc/dhcpcd"
#"net-misc/netifrc"
#"sys-boot/grub:2"
#"sys-fs/cryptsetup"
#"sys-fs/lvm2"
#"sys-kernel/gentoo-sources"
#"sys-kernel/linux-firmware"
#"sys-kernel/dracut"

## GUI Packages
#"x11-base/xorg-drivers"
#"x11-base/xorg-server"
#"x11-misc/i3blocks"
#"x11-misc/i3lock"
#"x11-misc/i3status"
#"x11-wm/i3-gaps"
#"x11-terms/terminator"

## Add support for the TPM
TPM_softwares_array=(
"app-crypt/clevis"
"app-crypt/tpm2-tools"
"app-crypt/tpm2-tss"
)

softwares_array=(
"app-eselect/eselect-repository"
"app-misc/neofetch"
"app-portage/gentoolkit"
"dev-vcs/git"
"sys-apps/usbutils"
"sys-process/htop"
)

emaint -a sync
for software in ${softwares_array[@]}; do
  emerge -q $software
done

echo "Do you wan to install the TPM packages ? (Y/N)"
read user_choice
if [[ $user_choice = "Y" ]]
then
	for TPM_software in ${TPM_softwares_array[@]}; do
	  emerge -q $TPM_software
	done
else
	echo "Exiting..."
fi
