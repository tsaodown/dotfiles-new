#!/bin/sh

GYST_PATH="${GYST_PATH:-/gyst}"
. $GYST_PATH/common_fn.sh

cat << EOF > $GYST_PATH/terminal/zshenv_global
GYST_PATH=$GYST_PATH
EOF
[ -a /etc/zsh/zshenv ] && rm -rf /etc/zsh/zshenv
ln -s $GYST_PATH/terminal/zshenv_global /etc/zsh/zshenv

[ -z "$GYST_PATH" ] && exit 1
SCRIPT_PATH=$(dirname $(realpath -s $0))

if [ -f /etc/zsh/zshrc ] ; then
  rm /etc/zsh/zshrc
fi
ln -s $GYST_PATH/terminal/zshrc_global /etc/zsh/zshrc

if [ -f ~/.oh-my-zsh ] ; then
  curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

if [ ! -d ~/.config ] || [ ! -d ~/.config/nvim ] ; then
  mkdir ~/.config
  ln -s $GYST_PATH/terminal/nvim ~/.config
fi
nvim +PlugInstall +qa
