alias ..='cd ..'
alias be='bundle exec'
alias back='cd -'
alias openbash='nvim ~/.dotfiles/bash/bash_profile.sh'
alias browse="hub browse"
alias c='clear'
alias dev="cd ~/Dev/"
alias dotfiles="cd ~/.dotfiles && nvim"
alias drills="cd ~/exercism"
alias g='git'
alias ga="gitAddFunction"
alias gs="git status"
alias gcm="git commit -m"
alias gpo="git push origin"
alias gb="git checkout -b"
alias gc="git checkout"
alias gmaster="git checkout master"
alias gac="git add . && git commit -m"
alias gpom="git pull origin master"
alias pull="git pull"
alias home="cd ~"
alias hidedotfiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias login_dev_db='pgcli procore_lite1 -h 192.168.41.240 -U procore_db'
alias ls="ls -GFh"
alias procore="cd ~/Dev/procore/"
alias notes="cd ~/dev/work_notes/ && nvim"
alias show='ls'
alias showdotfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias reload='source ~/.bash_profile'
alias runexpress="DEBUG=myapp:* npm start --scripts-prepend-node-path"
alias run_hydra="cd ~/Dev/procore/hydra_clients/insights && yarn start"
alias run_insights="cd ~/Dev/procore && spring stop && DEV_MODE=insights bin/rails s"
alias run_hydra_proc="DEV_MODE=insights foreman start -f Procfile.hydra"
alias run_wrench="cd ~/Dev/procore/wrench/ && HOST=localhost PORT=8080 npm run dev"
alias vim='nvim'
alias vi='nvim'
