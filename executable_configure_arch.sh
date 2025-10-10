sudo pacman -S \
  httpie \
  act \
  extra/zellij \
  extra/direnv \
  extra/git-lfs \
  extra/terraform extra/tflint \
  extra/aws-cli-v2 \
  extra/ast-grep \
  extra/ttf-jetbrains-mono-nerd

if [[ ! -v FLYCTL_INSTALL ]] ; then
  curl -L https://fly.io/install.sh | sh
fi

if [[ ! -d $HOME/.oh-my-zsh ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ ! -d $HOME/.scm_breeze ]]; then
  git clone https://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
fi
