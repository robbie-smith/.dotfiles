alias ..="cd .."
alias openbash="nvim ~/.dotfiles/bash/bash_profile.sh"
alias browse="hub browse"
alias c="clear"
alias deactivate="source deactivate"
alias dotfiles="cd ~/.dotfiles"
alias g="git"
alias gs="git status"
alias gc="git commit -v"
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

# Function to list AWS profiles using FZF and set the selected profile
function aws_profile() {
    # Ensure FZF is installed
    if ! command -v fzf &>/dev/null; then
        echo "fzf is not installed. Please install fzf first."
        return 1
    fi

    # Get a list of AWS profiles
    profiles=$(aws configure list-profiles 2>/dev/null)

    if [[ -z "$profiles" ]]; then
        echo "No AWS profiles found."
        return 1
    fi

    # Use FZF to select a profile
    selected_profile=$(echo "$profiles" | sort | fzf --prompt="Select AWS Profile: ")

    if [[ -n "$selected_profile" ]]; then
        export AWS_PROFILE="$selected_profile"
        echo "AWS_PROFILE set to '$selected_profile'"
    else
        echo "No profile selected."
    fi
}

compare() {
  hub compare `git rev-parse --abbrev-ref HEAD`
}

pr() {
  # hub pull-request -l "Needs Code Review,Needs Testing,#squad-insights" -o
  # hub pull-request -o
  cr --new-review --all --parent mainline -o
}

activate() {
    # The name of the virtual environment
    local venv_name="$1"

    # Check if the virtual environment already exists
    if pyenv virtualenvs --bare | grep -q "^${venv_name}\$"; then
        # If the virtual environment exists, activate it
        echo "Activating virtual environment '${venv_name}'..."
        pyenv activate "${venv_name}"
    else
        # If the virtual environment does not exist, create it and activate it
        echo "Virtual environment '${venv_name}' does not exist. Creating it..."
        pyenv virtualenv "${venv_name}"
        pyenv activate "${venv_name}"
    fi
}

# docker_clean() {
#   docker rmi $(docker images -f "dangling=true" -q -f)
# }


# Correct function syntax with proper curly braces

function gpush() {
  # Get the current branch name
  BRANCH=$(git rev-parse --abbrev-ref HEAD)

  # Define the restricted mainline branches
  MAINLINE_BRANCHES=("main" "master" "mainline")

  # Check if the current local branch is restricted
  if [[ " ${MAINLINE_BRANCHES[@]} " =~ " ${BRANCH} " ]]; then
    echo "Error: Pushes from the '${BRANCH}' branch are not allowed!"
    return 1  # Non-zero exit to indicate failure
  fi

  # Extract the remote branch from the push command (if any)
  REMOTE_BRANCH=$(git config --get branch.${BRANCH}.merge | sed 's|refs/heads/||')

  # Check if the remote branch is a restricted branch
  if [[ " ${MAINLINE_BRANCHES[@]} " =~ " ${REMOTE_BRANCH} " ]]; then
    echo "Error: Pushes to the '${REMOTE_BRANCH}' branch are not allowed!"
    return 1  # Non-zero exit to indicate failure
  fi

  # Proceed with the push if all checks pass
  git push -u origin "${BRANCH}"
}

pull() {
  # Get the current branch if no argument is passed
  if [ $# -eq 0 ]; then
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
  else
    BRANCH=${1}
  fi

  # Check if the branch has a remote tracking branch
  TRACKING_BRANCH=$(git rev-parse --abbrev-ref --symbolic-full-name "@{u}" 2>/dev/null)

  if [ -z "${TRACKING_BRANCH}" ]; then
    echo "Error: No remote tracking branch set for '${BRANCH}'."
    echo "Set the upstream branch with:"
    echo "  git branch --set-upstream-to origin/${BRANCH}"
    return 1
  fi

  # Pull from the remote tracking branch
  git pull
}

# Auth is IAM Identity Center (SSO) now -- short-lived creds cached under
# ~/.aws/sso/cache, and no ~/.aws/credentials file at all. This used to open
# that file in vim, which would just create an empty one.
update_aws() {
  ${EDITOR:-nvim} "$HOME/.aws/config"
}

# Refresh expired SSO creds. Everything hangs off the one sso-session.
aws_login() {
  aws sso login --sso-session foundry24
}

# Account is resolved at call time rather than hardcoded -- this pointed at
# 947618278001 for a long time, an account that isn't even in this org.
login_ecr() {
  local region="${1:-us-west-2}"
  local account
  account="$(aws sts get-caller-identity --query Account --output text)" || {
    echo "Not authenticated. Run: aws_login" >&2
    return 1
  }
  aws ecr get-login-password --region "$region" \
    | docker login --username AWS --password-stdin \
        "${account}.dkr.ecr.${region}.amazonaws.com"
}

# Colorized man command
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

