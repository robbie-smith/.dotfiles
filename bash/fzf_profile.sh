export FZF_DEFAULT_OPTS='--height 40% --reverse'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

fd() {
DIR=`find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}

# fda - including hidden directories
fda() {
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

# gcrb - checkout git branch (including remote branches)
gcrb() {
  local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
        fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# gcb - checkout git branch/tag
gcb() {
  local tags branches target
    tags=$(
        git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
        git branch --all | grep -v HEAD             |
        sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
        sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
        (echo "$tags"; echo "$branches") |
        fzf-tmux -l40 -- --no-hscroll --ansi +m -d "\t" -n 2 -1 -q "$*") || return
    git checkout $(echo "$target" | awk '{print $2}')
}

# delete merged branch
gdb() {
  local branches branch
  branches=$(git branch --merged) &&
  branch=$(echo "$branches" | fzf +m) &&
    git branch -d $(echo "$branch" | sed "s/.* //") && fbrd
}

# show commit history, enter to select commit and see the diff
fshow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(green)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d); do
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

# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]
      then
        kill -${1:-9} $pid
        fi
}
# rbenv integration
frb() {
  local rb
    rb=$((echo system; rbenv versions | grep ruby | cut -c 4-) |
        awk '{print $1}' |
        fzf-tmux -l 30 +m --reverse) && rbenv global $rb
}
