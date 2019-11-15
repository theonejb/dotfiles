# Path to your oh-my-zsh installation.
export ZSH="/Users/asadjb/.oh-my-zsh"

# Disable theme because we are using the Pure prompt
ZSH_THEME=""

# Which plugins would you like to load?
plugins=(common-aliases tmux)

source $ZSH/oh-my-zsh.sh

# Pure prompt
fpath=( "$HOME/.pure-prompt" $fpath )
autoload -U promptinit; promptinit
prompt pure

# User config below here

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

path+=('/Users/asadjb/.local/bin' '/Users/asadjb/Programming/go/bin')

alias hl=hledger
export LEDGER_FILE=~/Dropbox/Ledgers/current.journal

alias vim=nvim

# Android SDK setup for Ionic
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
path+=('$ANDROID_SDK_ROOT/tools/bin' '$ANDROID_SDK_ROOT/platform-tools' '$ANDROID_SDK_ROOT/emulator' '$ANDROID_SDK_ROOT/build-tools/28.0.3')
#export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
#export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
#export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
#export PATH=$PATH:$ANDROID_SDK_ROOT/build-tools/28.0.3/

function setup_jenv() {
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
}

function setup_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
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

export GOPATH='/Users/asadjb/Programming/go'

export PATH

[ -s "/Users/asadjb/.shell-no-scm" ] && source "/Users/asadjb/.shell-no-scm" 

[ -s "/Users/asadjb/.scm_breeze/scm_breeze.sh" ] && source "/Users/asadjb/.scm_breeze/scm_breeze.sh"
