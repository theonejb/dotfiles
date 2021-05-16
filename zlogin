alias alif='awless list instances --filter'

path=("$HOME/.rvm/bin" "/opt/homebrew/opt/ruby/bin" "$HOME/.local/bin" $path)
export PATH

ZSH_TMUX_FIXTERM=false
export ZSH_TMUX_FIXTERM

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[ -s "/Users/asadjb/.scm_breeze/scm_breeze.sh" ] && source "/Users/asadjb/.scm_breeze/scm_breeze.sh"