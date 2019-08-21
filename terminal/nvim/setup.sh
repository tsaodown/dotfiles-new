#!/bin/sh

GYST_PATH="${GYST_PATH:-/gyst}"
. $GYST_PATH/common_fn.sh

package_install neovim
cleanup_installer

[ -L /etc/nvim/init.vim ] && rm /etc/nvim/init.vim
[ ! -d /etc/nvim ] && mkdir /etc/nvim
[ ! -L /etc/nvim/init.vim ] && ln -s $GYST_PATH/terminal/nvim/vimrc_global /etc/nvim/init.vim
[ -L /etc/nvim/site/autoload/plug.vim ] && rm /etc/nvim/site/autoload/plug.vim
[ ! -d /etc/nvim/site/autoload ] && mkdir -p /etc/nvim/site/autoload
[ ! -L /etc/nvim/site/autoload/plug.vim ] && ln -s $GYST_PATH/terminal/nvim/plug_vim_global /etc/nvim/site/autoload/plug.vim

nvim +PlugInstall +qa
