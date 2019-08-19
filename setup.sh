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
  echo "${2:-$1}" | { NAME=$(cat); run_w_msg "Installing $NAME..." pacman -S --noconfirm $1; }
}

git_config() {
  print_msg "Configuring $1..."
  { [[ -z "$2" ]] && echo "$(get_input $1)" || echo "$2"; } | { VALUE=$(cat); git config --global $1 "$VALUE"; }
}

package_install terminus-font
setfont ter-132b
package_install networkmanager
nmtui
package_install vim
package_install openssh
package_install git
package_install hub 'Github CLI'
git_config user.name
git_config user.email
git_config hub.protocol https
git_config credential.helper store
