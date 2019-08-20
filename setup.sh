#!/bin/sh

die() {
  if [[ ! -z "$*" ]]; then echo "$*" 1>&2; fi
  printf "\e[91m$(cat /tmp/sys-setup)\e[0m\n"
  rm /tmp/sys-setup
  exit 1
}

get_input() {
  read -p $'\e[1;90m'"$1"$'\e[0m: ' TMP
  echo "$TMP"
}

print_msg() {
  printf "\e[1;90m$1\e[0m\n"
}

run_w_msg() {
  clear
  print_msg "$1"
  echo "${*:2}" | sh > /tmp/sys-setup 2>&1 || die
  rm /tmp/sys-setup > /dev/null 2>&1
}

package_install() {
  # TODO: Expand this to include custom commands and not just pacman
  echo "${2:-$1}" | { NAME=$(cat); run_w_msg "Installing $NAME..." yay -Sy --noconfirm $1; }
}

git_config() {
  print_msg "Configuring $1..."
  { [[ -z "$2" ]] && echo "$(get_input $1)" || echo "$2"; } | { VALUE=$(cat); git config --global $1 "$VALUE"; }
}

# TODO: Prompt for network details, connect, and arch-chroot /mnt

# Prepare for AUR helper build
pacman -Sy base-devel
pacman -Sy sudo
# Setup wheel sudo
sed 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers > /etc/sudoers.new
if [[ ! -s /etc/sudoers.new ]]; then
  export EDITOR="cp /etc/sudoers.new"
  visudo
fi
rm /etc/sudoers.new
# Setup installer user
id -u installer > /dev/null 2>&1 || { useradd -m -g users installer; passwd -d installer; }
su installer << EOSU
# Install yay
git clone https://aur.archlinux.org/yay.git /tmp/aur
cd /tmp/aur
makepkg -si
cd ~
rm -rf /tmp/aur
EOSU

# Proceed with standard package installation
package_install terminus-font
setfont ter-132b
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
./terminal/setup.sh
