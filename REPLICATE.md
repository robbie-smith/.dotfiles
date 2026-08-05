# Replicating this environment on a new Mac

Written 2026-08-05 while trading in the Foundry24 MacBook. `install.sh` and
`setup.sh` cover most of it; this file covers what they can't.

## Order

```bash
# 1. Xcode from the App Store first -- fastlane/cocoapods/xcodegen need it
xcode-select --install
sudo xcodebuild -license accept

# 2. SSH key (see "Secrets" below) -- required before any git clone

git clone git@github.com:robbie-smith/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh personal     # or: ./install.sh work
./setup.sh
```

The clone path is no longer load-bearing — the scripts and `bashrc` resolve
their own location, so a clone outside `~/.dotfiles` works too.

If you *move* the repo, the symlinks in `$HOME` still point at the old path and
every one of them breaks. Re-run `./setup.sh` after deleting the stale links, or
repoint them in place:

```bash
for f in ~/.bashrc ~/.bash_profile ~/.gitconfig ~/.profile ~/.ctags ~/.gemrc \
         ~/.gitconfig-* ~/.global_ignore ~/.ideavimrc ~/.pryrc ~/.rspec \
         ~/.themes.gitconfig ~/.config/nvim; do
  [ -L "$f" ] && [ ! -e "$f" ] && echo "broken: $f -> $(readlink "$f")"
done
```

Then open a **new** terminal — `setup.sh` runs `chsh`, which only applies to new
sessions.

**Verify the shell actually changed:**

```bash
dscl . -read ~/ UserShell     # want /opt/homebrew/bin/bash, not /bin/bash
```

`chsh` prompts for your password and silently no-ops if you decline, and this
failed on the old machine — its login shell was still `/bin/bash` (3.2) even
though `dotfiles/bash_profile` assumes brew bash 5.x. If it reads `/bin/bash`,
re-run `chsh -s /opt/homebrew/bin/bash`.

`install.sh` reports package failures rather than aborting on them, so check its
output for a ⚠️ line before assuming everything installed. Confirm with:

```bash
brew bundle check --verbose --file=Brewfile
brew bundle check --verbose --file=Brewfile.personal
```

**Verify the runtimes came from mise, not brew:**

```bash
command -v node ruby java mvn    # all should be under ~/.local/share/mise/
```

If `node` resolves to `/opt/homebrew/bin/node`, a brew node formula has crept
back in — remove it. Two node installs is what broke the 2026-08-05 run: the
`node@22` link failed, leaving no npm on PATH, and all ten `npm "..."` entries
in the Brewfiles failed silently behind a single ⚠️ line.

## Secrets — none of this is in any repo

Nothing below can be committed. Move it via 1Password or an encrypted archive.

| What | Where it was | Notes |
| --- | --- | --- |
| `~/.ssh/id_ed25519` | `~/.ssh/` | **Blocks everything.** Every remote is `git@github.com:`. Without this, no repo clones. Cleaner alternative for a device handoff: generate a fresh key on the new Mac and add it to GitHub, then retire this one. |
| `~/.tokens` | `$HOME` | Sourced first thing by `dotfiles/bash_profile`. Holds `GITLAB_TOKEN` among others. |
| `~/.npmrc` | `$HOME` | GitHub PAT with `read:packages`, needed for `@foundry24/cdk-app-patterns`. |
| `~/.aws/credentials` | `~/.aws/` | `dotfiles/bashrc` sets `AWS_PROFILE="foundry24"`, so the profile must exist. |
| `~/.config/gh/hosts.yml` | `~/.config/gh/` | Or just re-run `gh auth login`. |
| `~/dev/keys/` | `~/dev/` | Apple App Store Connect key `AuthKey_N3F3YUNWLD.p8` + API credentials. |
| Therapi client secret | macOS keychain | Work machine only. Recreate with `security add-generic-password -s therapi-client-secret -a robbie.smith@getgarner.com -w '<secret>'`. |
| Per-repo `.env` files | across ~11 repos in `~/dev` | Gitignored, so no push carried them. Also `floyd/.secrets/`, `radda/scripts/AuthKey_6YG4J7Q256.p8`, `radda/ios/DinnerLens/Configuration/Secrets.xcconfig`, `tenlines/proxy-poc-rust/certs/ca.key`, `tenlines/web/ca.pem`. |

