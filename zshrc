# Path to your oh-my-zsh installation.
export ZSH="/Users/asadjb/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=()

source $ZSH/oh-my-zsh.sh

# User config below here

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias hl=hledger
export LEDGER_FILE=~/Dropbox/Ledgers/current.journal

[ -s "/Users/asadjb/.scm_breeze/scm_breeze.sh" ] && source "/Users/asadjb/.scm_breeze/scm_breeze.sh"
