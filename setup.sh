#!/bin/sh

GYST_PATH="${1:-/gyst}"
. $GYST_PATH/common_fn.sh

# TODO: Prompt for network details, connect, and arch-chroot /mnt

# Prepare for AUR helper build
pacman -Sy --noconfirm base-devel
pacman -Sy --noconfirm sudo
# Setup wheel sudo
sed 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers > /etc/sudoers.new
if [[ ! -s /etc/sudoers.new ]]; then
  export EDITOR="cp /etc/sudoers.new"
  visudo
fi
rm /etc/sudoers.new
# Setup installer user
id -u installer > /dev/null 2>&1 || { useradd -m -g wheel installer; passwd -d installer; }
[ -d /tmp/yay ] && rm -rf /tmp/yay
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
chmod -R 777 /tmp/yay
sudo -u installer -H sh -c "makepkg -si --noconfirm"
cd ~
rm -rf /tmp/yay
loop_files $GYST_PATH
userdel installer
rm -rf /home/installer
