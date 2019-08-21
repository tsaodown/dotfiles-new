#!/bin/sh

GYST_PATH="${GYST_PATH:-/gyst}"
. $GYST_PATH/common_fn.sh

package_install powerline-console-fonts
setfont /usr/share/kbd/consolefonts/ter-powerline-v32b.psf.gz
package_install networkmanager
package_install vim
package_install openssh
package_install git
package_install hub 'Github CLI'
git_config user.name
git_config user.email
git_config hub.protocol https
git_config credential.helper store
package_install zsh
chsh -s /usr/bin/zsh

package_install neovim
package_install antigen-git
# Setup terminal
$GYST_PATH/terminal/setup.sh
