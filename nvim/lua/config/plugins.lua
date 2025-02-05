-- Plugin Installation using Packer.nvim
vim.cmd [[packadd packer.nvim]]
-- vim.opt.runtimepath:append('~/.dotfiles/neovim/colors')
-- vim.cmd [[colorscheme your_color_scheme_name]]
-- Start packer.nvim configuration
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Coding Assistance Plugins
  use 'Raimondi/delimitMate' -- Auto-closing brackets, parentheses, quotes, etc.
  use 'tpope/vim-surround' -- Surround text objects easily
  use { 'janko-m/vim-test', frozen = true } -- Run tests directly from Vim
  use 'tpope/vim-commentary' -- Toggle comments easily
  use {
    'pappasam/coc-jedi', -- Jedi language server extension for coc.nvim
    branch = 'main',
    run = 'yarn install --frozen-lockfile && yarn build'
  }
  use 'pmizio/typescript-tools.nvim' -- TypeScript tooling for Neovim
  use 'neovim/nvim-lspconfig' -- LSP configuration for Neovim
  use 'nvim-lua/plenary.nvim' -- Lua utility functions

  -- Formatting and Linting Plugins
  -- Uncomment to enable vimspector or ALE
  -- use 'puremourning/vimspector'
  -- use { 'dense-analysis/ale', ft = { 'javascript', 'html', 'ruby', 'python' } }

  -- Git Plugins
  use 'junegunn/gv.vim' -- Git commit browser
  use 'tpope/vim-fugitive' -- Git integration for Vim
  use 'tpope/vim-rhubarb' -- GitHub extension for Fugitive
  use { 'Xuyuanp/nerdtree-git-plugin', cmd = 'NERDTreeToggle' } -- Git status in NERDTree
  use 'airblade/vim-gitgutter' -- Show Git diff in sign column

  -- Language-Specific Plugins
  use 'leshill/vim-json' -- Enhanced JSON support

  -- Miscellaneous Plugins
  use {
    'junegunn/fzf', -- Fuzzy finder
    dir = '~/.fzf',
    run = './install --all'
  }
  use 'junegunn/fzf.vim' -- FZF integration for Vim
  use { 'junegunn/vim-journal', ft = { 'text', 'txt' }, frozen = true } -- Journal support
  use 'tpope/vim-dispatch' -- Async build and test dispatcher

  -- Snippets Plugins
  -- use { 'neoclide/coc.nvim', branch = 'release' } -- Intellisense engine for Vim

  -- Testing Plugins
  use 'mfussenegger/nvim-dap' -- Debug Adapter Protocol client
  use 'nvim-neotest/nvim-nio' -- Test runner for Neovim
  use 'rcarriga/nvim-dap-ui' -- UI for nvim-dap
  use 'mxsdev/nvim-dap-vscode-js' -- JavaScript/TypeScript support for nvim-dap

  -- Visual Plugins
  use { 'scrooloose/nerdtree', cmd = 'NERDTreeToggle' } -- File explorer
  use 'vim-airline/vim-airline' -- Statusline plugin
  use 'vim-airline/vim-airline-themes' -- Themes for vim-airline
  use 'craigmac/vim-mermaid' -- Themes for vim-airline
  -- use { dir = '~/.dotfiles/neovim/colors' } -- Custom color schemes

  -- Markdown Composer Plugin
  use { 'euclio/vim-markdown-composer', run = 'cargo build --release'}
end)
