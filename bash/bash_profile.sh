[[ -s ~/.dotfiles/bash/bashrc ]] && source ~/.dotfiles/bash/bashrc
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"
export PATH=$PATH:/Users/rsmith/Connect/bin
export EDITOR=nvim
function gpush() {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  git push -u origin "${BRANCH}"
}

function lazygit() {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  git add .
  git commit -m "$1"
  git push -u origin "${BRANCH}"
}

function compare() {
  hub compare `git rev-parse --abbrev-ref HEAD`
}

function lazyrails() {
  rails new "$1" -d postgresql --skip-turbolinks --skip-spring -T
  cd "$1"
  echo "
  group :test do
  gem 'rack_session_access'
  gem 'capybara'
  gem 'launchy'
  gem 'shoulda-matchers'
 end
  group :development, :test do
    gem 'rspec-rails'
    gem 'database_cleaner'
    gem 'byebug', platform: :mri
    gem 'factory_girl_rails'
    gem 'pry'
    gem 'pry-byebug'
  end " >> Gemfile
  bundle install
  rails g rspec:install
}

function md () { mkdir -p "$@" && cd "$@";}

function codi() {
  local syntax="${1:-python}"
  shift
  vim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}
export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"
