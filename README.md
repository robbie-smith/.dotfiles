
### Dotfiles

My bash profile and neovim setup. Shared across two machines: the personal
(Foundry24) Mac and the Garner work Mac.

```bash
./install.sh personal    # or: ./install.sh work
./setup.sh
```

`install.sh` installs Homebrew, the packages, lazy.nvim and rustup.
`setup.sh` symlinks the dotfiles, sets the login shell to brew bash, and
installs language runtimes via mise.

Run them as `./install.sh` / `./setup.sh` — **not** `sh ./setup.sh`. `setup.sh`
uses bash builtins and needs a real bash.

| File | |
| --- | --- |
| `Brewfile` | shared core — both machines |
| `Brewfile.personal` | AWS, iOS/mobile, databases, personal GUI apps |
| `Brewfile.work` | Garner-only. **Incomplete** — seeded by inference, see the note in the file |
| `dotfiles/` | symlinked into `$HOME` as `.bashrc`, `.gitconfig`, … |
| `bash_base_config/work.sh` | Garner-only shell config, sourced from `bashrc` only when devn is present |
| `nvim/` | symlinked to `~/.config/nvim`; `lazy-lock.json` pins plugin versions |

**[REPLICATE.md](REPLICATE.md)** covers what the scripts can't do: Xcode, SSH
keys, `~/.tokens`, `~/.npmrc`, AWS creds, iOS signing, and how the four runtime
managers (mise / pyenv / rbenv / rustup) layer.
