# zmodload zsh/zprof
export ZSH_DISABLE_COMPFIX=true
export ZSH=$HOME/.oh-my-zsh

###############################################################################
#			      OH_MY_ZSH SETTINGS
###############################################################################

ZSH_THEME="agnoster"
DEFAULT_USER=`whoami`

# CASE_SENSITIVE="true"			# case-sensitive completion
# export UPDATE_ZSH_DAYS=13		# auto update frequency
DISABLE_AUTO_TITLE="true"		# terminal title auto-set
# ENABLE_CORRECTION="true"		# command auto-correction
COMPLETION_WAITING_DOTS="true"		# red waiting dots
DISABLE_UNTRACKED_FILES_DIRTY="true"	# git status shows clean with untracked files
# HIST_STAMPS="mm/dd/yyyy"		# formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# ZSH_CUSTOM=/path/to/new-custom-folder	# zsh custom config files

# Source any settings on the local machine
if [ -f ~/dotfiles/keys ] ; then
  source ~/dotfiles/keys
fi

if [ -f ~/dotfiles/local_settings ] ; then
  source ~/dotfiles/local_settings
fi

SCRIPT_PATH=$(dirname $(realpath -L ~/.zshrc))

# Source antigen for bundles
source "$SCRIPT_PATH/antigen/antigen.zsh"

antigen use oh-my-zsh

# Built-in plugins
antigen bundle git
antigen bundle history
antigen bundle history-substring-search
antigen bundle man
antigen bundle npm

# Custom plugins
antigen bundle hlissner/zsh-autopair
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle bobthecow/git-flow-completion
antigen bundle zpm-zsh/autoenv
antigen bundle unixorn/autoupdate-antigen.zshplugin

antigen apply

bindkey '^ ' autosuggest-accept

###############################################################################
#			         ZSH SETTINGS
###############################################################################

setopt interactivecomments		# allow comment commands
precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

###############################################################################
#			         ENV SETTINGS
###############################################################################

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export LANG=en_US.UTF-8		# set language env

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# source ~/.gulp-autocompletion-zsh/gulp-autocompletion.zsh

umask 007

export VISUAL=$(which nvim)
export EDITOR=$(which nvim)

# Custom aliases
alias rmd='rm -rf'
alias dfh='df -H'
alias psg='ps | grep -v grep | grep'

alias gdh='gd HEAD'
alias gdhh='gd HEAD~1'
alias grm='git rm'
alias gpuo='gp -u origin'
alias gw='cat ~/.oh-my-zsh/plugins/git/git.plugin.zsh | grep'
alias gwt='git worktree'

alias nv=nvim

alias npmi='npm install'

alias doc=docker
alias docm=docker-machine
alias docc=docker-compose

alias her=heroku

# Special keybinds
bindkey "^[D" backward-word
bindkey "^[C" forward-word

export GOOGLE_CLOUD_SDK_ROOT='~/Library/google-cloud-sdk'
# The next line updates PATH for the Google Cloud SDK.
if [ -d '$GOOGLE_CLOUD_SDK_ROOT' ] ; then
  source '$GOOGLE_CLOUD_SDK_ROOT/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -d '$GOOGLE_CLOUD_SDK_ROOT' ] ; then
  source '$GOOGLE_CLOUD_SDK_ROOT/google-cloud-sdk/completion.zsh.inc'
fi

# Added by n-install (see http://git.io/n-install-repo).
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

source $ZSH/oh-my-zsh.sh
# zprof

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
