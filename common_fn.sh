#!/bin/sh

GYST_PATH=${GYST_PATH:-/gyst}

set -eE -o functrace

setup_installer() {
  # Setup wheel sudo
  sed 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers > /etc/sudoers.new
  if [[ ! -s /etc/sudoers.new ]]; then
    export EDITOR="cp /etc/sudoers.new"
    visudo
  fi
  rm /etc/sudoers.new
  # Setup installer user
  id -u installer > /dev/null 2>&1 || { useradd -m -g wheel installer; passwd -d installer; }
}

cleanup_installer() {
  id -u installer > /dev/null 2>&1 && userdel installer
  rm -rf /home/installer
}

add_env_var() {
[ $# -ne 0 ] && export $1
[ $# -ne 0 ] && [ -z $(grep -q "$1" $GYST_PATH/terminal/zsh/zshenv_global) ] && cat << EOF >> $GYST_PATH/terminal/zsh/zshenv_global
export $1
EOF
}

failure() {
  local lineno=$1
  local msg=$2
  echo "Failed at $lineno: $msg"
}
trap 'failure ${LINENO} "$BASH_COMMAND" ${PROGNAME}' ERR

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
  echo "${@:2}" | sh > /tmp/sys-setup 2>&1 || die
  rm /tmp/sys-setup > /dev/null 2>&1
}

package_install() {
  id -u installer > /dev/null 2>&1 || setup_installer
  # TODO: Expand this to include custom commands and not just pacman
  run_w_msg "Installing ${2:-$1}..." 'sudo -u installer -H sh -c "yay -Sy --noconfirm $1"'
}

git_config() {
  print_msg "Configuring $1..."
  { [[ -z "$2" ]] && echo "$(get_input $1)" || echo "$2"; } | { VALUE=$(cat); git config --global $1 "$VALUE"; }
}

loop_files() {
  for file in $1/*; do
    if [[ -d $file && ( ! -a $file/.git || -d $file/.git ) ]]; then
      if [ -x $file/setup.sh ]; then
        . $file/setup.sh
      fi
      loop_files $file
    fi
  done
}
