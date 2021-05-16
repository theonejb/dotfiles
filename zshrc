# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/asadjb/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(common-aliases tmux)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

alias alif='awless list instances --filter'

path=("$HOME/.rvm/bin" "/opt/homebrew/opt/ruby/bin" $path)
export PATH

ZSH_TMUX_FIXTERM=false
export ZSH_TMUX_FIXTERM