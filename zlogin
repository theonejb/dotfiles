path+=("$HOME/.platformio/penv/bin" "$HOME/.local/bin" "$HOME/Programming/go/bin" "$HOME/snap/flutter/common/flutter/bin")

path+=("$HOME/.pyenv/bin:")

eval "$($HOME/.pyenv/bin/pyenv init -)"
eval "$($HOME/.pyenv/bin/pyenv virtualenv-init -)"

fpath+=~/.zsh_functions

[ -s "$HOME/.shell-no-scm" ] && source "$HOME/.shell-no-scm" 

source "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH
