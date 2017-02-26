### Dotfiles
My bash profile and neovim setup
Symlink the colors directory with neovims colors, assuming homebrew was used to
install neovim
ln -s ~/.config/nvim/colors /usr/local/cellar/neovim/0.1.7/share/nvim/runtime/colors
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

Vim Markdown Composer

:ComposerStart  Start the preview server.
:ComposerUpdate Send the current buffer to the preview server
:ComposerOpen   Opens a new browser window containing the markdown preview

Git

:Gvdiff Shows the diff in a vertical split
:Gblame Show git blame in a vertical split
:Gwrite Stage the current file to the index
:Gread  Revert current file to last checked in version
:Gremove  Delete the current file and the corresponding Vim buffer

Codi
:Codi Opens up scratch pad
```
