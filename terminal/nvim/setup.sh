#!/bin/sh

GYST_PATH="${GYST_PATH:-/gyst}"
. $GYST_PATH/common_fn.sh

package_install neovim
cleanup_installer

ln_replace $GYST_PATH/terminal/nvim/vimrc_global /etc/nvim/init.vim
ln_replace $GYST_PATH/terminal/nvim/plug_vim_global /etc/nvim/site/autoload/plug.vim

nvim +PlugInstall +qa
