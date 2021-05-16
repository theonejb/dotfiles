# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Disable theme because we are using the Pure prompt
ZSH_THEME=""

# Which plugins would you like to load?
plugins=(common-aliases tmux)

source $ZSH/oh-my-zsh.sh

# Pure prompt
#fpath=( "$HOME/.pure-prompt" $fpath )
#autoload -U promptinit; promptinit
#prompt pure

eval "$(starship init zsh)"

# User config below here

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias vim=nvim

function setup_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
}

# Awless aliases
function setup_awless() {
    source /usr/local/Cellar/awless/0.1.11/share/zsh/site-functions/_awless
}

alias -g DC='/Users/asadjb/Programming/Credentials/DevCon/SSHKeys/jibran.pem'
alias alif='awless list instances --filter'

function secureUpload() {
    password=$(openssl rand -hex 12)
    if [[ ! -f $1 ]]
    then
        exit "$1 is not a regular file"
    fi

    gpg --batch --pinentry-mode loopback --passphrase $password --output $2 -c $1
    
    uploadedUrl=$(curl --upload-file ./$2 https://transfer.sh/$2)

    echo "Url: $uploadedUrl"
    echo "Password: $password"

    rm -i $2
}

[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"
