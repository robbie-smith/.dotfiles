### Dotfiles
My bash profile and neovim setup

If you would like to use my dotfiles, git clone the repo into your home
directory (~/). Then run the following script and follow the prompts, the script will symlink the
dotfiles/dotfiles in this repo to the ones that are currently in your home directory.

```ruby setup.rb```

* Note if you already have dotfiles in your home directory that exist in this
  repo you must delete the one in your home directory if you want to use these.

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
