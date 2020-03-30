#! /bin/sh
create_config_directory(){
  if [[ ! -d $HOME/.config ]]; then
    echo "Creating config directory in $HOME/.config/ ."
    mkdir $HOME/.config
  fi
}

install_vim_plug(){
  if [[ ! -d $HOME/.config/nvim/plugged ]]; then
    echo "Installing vim plug."
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
}

symlink_dotfiles() {
  echo "Symlinking dotfiles."
  for f in $HOME/.dotfiles/dotfiles/*
  do
    local parent_file=$f
    local dotfile=$HOME/.$(basename $f)
    if [[ -e $parent_file ]] && [[ ! -e $dotfile ]]; then
      echo "Symlinking $parent_file to $dotfile."
      ln -s $parent_file $dotfile
    fi
  done
}

remove_neovim_default_colors(){
  local neovim_version=$(nvim -v)
  local parsed_version=${neovim_version:6:6}
  local neovim_colors="/usr/local/Cellar/neovim/$parsed_version/share/nvim/runtime/colors"
  if [[ -d $neovim_colors  ]]; then
    echo "Removing default neovim colors."
    rm -rf $neovim_colors
  fi
}

symlink_neovim_to_config_directory(){
  local nvim_directory=$HOME/.dotfiles/nvim
  if [[ -d $nvim_directory  ]]; then
    echo "Symlinking neovim directory to config directory."
    ln -s $nvim_directory ~/.config/
  fi
}

install_powerline_fonts() {
  git clone https://github.com/powerline/fonts.git --depth=1
  if [[ -d $HOME/.dotfiles/fonts ]]; then
    cd fonts
    ./install.sh
  fi
  cd .. && rm -rf fonts
}

create_config_directory
install_vim_plug
symlink_dotfiles
remove_neovim_default_colors
symlink_neovim_to_config_directory
install_powerline_fonts

echo "Don't half ass two things, whole ass one thing. - R. Swanson"
