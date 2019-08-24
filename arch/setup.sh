#!/bin/sh

GYST_PATH="${GYST_PATH:-/gyst}"
. $GYST_PATH/common_fn.sh

package_install networkmanager

package_install powerline-console-fonts
setfont /usr/share/kbd/consolefonts/ter-powerline-v32n.psf.gz
echo 'FONT=ter-powerline-v32n' > /etc/vconsole.conf
grub-mkfont -s 32 -o /boot/grubfont.pf2 /usr/share/fonts/TTF/Meslo\ LG\ L\ Regular\ for\ Powerline.ttf
if ! grep FONT /etc/default/grub; then echo 'GRUB_FONT="/boot/grubfont.pf2"' > /etc/default/grub; fi
cleanup_installer
