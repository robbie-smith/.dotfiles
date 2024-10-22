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


#ga() {
#  is_in_git_repo || return
#
#  # Fetch the list of files (both staged and unstaged) from git status
#  files=$(git status --porcelain | grep -v HEAD) &&
#
#  # Use fzf-tmux to select a file, show a delta diff preview, and add the selected file
#  file=$(echo "$files" | \
#    fzf-tmux -d $(( 2 + $(wc -l <<< "$files") )) +m --ansi \
#      --preview='git diff --color=always -- {-1} | delta' \
#      --preview-window=right:50%) &&
#
#  # Add the selected file to staging
#  git add $(echo "$file" | sed "s/.* //")
#}

ga() {
  is_in_git_repo || { echo "Not in a git repository"; return; }

  local files selected action file separator

  files=$(git status --porcelain | sed s/^...// | sort -u)

  if [ -z "$files" ]; then
    echo "No modified files found."
    return
  fi

  # Function to generate a separator
  generate_separator() {
    local term_width=$(tput cols)
    printf '%*s\n' "${term_width}" '' | tr ' ' '='
  }

  while true; do
    selected=$(echo "$files" | \
      fzf --ansi \
          --preview 'git diff --color=always -- {1} | delta --side-by-side -w ${FZF_PREVIEW_COLUMNS:-$COLUMNS}' \
          --preview-window=down:50% --reverse \
          --height 80% \
          --header "Press 'r' to reset (unstage), 'u' to restore (undo changes), 'a' to add (stage), or 'esc' to exit" \
          --bind "r:execute(echo reset {1})+reload(echo \"$files\")" \
          --bind "u:execute(echo restore {1})+reload(echo \"$files\")" \
          --bind "a:execute(echo add {1})+reload(echo \"$files\")" \
          --bind "esc:abort" \
          --expect=r,u,a,esc)

    action=$(echo "$selected" | head -n1)
    file=$(echo "$selected" | tail -n1)

    if [ -n "$file" ]; then
      separator=$(generate_separator)
      case "$action" in
        r)
          git restore --staged -- "$file"
          echo "Unstaged: $file"
          echo "$separator"
          ;;
        u)
          git restore -- "$file"
          echo "Restored: $file"
          echo "$separator"
          ;;
        a)
          git add -- "$file"
          echo "Staged: $file"
          echo "$separator"
          ;;
        esc)
          git status
          break
          ;;
      esac
      files=$(git status --porcelain | sed s/^...// | sort -u)
    else
      echo "No file selected. Please try again or press 'esc' to quit."
      echo "$(generate_separator)"
    fi
  done
}






gr() {
  files=$(git diff --name-only)

  file=$(echo "$files" | \
    fzf-tmux -d $(( 2 + $(wc -l <<< "$files") )) +m --ansi \
      --preview='git diff --color=always -- {-1} | delta' \
      --preview-window=right:50%) &&

  # Add the selected file to staging
  git restore --staged $(echo "$file" | sed "s/.* //") || git restore $(echo "$file" | sed "s/.* //")
  # esac
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
