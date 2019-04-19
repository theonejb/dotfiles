# vim: filetype=sh

# Prompt symbol
COMMON_PROMPT_SYMBOL="❯"

# Left Prompt
PROMPT='$(common_current_dir)$(common_return_status)'

# Current directory
common_current_dir() {
  echo -n "%{$fg[cyan]%}%c "
}

# Prompt symbol
common_return_status() {
  echo -n "%(?.%F{green}.%F{red})$COMMON_PROMPT_SYMBOL%f "
}
