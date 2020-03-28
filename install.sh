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
brew bundle install

# shellcheck disable=SC1090
PYTHON2_VERSION="2.7.17"
PYTHON3_VERSION="3.7.0"
RUBY_VERSION="2.6.0"
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
install_python_2() {
  pyenv install -l
  pyenv install $PYTHON2_VERSION
  pyenv rehash
}
install_python_3() {
  pyenv install -l
  pyenv install $PYTHON3_VERSION
  pyenv rehash
  echo "Setting your python version to $PYTHON3_VERSION. Using the pyenv global command."
  pyenv global $PYTHON3_VERSION
}

if `rbenv global $RUBY_VERSION`; then
  echo "Ruby version $RUBY_VERSION is installed."
else
  install_ruby
  eval "$(rbenv init -)"
fi

if `pyenv global $PYTHON2_VERSION`; then
  echo "Python 2 version $PYTHON2_VERSION is installed."
else
  install_python_2
  eval "$(pyenv init -)"
fi

if `pyenv global $PYTHON3_VERSION`; then
  echo "Python 3 version $PYTHON3_VERSION is installed."
else
  install_python_3
  eval "$(pyenv init -)"
fi

gem update
gem_install_or_update "bundler"
gem_install_or_update "neovim"
gem_install_or_update "pry"

install_python_for_neovim() {
  pyenv local 2.7.17
  echo "Installing pip2 for neovim...\c"
  pip2 install neovim
  pyenv local 3.7.0
  echo "Installing pip3 for neovim...\c"
  pip3 install neovim

  if [[ -f /usr/local/bin/pip3 ]]; then
    /usr/local/bin/pip3 install neovim
  fi

}

update_bash(){
  echo "Adding the new bash to the list of allowed shells..."
  sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
  echo "Switching to the new shell..."
  chsh -s /usr/local/bin/bash
}

install_python_for_neovim
update_bash

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
  echo Installing $package...
  echo ===============================
  pip3 install "$package"
  echo Finished installing $package...
  echo ===============================
done
