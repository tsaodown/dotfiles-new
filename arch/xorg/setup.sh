#!/bin/sh

GYST_PATH="${GYST_PATH:-/gyst}"
. $GYST_PATH/common_fn.sh

package_install xf86-video-intel
package_install xorg-server
package_install xorg-xinit

ln_replace $GYST_PATH/arch/xorg/xinitrc /etc/X11/xinit/xinitrc
ln_replace $GYST_PATH/arch/xorg/Xresources /etc/X11/xinit/Xresources
