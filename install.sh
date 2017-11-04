#! /bin/sh
fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

# shellcheck disable=SC2016

HOMEBREW_PREFIX="/usr/local"

if [ -d "$HOMEBREW_PREFIX" ]; then
  if ! [ -r "$HOMEBREW_PREFIX" ]; then
    sudo chown -R "$LOGNAME:admin" /usr/local
  fi
else
  sudo mkdir "$HOMEBREW_PREFIX"
  sudo chflags norestricted "$HOMEBREW_PREFIX"
  sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
fi

gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    gem update "$@"
  else
    gem install "$@"
  fi
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
  curl -fsS \
    'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
fi

if brew list | grep -Fq brew-cask; then
  fancy_echo "Uninstalling old Homebrew-Cask ..."
  brew uninstall --force brew-cask
fi

fancy_echo "Updating Homebrew formulae ..."
brew update --force # https://github.com/Homebrew/brew/issues/1151
brew bundle --file=- <<EOF
tap "homebrew/services"
tap "universal-ctags/universal-ctags"
tap "caskroom/cask"

# Unix
brew "universal-ctags", args: ["HEAD"]
brew "git"
brew "openssl"
brew "rbenv"
brew "fzf"
brew "tmux"
brew "neovim"
brew "ripgrep"
brew "pgcli"
brew "python2"
brew "python3"
brew "node"
brew "go"
brew "bash"

# Heroku
brew "heroku"

# GitHub
brew "hub"

# Image manipulation
brew "imagemagick"

# Testing
brew "qt@5.5" if MacOS::Xcode.installed?

# Programming language prerequisites and package managers
brew "libyaml" # should come after openssl
brew "coreutils"
brew "yarn"
cask "gpg-suite"

EOF

fancy_echo "Update heroku binary..."
brew unlink heroku
brew link --force heroku

# shellcheck disable=SC1090

install_ruby() {
  rbenv install -l
  echo "Which ruby version would you like to install: \c "
  read word
  fancy_echo "Installing ruby version $word"
  rbenv install $word
  rbenv rehash
  echo "Setting your ruby version to $word. Using the rbenv global command."
  rbenv global $word
}

install_ruby

gem update
echo "Installing bundler..."
gem_install_or_update "bundler"
echo "Installing ruby gem for neovim..."
gem_install_or_update "neovim"
echo "Installing pry..."
gem_install_or_update "pry"

install_python_for_neovim() {
  echo "Installing pip2 for neovim...\c"
  pip2 install neovim
  echo "Installing pip3 for neovim...\c"
  pip3 install neovim
}

install_python_for_neovim

update_bash(){
  echo "Adding the new bash to the list of allowed shells..."
  sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
  echo "Switching to the new shell..."
  chsh -s /usr/local/bin/bash
}

update_bash

number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))

