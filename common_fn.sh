#!/bin/sh

GYST_PATH=${GYST_PATH:-/gyst}

set -eE -o functrace

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
  # TODO: Expand this to include custom commands and not just pacman
  run_w_msg "Installing ${2:-$1}..." 'sudo -u installer -H sh -c "yay -Sy --noconfirm $1"'
}

git_config() {
  print_msg "Configuring $1..."
  { [[ -z "$2" ]] && echo "$(get_input $1)" || echo "$2"; } | { VALUE=$(cat); git config --global $1 "$VALUE"; }
}

loop_files() {
  for file in $1/*; do
    if [ -d $file ]; then
      if [ -x $file/setup.sh ]; then
        . $file/setup.sh
      fi
      loop_files $file
    fi
  done
}
