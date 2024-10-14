alias ..="cd .."
alias b="brazil"
alias bb="brazil-build"
alias bbr="brazil-recursive-cmd --allPackages brazil-build"
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


function brazil_setup_mac() {
  brazil ws clean
  brazil ws sync --md
  brazil setup platform-support
}


function compare() {
  hub compare `git rev-parse --abbrev-ref HEAD`
}

function pr()
{
  # hub pull-request -l "Needs Code Review,Needs Testing,#squad-insights" -o
  # hub pull-request -o
  cr --new-review --parent mainline -o
}

function update_pr()
{
  # hub pull-request -l "Needs Code Review,Needs Testing,#squad-insights" -o
  # hub pull-request -o
  cr --new-review --parent mainline -o
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

docker_clean() {
  docker rmi $(docker images -f "dangling=true" -q -f)
}


gb() {
  git checkout -b && git branch -u origin/mainline
}

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

update_credentials() {
    local role="IibsAdminAccess-DO-NOT-DELETE"  # Default role
    local account_number=""
    local profile=""

    # Parse flags
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -a|--account)
                account_number="$2"
                shift 2
                ;;
            -p|--profile)
                profile="$2"
                shift 2
                ;;
            -r|--role)
                role="$2"
                shift 2
                ;;
            *)
                echo "Usage: update_credentials -p <profile> -a <account_number> [-r <role>]"
                return 1
                ;;
        esac
    done

    # Debugging output to see the parsed variables
    echo "Parsed account number: $account_number"
    echo "Parsed profile: $profile"
    echo "Parsed role: $role"

    # Ensure both account number and profile are provided
    if [ -z "$account_number" ] || [ -z "$profile" ]; then
        echo "Error: Both account number (-a) and profile (-p) are required."
        echo "Usage: update_credentials -p <profile> -a <account_number> [-r <role>]"
        return 1
    fi

    echo "Updating credentials for account: $account_number, profile: $profile with role: $role"

    # Run the ADA credentials update command with the provided account number, profile, and role
    if ada credentials update --profile "$profile" --provider conduit --account "$account_number" --role "$role" --once; then
        echo "Credentials updated successfully."
    else
        echo "Failed to update credentials."
        return 1
    fi
}
#
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
