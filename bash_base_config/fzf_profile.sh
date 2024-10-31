export FZF_DEFAULT_OPTS='--height 50% --reverse --color fg:188,bg:233,hl:103,fg+:222,bg+:234,hl+:104
--color info:183,prompt:110,spinner:107,pointer:167,marker:215'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g'!{**/node_modules/*,**/.git/*}''
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow -g'!{**/node_modules/*,**/.git/*}''
csi() {
  echo -en "\x1b[$@"
}

fzf-down() {
fzf --height 50% "$@"
}

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fda() {
  DIR=`find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}

fd() {
  DIR=`find * -maxdepth 0 -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}

cdf() {
  local file
  local dir
  file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  IFS=$'\n' read -d '' -r -a out < <(fzf-tmux --header='ctrl-e:editor, ctrl-o:open finder' --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
  key=${out[0]}
  file=${out[1]}
  if [ -n "$file" ]; then
    if [ "$key" = ctrl-o ]; then
      open -R "$file"
    else
      ${EDITOR:-vim} "$file"
    fi
  fi
}

# fdh - including hidden directories
fdh() {
  DIR=`find ${1:-.} -type d 2> /dev/null | fzf-tmux` && cd "$DIR"
}

# cdu - cd to selected parent directory
cdu() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$(pwd)}") | fzf-tmux --tac)
  cd "$DIR"
}

# cdf - cd into the directory of the selected file
cdf() {
  local file
  local dir
  file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# fh - search history and enter to run command
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

##Git Functions
# gcrb - checkout git branch (including remote branches)
gcrb() {
  local branches branch
  git fetch origin
  branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
  fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

gkconsole() {
  local options=(
    "gk-analyze-all"
    "gk-analyze-guidance"
    "gk-analyze-inconsistencies"
    "gk-analyze-version-set"
    "gk-fix-mv-conflicts"
    "gk-graph"
  )

  local docs=(
    "Analyze all dependencies and automatically fix issues in the workspace."
    "Provide vendor guidance and apply automatic upgrades for dependencies."
    "Detect inconsistent versions across packages and apply fixes."
    "Analyze a given version set and produce a report of problems detected."
    "Interactive tool to fix major version conflicts quickly and easily."
    "Tool to explore and visualize dependency graphs."
  )

  local selected action

  selected=$(printf "%s\n" "${options[@]}" | \
    fzf --ansi \
        --preview "echo 'Command: {}'; echo ''; echo 'Documentation: '; case '{}' in \
                    '${options[0]}') echo '${docs[0]}' ;; \
                    '${options[1]}') echo '${docs[1]}' ;; \
                    '${options[2]}') echo '${docs[2]}' ;; \
                    '${options[3]}') echo '${docs[3]}' ;; \
                    '${options[4]}') echo '${docs[4]}' ;; \
                    '${options[5]}') echo '${docs[5]}' ;; \
                  esac" \
        --preview-window=right:50% --reverse \
        --height 30% \
        --header "Choose a command: 'a': analyze all, 'g': guidance, 'i': inconsistencies, 'v': version set, 'f': fix conflicts, 'd': graph, or 'esc' to exit" \
        --bind "a:execute-silent(echo 'Analyzing all dependencies' && \"${options[0]}\")+abort" \
        --bind "g:execute-silent(echo 'Providing guidance' && \"${options[1]}\")+abort" \
        --bind "i:execute-silent(echo 'Analyzing inconsistencies' && \"${options[2]}\")+abort" \
        --bind "v:execute-silent(echo 'Analyzing version set' && \"${options[3]}\")+abort" \
        --bind "f:execute-silent(echo 'Fixing conflicts' && \"${options[4]}\")+abort" \
        --bind "d:execute-silent(echo 'Exploring dependency graph' && \"${options[5]}\")+abort" \
        --bind "esc:abort" \
        --expect=a,g,i,v,f,d,esc)

  action=$(echo "$selected" | head -n1)
  interactive=" --interactive"

  case "$action" in
    a)
      echo "Running: ${options[0]} "
      eval "${options[0]}"
      ;;
    g)
      echo "Running: ${options[1]} ${interactive}"
      eval "${options[1]} ${interactive}"
      ;;
    i)
      echo "Running: ${options[2]} ${interactive}"
      eval "${options[2]} ${interactive}"
      ;;
    v)
      echo "Running: ${options[3]}"
      eval "${options[3]}"
      ;;
    f)
      echo "Running: ${options[4]}"
      eval "${options[4]}"
      ;;
    d)
      echo "Running: ${options[5]}"
      eval "${options[5]}"
      ;;
    esc)
      echo "Exited."
      ;;
  esac
}

bbconsole() {
  make_deploy() {
      find . -type d -name '*CDK*' | while read -r dir; do
      echo "Changing directories: $dir"
      cd "$dir" || continue
      deploy $1
      cd - > /dev/null
      done
  }
  declare -A options=(
    [build]="brazil-build"
    [clean-assemble]="brazil-build clean && brazil-build assemble"
    [clean-build]="brazil-build clean && brazil-build"
    [make build]="make_deploy build"
    [make deploy]="make_deploy deploy"
    [recursive-clean]="brazil-recursive-cmd --allPackages --reverse --continue brazil-build clean"
    [recursive-build]="brazil-recursive-cmd --allPackages brazil-build"
    [ws-sync]="brazil ws --sync --md"
    [ws-show]="brazil workspace show"
  )

  local selected

  selected=$(printf "%s\n" "${!options[@]}" | sort | \
    fzf --ansi \
        --reverse \
        --height 30% \
        --header $'Choose a command (use arrow keys to navigate, Enter to select, Esc to exit):')

  if [[ -n "$selected" ]]; then
    echo "Running: ${options[$selected]}"
    eval "${options[$selected]}"
  else
    echo "No command selected. Exited."
  fi
}

gconsole() {
  # Check if the current directory is a Git repository
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Managing the current Git repository only."
    repos="."
  else
    # Find all Git repositories recursively from the current directory
    repos=$(find . -type d -name ".git" | sed 's/\/.git$//')
    if [ -z "$repos" ]; then
      echo "No Git repositories found."
      return
    fi
  fi

  # Process each Git repository
  for repo in $repos; do
    echo "Processing repository: $repo"
    cd "$repo" || { echo "Failed to access $repo"; continue; }

    # Check if there are modified or staged files
    local files
    files=$(git status --porcelain | sed 's/^...//' | sort -u)

    # Skip the repo if there are no modified or staged files
    if [ -z "$files" ]; then
      echo "No modified files found in $repo. Skipping."
      cd - > /dev/null
      continue
    fi

    local selected action file separator

    # Function to generate a separator
    generate_separator() {
      local term_width=$(tput cols)
      printf '%*s\n' "${term_width}" '' | tr ' ' '='
    }

    # Function to show git status
    show_git_status() {
      echo "Current git status:"
      git status
      generate_separator
    }

    while true; do
      show_git_status

      # If no files are modified, preview will show the rebase message
      selected=$(echo "$files" | \
        fzf --ansi \
           --preview 'if [ -n "{}" ]; then
                git diff --color=always -- {} | delta --side-by-side -w ${FZF_PREVIEW_COLUMNS:-$COLUMNS};
             else
                echo "No modified files found, but you can still pull and rebase.";
             fi' \
            --preview-window=down:70% --reverse \
            --height 80% \
            --header "Press 'p': pull with rebase, 'a': stage, 'b': blame, 'c': commit, 'd': diff, 'r': reset, 'u': unstage, 'x': delete or 'esc' to exit" \
            --bind "r:execute(git restore -- {1})+reload(echo \"$files\")" \
            --bind "u:execute(git restore --staged -- {1})+reload(echo \"$files\")" \
            --bind "a:execute(git add -- {1})+reload(echo \"$files\")" \
            --bind "x:execute(rm {1}; git rm --cached {1} 2>/dev/null; echo 'Deleted: {1}')+reload(echo \"$files\")" \
            --bind "b:execute(git blame {1} | less > /dev/tty)" \
            --bind "p:execute(git pull origin mainline --rebase && echo 'Rebase complete')+abort" \
            --bind "esc:abort" \
            --expect=r,u,a,b,c,d,p,x,esc)

      action=$(echo "$selected" | head -n1)
      file=$(echo "$selected" | tail -n1)

      if [ -n "$file" ]; then
        separator=$(generate_separator)
        before_status=$(git status --short "$file")
        case "$action" in
          r)
            git restore -- "$file"
            echo "Reset: $file"
            ;;
          u)
            git restore --staged -- "$file"
            echo "Unstaged: $file"
            ;;
          a)
            git add -- "$file"
            echo "Added: $file"
            ;;
          b)
            git blame "$file" | less
            continue
            ;;
          c)
            git commit -v
            echo "Committing: $file"
            ;;
          d)
            git diff --color=always -- "$file" | delta --side-by-side -w ${FZF_PREVIEW_COLUMNS:-$COLUMNS} | less -R -X -S
            ;;
          x)
            read -p "Are you sure you want to delete $file? (y/N) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
              rm "$file"
              git rm --cached "$file" 2>/dev/null
              echo "Deleted: $file"
            else
              echo "Delete cancelled"
            fi
            ;;
          p)
            git pull origin mainline --rebase
            echo "Rebased with mainline"
            ;;
          esc)
            break
            ;;
        esac
        after_status=$(git status  --porcelain -s "$file")
        echo "After:  $after_status"
        echo "$separator"
      fi

      # Refresh modified files list only
      files=$(git status --porcelain | sed s/^...// | sort -u)
    done

    # Return to the original directory if recursion was enabled
    cd - > /dev/null
  done
}
gcb() {
  local tags branches target
  branches=$(
  git branch --color | grep -v HEAD             |
  sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
  sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
  ( echo "$branches") |
  fzf-tmux -l40 -- --no-hscroll --ansi +m -d "\t" -n 2 -1 -q "$*") || return
  git checkout $(echo "$target" | awk '{print $2}')
}

fdb() {
  local tags branches target
  branches=$(
  git branch --color | grep -v HEAD             |
  sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
  sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
  (echo "$branches") |
  fzf-tmux -l40 -- --no-hscroll --ansi +m -d "\t" -n 2 -1 -q "$*") || return
  git branch -D $(echo "$target" | awk '{print $2}')
}
# show commit history, enter to select commit and  ctrl-d to see the diff
gshow() {
  local out shas sha q k
  while out=$(
    git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(green)%C(bold)%cr" "$@" |
    fzf --ansi --multi --no-sort --reverse --query="$q" \
      --print-query --expect=ctrl-d \
      --header='enter:select commit, ctrl-d:diff'); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}

gstash() {
  local out k reflog
  out=(
  $(git stash list --pretty='%C(yellow)%gd %>(14)%Cgreen%cr %C(blue)%gs' |
  fzf --ansi --no-sort --header='enter:show, ctrl-d:diff, ctrl-o:pop, ctrl-y:apply, ctrl-x:drop' \
    --preview='git stash show --color=always -p $(cut -d" " -f1 <<< {}) | head -'$LINES \
    --preview-window=down:50% --reverse \
    --bind='enter:execute(git stash show --color=always -p $(cut -d" " -f1 <<< {}) | less -r > /dev/tty)' \
    --bind='ctrl-d:execute(git diff --color=always $(cut -d" " -f1 <<< {}) | less -r > /dev/tty)' \
    --expect=ctrl-o,ctrl-y,ctrl-x))
  k=${out[0]}
  reflog=${out[1]}
  [ -n "$reflog" ] && case "$k" in
  ctrl-o) git stash pop $reflog ;;
  ctrl-y) git stash apply $reflog ;;
  ctrl-x) git stash drop $reflog ;;
esac
}

#show git history and diff
ghist() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview-window=up:50% --reverse \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -200' |
  grep -o "[a-f0-9]\{7,\}"
}

bind '"\er": redraw-current-line'

#shows diff modified files
gd() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}
