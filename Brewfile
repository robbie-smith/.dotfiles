# Brewfile -- shared core
#
# Everything both the personal (Foundry24) and work (Garner) machines need.
# Machine-specific packages live in Brewfile.personal / Brewfile.work.
#
#   ./install.sh personal
#   ./install.sh work
#
# Regenerate a snapshot of a live machine with:  brew bundle dump --describe

tap "universal-ctags/universal-ctags"

# ---------------------------------------------------------------------------
# Shell
# ---------------------------------------------------------------------------
brew "bash"                  # bash 5.x; macOS ships 3.2
brew "bash-completion"
brew "starship"              # prompt, activated in dotfiles/bash_profile
brew "tmux"
brew "fzf"

# ---------------------------------------------------------------------------
# Core CLI
# ---------------------------------------------------------------------------
brew "git"
brew "git-delta"             # git pager, see dotfiles/gitconfig
brew "gh"
brew "jq"
brew "ripgrep"
brew "gnu-sed"               # gsed; BSD sed breaks GNU-style scripts
brew "neovim"
brew "universal-ctags/universal-ctags/universal-ctags", args: ["HEAD"]

# ---------------------------------------------------------------------------
# Languages & runtime managers
#
# mise is the active polyglot manager (see dotfiles/bash_profile).
# pyenv + pyenv-virtualenv are also activated there and currently own python3.
# rustup is installed by install.sh into ~/.cargo, NOT via brew.
# ---------------------------------------------------------------------------
brew "mise"
brew "pyenv"
brew "pyenv-virtualenv"
brew "rbenv"
brew "python@3.13"
brew "node", link: false
brew "node@22", link: true
brew "go"
brew "tcl-tk"
brew "libyaml"

# ---------------------------------------------------------------------------
# Python tooling
# ---------------------------------------------------------------------------
brew "black"
brew "flake8"

# ---------------------------------------------------------------------------
# Build / task running
# ---------------------------------------------------------------------------
brew "go-task"               # `task` -- every project in ~/dev has a Taskfile.yml
brew "automake"

# ---------------------------------------------------------------------------
# Containers
# ---------------------------------------------------------------------------
brew "colima", restart_service: :changed
brew "docker"

# ---------------------------------------------------------------------------
# Media / docs
# ---------------------------------------------------------------------------
brew "imagemagick"
brew "ffmpeg"
brew "ghostscript"
brew "plantuml"
brew "docutils"
brew "zbar"

# ---------------------------------------------------------------------------
# AI coding tools
# ---------------------------------------------------------------------------
brew "codex"
brew "gastown"
cask "claude-code"

# ---------------------------------------------------------------------------
# Fonts & terminal
# ---------------------------------------------------------------------------
cask "font-hack-nerd-font"
cask "iterm2"

# ---------------------------------------------------------------------------
# Shared GUI
# ---------------------------------------------------------------------------
cask "1password"
cask "1password-cli"
cask "google-chrome"
cask "slack"
cask "zoom"
cask "rectangle"
cask "intellij-idea"
cask "pycharm"
cask "postman"

# ---------------------------------------------------------------------------
# Global npm packages
# ---------------------------------------------------------------------------
npm "typescript"
npm "typescript-language-server"
npm "prettier"
npm "corepack"
