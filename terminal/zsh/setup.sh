#!/bin/sh

GYST_PATH="${GYST_PATH:-/gyst}"
. $GYST_PATH/common_fn.sh

package_install openssh
package_install git
package_install hub 'Github CLI'
git_config user.name
git_config user.email
git_config hub.protocol https
git_config credential.helper store
package_install zsh
chsh -s /usr/bin/zsh
package_install antigen-git
cleanup_installer

ln_replace $GYST_PATH/terminal/zsh/zshenv_global /etc/zsh/zshenv
ln_replace $GYST_PATH/terminal/zsh/zshrc_global /etc/zsh/zshrc
ln_replace $GYST_PATH/terminal/zsh/zprofile_global /etc/zsh/zprofile

if [ ! -d ~/.oh-my-zsh ] ; then
  curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi
