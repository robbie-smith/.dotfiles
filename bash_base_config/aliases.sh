alias ..="cd .."
alias b="brazil"
alias bb="brazil-build"
alias bbr_clean="brazil-recursive-cmd --allPackages --reverse --continue brazil-build clean"
alias clean_build="brazil-build clean && brazil-build"
alias openbash="nvim ~/.dotfiles/bash/bash_profile.sh"
alias browse="hub browse"
alias c="clear"
alias deactivate="source deactivate"
alias dotfiles="cd ~/.dotfiles"
alias g="git_recursive_sequential"
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
alias aws2="/usr/local/bin/aws"

# git_recursive () { find -follow -name .git -type d -execdir git "$@" \; }

git_recursive_sequential() {
  # Function to create a dynamic separator based on the directory length
  generate_separator() {
    local dir_length=${#1}
    printf '=%.0s' $(seq 1 "$dir_length")
    echo
  }

  # Check if the current directory is already a git repository
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    git "$@"
    return
  fi

  # If not, find all .git directories and run git commands sequentially
  find -L . -name .git -type d -print0 | \
    while IFS= read -r -d '' gitdir; do
      (
        cd "$gitdir/.." || exit
        separator=$(generate_separator "$(pwd)")
        echo "$separator"
        echo "Current Directory: $(pwd)"
        echo "Running: git $*"
        echo "$separator"
        git "$@"
        echo "$separator"
        echo "Done in $(pwd)"
        echo "$separator"
        echo
      )
    done
}

# Function to list AWS profiles using FZF and set the selected profile
function set_aws_profile() {
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
    selected_profile=$(echo "$profiles" | fzf --prompt="Select AWS Profile: ")

    if [[ -n "$selected_profile" ]]; then
        export AWS_PROFILE="$selected_profile"
        echo "AWS_PROFILE set to '$selected_profile'"
    else
        echo "No profile selected."
    fi
}

gb() {
  if [ -z "$1" ]; then
    echo "Error: Please provide a branch name."
    return 1
  fi

  g checkout -b "$1"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to create or switch to branch '$1'."
    return 1
  fi

  g branch --set-upstream-to=origin/mainline "$1" 2>/dev/null
  if [ $? -ne 0 ]; then
    echo "Error: Failed to set upstream to 'origin/mainline'."
    return 1
  fi

  echo "Branch '$1' created and set to track 'origin/mainline'."
}



bbr() {
  brazil-recursive-cmd --allPackages --continue brazil-build
}

brazil_setup_mac() {
  brazil ws clean
  brazil ws sync --md
  brazil setup platform-support
}


compare() {
  hub compare `git rev-parse --abbrev-ref HEAD`
}

pr() {
  # hub pull-request -l "Needs Code Review,Needs Testing,#squad-insights" -o
  # hub pull-request -o
  cr --new-review --all --parent mainline -o
}

update_pr() {
  if [ -z "$1" ]; then
    echo "Error: Please provide a CR-####."
    return 1
  fi
  cr --all --update-review $1
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

ada_setup() {
    local role="IibsAdminAccess-DO-NOT-DELETE"  # Default role
    local account_number=""
    local profile=""
    local region=""

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
            -r|--region)
                region="$2"
                shift 2
                ;;
            *)
                echo "Usage: ada_setup -p <profile> -a <account_number> [-r <region>]"
                return 1
                ;;
        esac
    done

    # Prompt for account number if not provided
    if [ -z "$account_number" ]; then
        read -p "Enter the account number: " account_number
    fi

    # Prompt for profile if not provided
    if [ -z "$profile" ]; then
        read -p "Enter the profile name: " profile
    fi

    # Prompt for region if not provided
    if [ -z "$region" ]; then
        read -p "Enter the AWS region (default: us-east-1): " region
        region=${region:-us-east-1}  # Default to us-east-1 if no input
    fi

    echo "Adding credentials for account: $account_number, profile: $profile, region: $region with role: $role"

    # Run the ADA credentials add command with the provided account number, profile, and role
    if ada profile add --account "$account_number" --profile "$profile" --region "$region" --provider conduit --role "$role"; then
        echo "Profile successfully added."
    else
        echo "Failed to add profile."
        return 1
    fi
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

deploy() {
  # Find the directory containing cdk.json by searching downwards, excluding certain directories
  export STAGE="dev"
  export AWS_DEV_ACCOUNT="148761656253"
  export AWS_DEV_REGION="us-west-2"
  # export STAGE="beta"
  # export AWS_DEV_ACCOUNT="593793066741"
  # export AWS_DEV_REGION="us-east-1"

  CDK_DIR=$(find . \
    \( -type d -name node_modules -o -name .git -o -name dist -o -name build \) -prune \
    -o -type f -name 'cdk.json' -print -quit | xargs dirname)

  if [ -z "$CDK_DIR" ]; then
    echo "cdk.json not found in the current directory or any subdirectories."
    return 1
  fi

  # Save the current directory
  CURRENT_DIR="$(pwd)"

  # Change into the CDK directory if not already there
  if [ "$CURRENT_DIR" != "$(cd "$CDK_DIR" && pwd)" ]; then
    cd "$CDK_DIR" || { echo "Failed to change directory to $CDK_DIR"; return 1; }
  fi

  # Run the command
  brazil-build cdk synth 2>&1 | \
  grep 'Supply a stack id' | \
  sed 's/.*(\(.*\)).*/\1/' | \
  tr ', ' '\n' | \
  fzf --prompt="Select a stack to deploy: " | \
  xargs -I {} sh -c 'brazil-build cdk deploy "{}" < /dev/tty > /dev/tty 2> /dev/tty'

  # Return to the original directory if we changed directories
  if [ "$CURRENT_DIR" != "$(pwd)" ]; then
    cd "$CURRENT_DIR" || { echo "Failed to return to directory $CURRENT_DIR"; return 1; }
  fi
}

bb_clean() {
  # brazil-recursive-cmd --allPackages --reverse --continue brazil-build clean
  for dir in */ ; do
    if [ -d "$dir" ]; then
      echo "Entering $dir..."
      cd "$dir" || continue  # Change into the directory or skip if it fails

      echo "================================================="
      echo "Running Command"
      # Example command: clean up any .tmp files
      brazil-build clean
      cd ..  # Return to the parent directory
    fi
  done
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

