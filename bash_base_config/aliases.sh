alias ..="cd .."
alias b="brazil"
alias bb="brazil-build"
alias openbash="nvim ~/.dotfiles/bash/bash_profile.sh"
alias browse="hub browse"
alias c="clear"
alias deactivate="source deactivate"
alias dotfiles="cd ~/.dotfiles"
alias g="git"
alias ga="gitAddFunction"
alias gs="git status"
alias gc="git commit -v"
alias gb="git checkout -b"
alias gac="git add . && git commit -m"
alias gclean="git branch --merged | egrep -v '(^\*|production|main)' | xargs git branch -d"
alias home="cd ~"
alias hidedotfiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app"
alias ls="ls -GFh"
alias master="git checkout master"
alias notes="cd ~/dev_notes/"
alias dev_desktop="unison Workplace"
alias production="git checkout production"
alias main="git checkout main"
alias reload="source ~/.bash_profile"
alias runexpress="DEBUG=myapp:* npm start --scripts-prepend-node-path"
alias showdotfiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app"
alias vim="nvim"
alias vi="nvim"
alias wp="cd ~/workplace"
alias aws2="/usr/local/bin/aws"

pull() {
  if [ $# -eq 0 ]
    then
      BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    else
      BRANCH=${1}
  fi
  git pull origin "${BRANCH}"
}

update_aws() {
  vim $HOME/.aws/credentials
}


login_ecr() {
  aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 947618278001.dkr.ecr.us-west-2.amazonaws.com
}
