#! /bin/sh
if [[ ! -d $HOME/.config ]]; then
  echo "Creating config directory in $HOME/.config/"
  mkdir $HOME/.config
fi

if [[ ! -d $HOME/.config/nvim/plugged ]]; then
  echo "Installing vim plug"
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi



for f in $HOME/.dotfiles/dotfiles/*
do
  if [[ -f $f ]]; then
    ln -s $f $HOME/.$(basename $f)  #statements
  fi
done

if [[ -f $HOME/.dotfiles/bash/bash_profile.sh ]]; then
  ln -s $HOME/.dotfiles/bash/bash_profile.sh $HOME/.bash_profile
fi

if [[ -f /usr/local/Cellar/neovim/0.2.0_1/share/nvim/runtime/colors ]]; then
  rm -rf /usr/local/Cellar/neovim/0.2.0_1/share/nvim/runtime/colors
fi

if [[ -d $HOME/.dotfiles/nvim ]]; then
  ln -s $HOME/.dotfiles/nvim ~/.config/
fi

install_powerline_fonts() {
  git clone https://github.com/powerline/fonts.git --depth=1
  if [[ -d $HOME/.dotfiles/fonts ]]; then
    cd fonts
    ./install.sh
  fi
  cd .. && rm -rf fonts
}

install_powerline_fonts

echo "Don't half ass two things, whole ass one thing. - R. Swanson"
