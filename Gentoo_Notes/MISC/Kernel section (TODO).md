# Tips For Customizing Your Linux Kernel
- Backup the older version
- Have backup computer in order to debug your kernel
- Use the search parameter inside "sudo make menuconfig" for specific string (related parameter)
- Save the kernel configuration to a file

# Configure a custom Linux Kernel
- Define a goal
	- Example : Mental Oulaw goals
		- A high performance kernel that is small in size and has a low memory footprint
		- No unnecessary software or hardware support 
		- Minimalist Security only, NO BLOAT !
- cd /usr/src/linux
- sudo make menuconfig
- sudo make && sudo make modules_install && sudo make install

# Upgrade gentoo Linux Kernel
- emerge --sync
- emerge --update --deep --with-bdeps=y --newuse sys-kernel/gentoo-sources --> Gentoo documentation
	- emerge -uDNq --with-bdeps=y sys-kernel/gentoo-sources --> Same command

## Backup kernel config
- cp /usr/src/linux/.config $(uname -r).config
- cd /usr/src/
- eselect kernel list
- eselect kernel set 2
- eselect kernel list
- cd linux
## Make clean ?? (link with a make file ??)
- make mrproper
- cp $(uname -r).config /usr/src/linux
## If you need to change the kernel configuration
- make menuconfig
## copy old config option to the new one
### Options not defined on the new kernel will be set to default
- make olddefconfig
## Prepare modules
- make modules_prepare
## Compile the new kernel
- make -j4 && make modules_install && make install 
## Check if config exists
- ls -al /boot
- reboot