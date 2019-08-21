#!/bin/sh

GYST_PATH="${1:-/gyst}"
. $GYST_PATH/common_fn.sh

# TODO: Prompt for network details, connect, and arch-chroot /mnt

# Prepare for AUR helper build
pacman -Sy --noconfirm base-devel
pacman -Sy --noconfirm sudo
[ -d /tmp/yay ] && rm -rf /tmp/yay
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
chmod -R 777 /tmp/yay
setup_installer
sudo -u installer -H sh -c "makepkg -si --noconfirm"
cd ~
rm -rf /tmp/yay
loop_env() {
  for file in $1/*; do
    if [[ -d $file && ( ! -a $file/.git || -d $file/.git ) ]]; then
      if [ -x $file/env.sh ]; then
        . $file/env.sh
      fi
      loop_env $file
    fi
  done
}
[ -a $GYST_PATH/zsh/zshenv_global ] && rm $GYST_PATH/zsh/zshenv_global
loop_env $GYST_PATH
loop_files $GYST_PATH
cleanup_installer
