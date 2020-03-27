[[ -s ~/.dotfiles/bash/bashrc ]] && source ~/.dotfiles/bash/bashrc
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"
export BASH_SILENCE_DEPRECATION_WARNING=1
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

function pr()
{
  # hub pull-request -l "Needs Code Review,Needs Testing,#squad-insights" -o
  hub pull-request -o
}

function compare() {
  hub compare `git rev-parse --abbrev-ref HEAD`
}


function md () { mkdir -p "$@" && cd "$@";}

export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"

# added by Anaconda3 5.0.1 installer
export PATH="/Users/robbiesmith/anaconda3/bin:$PATH"


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"


# added by Snowflake SnowSQL installer v1.0
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