## iOS signing

`fastlane match` needs two things beyond the Brewfile:

1. Clone access to `git@github.com:robbie-smith/ios-certificates.git` (the
   `storage_mode("git")` target in `ios-template/fastlane/Matchfile`).
2. The App Store Connect API key from `~/dev/keys/`, referenced by each
   project's `fastlane/.env`.

Apple team ID `SHYD6Q83MT`, Apple ID `robbie@compstacker.com`.

## `@foundry24/cdk-app-patterns`

Published to **GitHub Packages**, not npmjs — source at
`github.com/Foundry24/cdk-app-patterns`. `~/.npmrc` needs:

```
@foundry24:registry=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=<GitHub PAT with read:packages>
```

On the old machine the global install was an `npm link` to
`~/dev/cdk-app-patterns` under the alias `@smith-holdings/cdk-app-patterns`. To
restore that development setup instead of consuming the published version:

```bash
cd ~/dev/cdk-app-patterns && npm link
```

**Known bug:** `.github/workflows/publish.yml` sets `scope: '@compstacker'` and
writes `@compstacker:registry=` to `.npmrc`, but the package is
`@foundry24/cdk-app-patterns`. The last three publish runs failed. Fix the scope
before cutting another release.

## Runtime managers — read before debugging PATH

Four managers are involved and the layering is deliberate but not obvious.
`dotfiles/bash_profile` activates them in this order:

```
starship → pyenv → pyenv-virtualenv → mise
```

- **pyenv** wins for `python3` on PATH, despite mise activating last.
- **mise** owns java, gcloud, and anything in `~/.tool-versions`.
- **rbenv** is installed but `ruby` currently resolves to `/usr/bin/ruby`
  (system Ruby). Nothing depends on rbenv today.
- **rustup** owns Rust in `~/.cargo`, installed by `install.sh`. The brew
  `rust` formula is deliberately absent — it conflicts.
- **asdf** was removed. It was in the Brewfile and drove all of `setup.sh`, but
  was never actually installed, so it had never produced the live environment.

`~/.tool-versions` currently pins `python 3.13.3` and `ruby 3.4.2`, both of
which `mise list` reports as **(missing)** — pre-existing breakage carried over
from the asdf era. Either `mise install` them or repin.

**Neither mise config file is tracked in this repo**, so the pins don't
replicate on their own:

- `~/.tool-versions` — `python 3.13.3`, `ruby 3.4.2`
- `~/.config/mise/config.toml` — pins `gcloud 549.0.1`

`setup.sh` installs `@latest` for java/python/ruby, which will not match those
pins. Copy both files over by hand if you want the exact versions.

`dotfiles/asdfrc` is still in the repo and still gets symlinked to `~/.asdfrc`
by `symlink_dotfiles`, even though asdf is gone everywhere else. Harmless —
nothing reads it — but it can be deleted.

## Not managed by any script

- **Xcode** — App Store.
- **Astro.app, iTermAI, Keynote/Numbers/Pages, Safari** — App Store or bundled.
- **`~/dev/.claude/`, `~/dev/scripts/`, `~/dev/ios-template/`** — archived
  separately at `github.com/Foundry24/dev-config`.
- **iTerm2 profile/preferences** — not exported. Redo by hand or export
  `com.googlecode.iterm2.plist` before wiping.

## Stale entries in `dotfiles/bashrc`

Intel-era paths that no longer exist on Apple Silicon. Harmless (they just add
dead PATH entries) but worth pruning:

- `/usr/local/opt/postgresql@9.5/bin`
- `/Applications/SnowSQL.app/Contents/MacOS`
- `/Applications/Postgres.app/Contents/Versions/12/bin`
- `$HOME/.toolbox/bin`
- `$HOMEBREW_CELLAR/apache-spark/3.5.1/libexec` (`SPARK_HOME`)

`GOROOT` was already removed — Go finds its own root now.
