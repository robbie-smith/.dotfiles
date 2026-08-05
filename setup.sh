#!/usr/bin/env bash
#
# Symlinks dotfiles and sets up language runtimes.
# Run ./install.sh first.
#
# Was #!/bin/sh, but this script uses [[ ]] and `local` throughout, which are
# bash builtins. Invoke as ./setup.sh -- not `sh ./setup.sh`.

create_config_directory(){
  if [[ ! -d $HOME/.config ]]; then
    echo "Creating config directory in $HOME/.config/ ."
    mkdir $HOME/.config
  fi
}

symlink_dotfiles() {
  echo "Symlinking dotfiles."
  for f in $HOME/.dotfiles/dotfiles/*
  do
    local parent_file=$f
    local dotfile=$HOME/.$(basename $f)
    if [[ -e $parent_file ]] && [[ ! -e $dotfile ]]; then
      echo "Symlinking $parent_file to $dotfile."
      ln -s $parent_file $dotfile
    fi
  done
}

symlink_neovim_to_config_directory(){
  local nvim_directory=$HOME/.dotfiles/nvim
  # Guard against re-running: `ln -s dir ~/.config/` on an existing
  # ~/.config/nvim silently creates ~/.config/nvim/nvim instead.
  if [[ -e $HOME/.config/nvim ]]; then
    echo "~/.config/nvim already exists. Skipping."
  elif [[ -d $nvim_directory ]]; then
    echo "Symlinking neovim directory to config directory."
    ln -s $nvim_directory $HOME/.config/nvim
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
# mise is the polyglot manager (activated in dotfiles/bash_profile).
# pyenv + pyenv-virtualenv are also activated there and take precedence for
# python3 on PATH -- mise is used for java, gcloud and anything in
# ~/.tool-versions.
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
  java -version
}

mise_setup_python() {
  echo "📥 Installing Python via mise..."
  mise use -g python@latest || { echo "⚠️  Failed to install python."; return 1; }

  echo "🐍 mise python:"
  mise exec python@latest -- python --version

  # pyenv is activated after mise in bash_profile, so `python3` on PATH is
  # pyenv's, not this one. That's the existing arrangement, not a bug.
  if command -v pyenv >/dev/null 2>&1; then
    echo "ℹ️  pyenv also active; \`python3\` resolves to $(command -v python3)"
  fi
}

mise_setup_ruby() {
  echo "📥 Installing Ruby via mise..."
  mise use -g ruby@latest || { echo "⚠️  Failed to install ruby."; return 1; }
  mise exec ruby@latest -- ruby --version
}

mise_setup_all() {
  mise_require || return 1
  mise_setup_java
  mise_setup_python
  mise_setup_ruby

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
