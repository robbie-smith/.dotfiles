#! /bin/sh

# Most of the code here came from thoughtbot. I adapted it to my needs.
# https://github.com/thoughtbot/laptop

fancy_echo() {
  local fmt="$1"; shift
  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

# shellcheck disable=SC2016
HOMEBREW_PREFIX="/opt/homebrew"

# Install Homebrew if it's not already installed
if ! command -v brew >/dev/null 2>&1; then
  fancy_echo "Installing Homebrew ..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  fancy_echo "Homebrew already installed"
fi

# Ensure Homebrew has the correct ownership
if [ -d "$HOMEBREW_PREFIX" ]; then
  if ! [ -r "$HOMEBREW_PREFIX" ]; then
    sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
  fi
else
  sudo mkdir "$HOMEBREW_PREFIX"
  sudo chflags norestricted "$HOMEBREW_PREFIX"
  sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
fi

fancy_echo "Updating Homebrew formulae ..."
brew update --force

fancy_echo "Installing dependencies from Brewfile ..."
brew bundle install -v --file="./Brewfile"

# Optional Ruby gems helper
gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    echo "Updating $@"
    gem update "$@"
  else
    echo "Installing $@"
    gem install "$@"
  fi
}


# install lazy plugin manager for neovim
if [ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
  git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
else
  echo "Lazy.nvim already installed. Skipping..."
fi

# install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# Define version variables (used later if you install these manually)
PYTHON2_VERSION=2.7.17
PYTHON3_VERSION=3.7.0
RUBY_VERSION=2.6.0
