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

set_shell_to_bash() {
  chsh -s /bin/bash
  source $HOME/.bash_profile

}

asdf_ensure_plugin() {
  local plugin_name="$1"
  local plugin_url="$2"

  if ! asdf plugin list | grep -q "^${plugin_name}$"; then
    echo "📦 Adding plugin: $plugin_name"
    asdf plugin add "$plugin_name" "$plugin_url" || {
      echo "❌ Failed to add plugin $plugin_name"; return 1;
    }
  else
    echo "✅ Plugin $plugin_name already added"
  fi
}

asdf_setup_java() {
  local version="${1:-temurin-17.0.8+7}"
  asdf_ensure_plugin "java" "https://github.com/halcyon/asdf-java.git"

  echo "📥 Installing Java $version..."
  asdf install java "$version" || echo "⚠️ Java $version may already be installed"
  asdf global java "$version"
  java -version
}
asdf_setup_python() {
  asdf_ensure_plugin "python" "https://github.com/danhper/asdf-python.git"

  echo "🔍 Finding latest stable Python version..."
  local version
  version=$(asdf list all python | grep -E '^\d+\.\d+\.\d+$' | tail -1)

  if [ -z "$version" ]; then
    echo "❌ Failed to find a valid Python version."
    return 1
  fi

  echo "📥 Installing Python $version..."
  if asdf list python | grep -q "$version"; then
    echo "✅ Python $version already installed"
  else
    asdf install python "$version" || {
      echo "❌ Failed to install Python $version"
      return 1
    }
  fi

  echo "🌍 Setting global Python version to $version"
  asdf set -u python "$version"


  echo "🐍 Current Python version:"
  python --version || echo "⚠️ Python shim may not be active. Try running: asdf reshim python"
}
asdf_setup_ruby() {
  asdf_ensure_plugin "ruby" "https://github.com/asdf-vm/asdf-ruby.git"

  local version
  version=$(asdf list all ruby | grep -E '^\d+\.\d+\.\d+$' | tail -1)

  echo "📥 Installing Ruby $version..."
  asdf install ruby "$version" || echo "⚠️ Ruby $version may already be installed"
  asdf set -u ruby "$version"
  ruby --version
}

asdf_setup_all() {
  asdf_setup_java
  asdf_setup_python
  asdf_setup_ruby
}
create_config_directory
install_vim_plug
symlink_dotfiles
remove_neovim_default_colors
symlink_neovim_to_config_directory
install_powerline_fonts
set_shell_to_bash
asdf_setup_all

echo "Don't half ass two things, whole ass one thing. - R. Swanson"
