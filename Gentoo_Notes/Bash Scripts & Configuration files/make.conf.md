# Make.conf
```bash
# These settings were set by the catalyst build script that automatically
# built this stage.
# Please consult /usr/share/portage/config/make.conf.example for a more
# detailed example.
COMMON_FLAGS="-march=native -O2 -pipe"
CFLAGS="${COMMON_FLAGS}"
CXXFLAGS="${COMMON_FLAGS}"
FCFLAGS="${COMMON_FLAGS}"
FFLAGS="${COMMON_FLAGS}"

# NOTE: This stage was built with the bindist Use flag enabled
PORTDIR="/var/db/repos/gentoo"
DISTDIR="/var/cache/distfiles"
PKGDIR="/var/cache/binpkgs"

# This sets the language of build output to English.
# Please keep this setting intact when reporting bugs.
LC_MESSAGES=C
GRUB_PLATFORMS='efi-64'
MAKEOPTS="-j4"
USE="-systemd"

GENTOO_MIRRORS="ftp://ftp.free.fr/mirrors/ftp.gentoo.org/ http://ftp.free.fr/mirrors/ftp.gentoo.org/ https://mirrors.ircam.fr/pub/gentoo-distfiles/"
```