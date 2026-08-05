# Work (Garner) shell config.
#
# Sourced from dotfiles/bashrc only when devn is present, i.e. only on the work
# machine. dotfiles/bashrc is symlinked on every machine, so anything Garner-
# specific belongs here rather than inline -- otherwise the personal machine
# errors on it at every shell startup.

export UV_INDEX_GITLAB_USERNAME="robbie.smith1"
export UV_INDEX_GITLAB_PASSWORD="$GITLAB_TOKEN"   # GITLAB_TOKEN comes from ~/.tokens

export THERAPI_API_BASE_URL=https://api.getgarner.com
export THERAPI_AUTH_URL=https://internal-auth.getgarner.com/oauth2/authorize
export THERAPI_TOKEN_URL=https://internal-auth.getgarner.com/oauth2/token
export THERAPI_CLIENT_ID=3rl8p4htposa55cdtr3hncjvv9
export THERAPI_CLIENT_SECRET="$(security find-generic-password -s therapi-client-secret -a robbie.smith@getgarner.com -w 2>/dev/null)"

# Added by devn onboard.
# Was hardcoded to /Users/robbie, which broke on any machine with a different
# username. $HOME is correct on both.
[[ -f "$HOME/.config/devn/devn_shell_functions.sh" ]] && \
  source "$HOME/.config/devn/devn_shell_functions.sh"
