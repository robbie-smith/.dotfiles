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

HOMEBREW_PREFIX="/usr/local"

if [ -d "$HOMEBREW_PREFIX" ]; then
  # -r flag checks if it is readable by the user
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
    echo "Updating $@"
    gem update "$@"
  else
    echo "Installing $@"
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
brew update --force
brew bundle install -v --no-lock

# shellcheck disable=SC1090
PYTHON2_VERSION=2.7.17
PYTHON3_VERSION=3.7.0
RUBY_VERSION=2.6.0
export PATH="$HOME/.rbenv/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

install_ruby() {
  fancy_echo "Installing ruby version $RUBY_VERSION"
  rbenv install -l
  rbenv install $RUBY_VERSION
  rbenv rehash
  echo "Setting your ruby version to $RUBY_VERSION. Using the rbenv global command."
  rbenv global $RUBY_VERSION
}

install_python() {
  pyenv install -l
  pyenv install $1
  pyenv rehash
}

if `rbenv global $RUBY_VERSION`; then
  echo "Ruby version $RUBY_VERSION is installed."
else
  install_ruby
  eval "$(rbenv init -)"
fi

installed_python_versions=($(pyenv versions --bare))
for version in "${installed_python_versions[@]}";
do
  if [[ $version != $PYTHON2_VERSION ]] || [[ $version != $PYTHON3_VERSION ]]; then
    echo "Installing python version $version"
    install_python $version
    eval "$(pyenv init -)"
  fi
done
pyenv global $PYTHON3_VERSION

gem update
gem_install_or_update "bundler"
gem_install_or_update "neovim"
gem_install_or_update "pry"

install_neovim_for_python() {
  pyenv local $PYTHON2_VERSION
  echo "Installing pip2 for neovim...\c"
  pip2 install neovim
  pyenv local $PYTHON3_VERSION
  echo "Installing pip3 for neovim...\c"
  pip3 install neovim

  if [[ -e /usr/local/bin/pip3 ]]; then
    /usr/local/bin/pip3 install neovim
  fi

}

update_bash(){
  echo "Adding the new bash to the list of allowed shells..."
  sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
  echo "Switching to the new shell..."
  chsh -s /usr/local/bin/bash
}

install_neovim_for_python
# update_bash

packages=(
"apache-airflow"
"awscli"
"aws-shell"
"boto3"
"botocore"
"flake8"
"Flask"
"ipdb"
"ipython"
"pandas"
"pyspark"
"pytest"
"numpy"
"virtualenv"
)

for package in "${packages[@]}"
do
  if ! pip3 show $package -V > /dev/null; then
    echo Installing $package...
    echo ===============================
    pip3 install $package
    echo Finished installing $package...
    echo ===============================
  else
    echo "$package is already installed"
  fi
done
