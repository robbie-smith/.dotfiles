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
alias home="cd ~"
alias hidedotfiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias ls="ls -GFh"
alias pr="hub pull-request -l \"Needs Code Review\", \"Needs Testing\", \"#squad-insights\" -o "
alias procore="cd ~/Dev/procore/"
alias makepr="hub pull-request -o -F ~/.dotfiles/PULL_REQUEST_TEMPLATE.md | pbcopy -l \"Needs Code Review\", \"Needs Testing\", \"#squad-insights\" "
alias show='ls'
alias showdotfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias reload='source ~/.bash_profile'
alias runexpress="DEBUG=myapp:* npm start --scripts-prepend-node-path"
alias run_hydra="cd ~/Dev/procore/hydra_clients/insights && yarn start"
alias run_insights="cd ~/Dev/procore && DEV_MODE=insights bin/rails s"
alias run_hydra_proc="DEV_MODE=insights foreman start -f Procfile.hydra"
alias run_wrench="cd ~/Dev/procore/wrench/ && HOST=localhost PORT=8080 npm run dev"
alias vim='nvim'
alias vi='nvim'
