sudo pacman -S \
  httpie \
  act \
  jujutsu \
  zellij \
  direnv \
  git-lfs \
  terraform extra/tflint \
  aws-cli-v2 \
  ast-grep \
  ttf-jetbrains-mono-nerd \
  wev \
  zeal \
  apparmor \
  ddcutil \
  wget \
  pandoc-cli \
  texlive-latex \
  texlive-latexextra \
  texlive-plaingeneric \
  texlive-fontsrecommended \
  texlive-fontsextra \
  texlive-binextra \
  virtualbox \
  virtualbox-host-modules-arch

yay -S \
  ferdium-bin

if [[ ! -v FLYCTL_INSTALL ]] ; then
  curl -L https://fly.io/install.sh | sh
fi

if [[ ! -d $HOME/.oh-my-zsh ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ ! -d $HOME/.scm_breeze ]]; then
  git clone https://github.com/scmbreeze/scm_breeze.git ~/.scm_breeze
fi
