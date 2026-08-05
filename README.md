
### Dotfiles

My bash profile and neovim setup. Shared across two machines: the personal
(Foundry24) Mac and the Garner work Mac.

```bash
./install.sh personal    # or: ./install.sh work
./setup.sh
```

`install.sh` installs Homebrew, mise + node, the packages, lazy.nvim and rustup.
`setup.sh` symlinks the dotfiles, sets the login shell to brew bash, and
installs language runtimes via mise.

Run them as `./install.sh` / `./setup.sh` — **not** `sh ./setup.sh`. `setup.sh`
uses bash builtins and needs a real bash.

The repo does **not** have to live in `~/.dotfiles` — both scripts and `bashrc`
resolve their own location. (It used to be hardcoded, so a clone anywhere else
made `setup.sh` silently symlink nothing.)

### Language runtimes

mise owns everything: **java** (temurin 17) plus **maven, gradle, kotlin, scala,
sbt**, and **node, ruby, python**. Versions are pinned in
`~/.config/mise/config.toml`.

node is deliberately *not* a brew formula. It used to be `brew "node", link:
false` + `brew "node@22", link: true`; when that link failed there was no npm on
PATH and every `npm "..."` entry in the Brewfiles failed with it. `install.sh`
now installs mise + node **before** bundling so npm exists by then.

`pyenv` is still installed but no longer owns `python3` — `bash_profile` runs
`mise activate` after `pyenv init`, so mise's shims win. It's kept only for
pre-existing virtualenvs. `rustup` manages Rust in `~/.cargo`, not brew.

| File | |
| --- | --- |
| `Brewfile` | shared core — both machines |
| `Brewfile.personal` | AWS, iOS/mobile, databases, personal GUI apps |
| `Brewfile.work` | Garner-only. **Incomplete** — seeded by inference, see the note in the file |
| `dotfiles/` | symlinked into `$HOME` as `.bashrc`, `.gitconfig`, … |
| `dotfiles/profile` | POSIX-sh handoff to `.bash_profile`. `setup.sh` backs up rustup's `~/.profile` to `.profile.bak` to claim it |
| `bash_base_config/work.sh` | Garner-only shell config, sourced from `bashrc` only when devn is present |
| `nvim/` | symlinked to `~/.config/nvim`; `lazy-lock.json` pins plugin versions |

**[REPLICATE.md](REPLICATE.md)** covers what the scripts can't do: Xcode, SSH
keys, `~/.tokens`, `~/.npmrc`, AWS creds, iOS signing, and how the four runtime
managers (mise / pyenv / rbenv / rustup) layer.
