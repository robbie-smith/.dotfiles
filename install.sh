#! /bin/sh

# Installs dependencies. Run ./setup.sh afterwards for symlinks + runtimes.
#
#   ./install.sh personal    # Foundry24 machine
#   ./install.sh work        # Garner machine
#   ./install.sh             # shared core only
#
# Most of the code here came from thoughtbot. I adapted it to my needs.
# https://github.com/thoughtbot/laptop

fancy_echo() {
  local fmt="$1"; shift
  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

# Resolve the repo root so this works from any working directory.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

PROFILE="${1:-}"
case "$PROFILE" in
  personal|work|"") ;;
  *) echo "Unknown profile '$PROFILE'. Use: personal | work" >&2; exit 1 ;;
esac

# shellcheck disable=SC2016
HOMEBREW_PREFIX="/opt/homebrew"

# Install Homebrew if it's not already installed
if ! command -v brew >/dev/null 2>&1; then
  fancy_echo "Installing Homebrew ..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  fancy_echo "Homebrew already installed"
fi

# Ensure Homebrew has the correct ownership
if [ -d "$HOMEBREW_PREFIX" ]; then
  if ! [ -r "$HOMEBREW_PREFIX" ]; then
    sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
  fi
else
  sudo mkdir "$HOMEBREW_PREFIX"
  sudo chflags norestricted "$HOMEBREW_PREFIX"
  sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
fi

fancy_echo "Updating Homebrew formulae ..."
brew update --force

# These run BEFORE the bundles on purpose. A single failing cask makes
# `brew bundle install` exit nonzero, and with `set -e` that would skip
# everything below it.

# node comes from mise, not brew. The Brewfiles' `npm "..."` entries still need
# an npm on PATH at bundle time, so mise and node have to land first -- hence
# this block rather than leaving mise to the Brewfile.
if ! command -v mise >/dev/null 2>&1; then
  fancy_echo "Installing mise ..."
  brew install mise
else
  fancy_echo "mise already installed. Skipping..."
fi

# Prepend the shims dir rather than `eval "$(mise activate bash)"` -- this
# script runs under /bin/sh and the activate output is bash-specific.
export PATH="$HOME/.local/share/mise/shims:$PATH"

if ! command -v node >/dev/null 2>&1; then
  fancy_echo "Installing Node via mise ..."
  mise use -g node@22
  mise reshim 2>/dev/null || true
else
  fancy_echo "node already on PATH ($(node --version)). Skipping..."
fi

# lazy.nvim is the neovim plugin manager; nvim/lazy-lock.json pins the versions.
if [ ! -d "$HOME/.local/share/nvim/lazy/lazy.nvim" ]; then
  fancy_echo "Installing lazy.nvim ..."
  git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
else
  fancy_echo "lazy.nvim already installed. Skipping..."
fi

# rustup manages the Rust toolchain in ~/.cargo (dotfiles/bash_profile sources
# ~/.cargo/env). Deliberately not installed via brew -- the brew "rust" formula
# conflicts with a rustup-managed toolchain.
if ! command -v rustup >/dev/null 2>&1; then
  fancy_echo "Installing rustup ..."
  # -y is required: without it this prompts and blocks the script.
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
  fancy_echo "rustup already installed. Skipping..."
fi

# Bundle failures are reported, not fatal: ~30 casks means one flaky download
# or a privileged installer shouldn't abort the whole run. Re-running is safe
# and skips whatever already succeeded.
BUNDLE_FAILED=0

fancy_echo "Installing shared dependencies from Brewfile ..."
brew bundle install -v --file="$SCRIPT_DIR/Brewfile" || BUNDLE_FAILED=1

if [ -n "$PROFILE" ]; then
  fancy_echo "Installing $PROFILE dependencies from Brewfile.$PROFILE ..."
  brew bundle install -v --file="$SCRIPT_DIR/Brewfile.$PROFILE" || BUNDLE_FAILED=1
else
  fancy_echo "No profile given -- skipping machine-specific packages."
  fancy_echo "Re-run as './install.sh personal' or './install.sh work' to add them."
fi

if [ "$BUNDLE_FAILED" -ne 0 ]; then
  fancy_echo "⚠️  Some packages failed to install -- scroll up for which."
  fancy_echo "    Re-run this script to retry, or check with:"
  fancy_echo "      brew bundle check --verbose --file=$SCRIPT_DIR/Brewfile"
fi

fancy_echo "Done. Next: ./setup.sh"
