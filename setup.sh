#!/usr/bin/env bash
#
# Symlinks dotfiles and sets up language runtimes.
# Run ./install.sh first.
#
# Was #!/bin/sh, but this script uses [[ ]] and `local` throughout, which are
# bash builtins. Invoke as ./setup.sh -- not `sh ./setup.sh`.

# Resolve the repo root rather than assuming ~/.dotfiles -- the repo does not
# have to be cloned there. Matches install.sh. This was hardcoded to
# $HOME/.dotfiles, so a clone at any other path left the symlink loop below
# expanding an unmatched glob and silently linking nothing.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

create_config_directory(){
  if [[ ! -d $HOME/.config ]]; then
    echo "Creating config directory in $HOME/.config/ ."
    mkdir $HOME/.config
  fi
}

symlink_dotfiles() {
  echo "Symlinking dotfiles."
  local source_dir="$DOTFILES_DIR/dotfiles"

  # An unmatched glob stays literal and every -e test below fails, so a wrong
  # path used to no-op in silence. Fail loudly instead.
  if [[ ! -d $source_dir ]]; then
    echo "❌ $source_dir does not exist. Nothing symlinked."
    return 1
  fi

  for f in "$source_dir"/*
  do
    local parent_file=$f
    local dotfile=$HOME/.$(basename "$f")

    # rustup (run by install.sh) writes ~/.profile before this script ever runs,
    # so the repo's copy could never be linked -- the -e test below always saw a
    # file there. Back that one up and take it over; the repo copy already has
    # the `. "$HOME/.cargo/env"` line rustup wanted.
    if [[ $dotfile == "$HOME/.profile" ]] && [[ -f $dotfile ]] && [[ ! -L $dotfile ]]; then
      echo "Replacing rustup-created $dotfile (backup: $dotfile.bak)."
      mv "$dotfile" "$dotfile.bak"
    fi

    if [[ -e $parent_file ]] && [[ ! -e $dotfile ]]; then
      echo "Symlinking $parent_file to $dotfile."
      ln -s "$parent_file" "$dotfile"
    fi
  done
}

symlink_neovim_to_config_directory(){
  local nvim_directory="$DOTFILES_DIR/nvim"
  # Guard against re-running: `ln -s dir ~/.config/` on an existing
  # ~/.config/nvim silently creates ~/.config/nvim/nvim instead.
  if [[ -e $HOME/.config/nvim ]]; then
    echo "~/.config/nvim already exists. Skipping."
  elif [[ -d $nvim_directory ]]; then
    echo "Symlinking neovim directory to config directory."
    ln -s "$nvim_directory" "$HOME/.config/nvim"
  else
    echo "❌ $nvim_directory does not exist. Neovim config not linked."
  fi
}

set_shell_to_bash() {
  local brew_bash="/opt/homebrew/bin/bash"

  if [[ ! -x $brew_bash ]]; then
    echo "⚠️  $brew_bash not found -- run ./install.sh first. Skipping."
    return 0
  fi

  if ! grep -q "$brew_bash" /etc/shells; then
    echo "$brew_bash" | sudo tee -a /etc/shells
  fi

  chsh -s "$brew_bash"
  echo "✅ Login shell set to $brew_bash. Open a new terminal for it to apply."
}

# ---------------------------------------------------------------------------
# Language runtimes
#
# mise is the polyglot manager (activated in dotfiles/bash_profile) and owns
# java + the JVM build tools, node, ruby and python.
#
# pyenv + pyenv-virtualenv are still installed and activated in bash_profile,
# but they do NOT own python3 despite what this comment used to claim:
# `mise activate` runs AFTER `pyenv init` there, so mise's shims land earlier on
# PATH and `python3` resolves to mise's. pyenv is kept only for its existing
# virtualenvs; to give it precedence again, move its init below mise's.
# ---------------------------------------------------------------------------

mise_require() {
  if ! command -v mise >/dev/null 2>&1; then
    echo "❌ mise not found -- run ./install.sh first."
    return 1
  fi
}

mise_setup_java() {
  local version="${1:-temurin-17.0.8+7}"
  echo "📥 Installing Java $version via mise..."
  mise use -g "java@${version}" || {
    echo "⚠️  Failed to install java@${version}."
    echo "    List what's available with: mise ls-remote java"
    return 1
  }
  # Must go through `mise exec` like the other runtimes below. A bare
  # `java -version` here hits macOS's /usr/bin/java stub -- mise isn't activated
  # in this script's shell -- and reports "Unable to locate a Java Runtime"
  # even though the install above just succeeded.
  mise exec "java@${version}" -- java -version
}

# JVM build tools. The JDK above is useless on its own for anything beyond
# `javac`, and previously nothing here managed these -- bashrc just carried a
# dead SCALA_HOME and SPARK_HOME pointing at Intel-era /usr/local paths.
mise_setup_jvm_tools() {
  local tool
  for tool in maven gradle kotlin scala sbt; do
    echo "📥 Installing $tool via mise..."
    mise use -g "${tool}@latest" || echo "⚠️  Failed to install ${tool}. Skipping."
  done
}

mise_setup_python() {
  echo "📥 Installing Python via mise..."
  mise use -g python@latest || { echo "⚠️  Failed to install python."; return 1; }

  echo "🐍 mise python:"
  mise exec python@latest -- python --version

  # mise activates AFTER pyenv in bash_profile, so mise's shims win and this is
  # the python3 you actually get in a login shell. pyenv stays installed for its
  # existing virtualenvs. (Note: the path printed here is this script's shell,
  # where mise is not activated -- check a login shell for the real answer.)
  if command -v pyenv >/dev/null 2>&1; then
    echo "ℹ️  pyenv also installed; in a login shell mise's python3 takes precedence."
  fi
}

# mise is the only ruby manager now -- rbenv was dropped from the Brewfile
# (installed, but no shell config ever init'd it).
mise_setup_ruby() {
  echo "📥 Installing Ruby via mise..."
  mise use -g ruby@latest || { echo "⚠️  Failed to install ruby."; return 1; }
  mise exec ruby@latest -- ruby --version
}

# install.sh already installs node@22 so the Brewfiles' `npm "..."` entries have
# an npm at bundle time. This is the idempotent re-assert for a machine where
# setup.sh is re-run on its own.
mise_setup_node() {
  echo "📥 Installing Node via mise..."
  mise use -g node@22 || { echo "⚠️  Failed to install node."; return 1; }
  mise exec node@22 -- node --version
}

mise_setup_all() {
  mise_require || return 1
  mise_setup_java
  mise_setup_jvm_tools
  mise_setup_python
  mise_setup_ruby
  mise_setup_node

  echo ""
  echo "📋 mise status:"
  mise list
  echo ""
  echo "ℹ️  If ~/.tool-versions pins versions that show as (missing), either run"
  echo "   'mise install' to fetch them or update the pins to match the above."
}

create_config_directory
symlink_dotfiles
symlink_neovim_to_config_directory
set_shell_to_bash
mise_setup_all

# Removed from this script (see REPLICATE.md for why):
#   install_vim_plug             -- vestigial; lazy.nvim is the plugin manager
#   install_powerline_fonts      -- superseded by cask "font-hack-nerd-font";
#                                   also cd'd relative to $PWD and rm -rf'd it
#   remove_neovim_default_colors -- hardcoded /usr/local/Cellar, which does not
#                                   exist on Apple Silicon, so it never ran
#   asdf_setup_*                 -- asdf was never installed; mise is the real
#                                   manager. Replaced by mise_setup_* above.

echo "Don't half ass two things, whole ass one thing. - R. Swanson"
