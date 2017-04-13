### Dotfiles
My bash profile and neovim setup

If you would like to use my dotfiles, git clone the repo into your home
directory (~/). Then run the following script and follow the prompts, the script will symlink the
dotfiles/dotfiles in this repo to the ones that are currently in your home directory.

`ruby setup.rb`

#### Useful commands
``` vim
FZF-Vim

:Colors   [Query] Shows color schemes
:Lines    [Query] Shows lines in loaded buffers
:History: [Query] Shows command history
:History/ [Query] Shows search history
:Snippets [Query] Shows snippets (UltiSnips)
:Commits  [Query] Shows git commits (requires fugitive.vim)
:BCommits [Query] Shows git commits for the current buffer
:Commands [Query] Shows commands
:Maps     [Query] Shows normal mode mappings

Mdown
:Mpreview  Start the preview server.

Git

:Gvdiff Shows the diff in a vertical split
:Gblame Show git blame in a vertical split
:Gwrite Stage the current file to the index
:Gread  Revert current file to last checked in version
:Gremove  Delete the current file and the corresponding Vim buffer

Codi
:Codi Opens up scratch pad
```
