# -s flag checks that the file is > 0 bytes
[[ -s ~./dotfiles/bash/bashrc ]] && source ~./dotfiles/bash/bashrc
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"
export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR=nvim

function gpush() {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
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

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
