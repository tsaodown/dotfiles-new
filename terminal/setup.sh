#!/bin/sh

SCRIPT_PATH=$(dirname $(realpath -s $0))

if [ -f ~/.zshrc ] ; then
  rm ~/.zshrc
fi
ln -s $SCRIPT_PATH/.zshrc ~/.zshrc

if [ -f ~/.oh-my-zsh ] ; then
  curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

if [ ! -d ~/.config ] || [ ! -d ~/.config/nvim ] ; then
  mkdir ~/.config
  ln -s $SCRIPT_PATH/nvim ~/.config
fi
nvim +PlugInstall +qa
