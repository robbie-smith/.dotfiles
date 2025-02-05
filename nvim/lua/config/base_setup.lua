-- Base Setup

-- Enable true color support
vim.opt.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

-- Text wrapping
vim.opt.wrapmargin = 2
vim.opt.textwidth = 80

-- Python provider setup
vim.g.python2_host_prog = '~/neovim2/bin/python'
vim.g.python3_host_prog = '/Users/robertsmith/.pyenv/shims/python3.10'

-- Enable filetype detection
vim.cmd('filetype on')
vim.cmd('filetype plugin indent on')

-- Basic setup
vim.opt.encoding = 'utf-8'
vim.opt.hidden = true
vim.opt.undolevels = 1000
vim.opt.undodir = vim.fn.expand('~/.dotfiles/nvim/undodir')  -- Expanding the tilde
vim.opt.undofile = true
vim.opt.updatetime = 100
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.clipboard = 'unnamed'
vim.opt.mouse = 'a'
vim.opt.wildignore:append({ '*/tmp/*', '*.so', '*.swp', '*.zip', '*.pyc', '*.db', '*.sqlite' })

-- Leader key and command shortcuts
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true, silent = true })

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.showcmd = true

-- Search settings
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true

-- Visual settings
vim.opt.syntax = 'on'
vim.opt.ruler = true
vim.opt.number = true

-- Color scheme and highlighting
vim.opt.background = 'dark'
vim.cmd('colorscheme base16-oceanicnext')
vim.opt.signcolumn = 'yes'

-- Highlight groups
vim.api.nvim_set_hl(0, 'ALEErrorSign', { bold = true, fg = '#fb4934', bg = 'bg' })
vim.api.nvim_set_hl(0, 'ALEWarningSign', { bold = true, fg = '#60ff60', bg = 'bg' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#e5c07b', bg = 'bg' })
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'darkgreen' })
vim.api.nvim_set_hl(0, 'GitGutterAdd', { bold = true, fg = '#8ec07c', bg = 'bg' })
vim.api.nvim_set_hl(0, 'GitGutterDelete', { bold = true, fg = '#fb4934', bg = 'bg' })
vim.api.nvim_set_hl(0, 'GitGutterChange', { bold = true, fg = '#fabd2f', bg = 'bg' })
vim.api.nvim_set_hl(0, 'GitGutterAddLine', { bold = true, fg = '#8ec07c', bg = 'bg' })
vim.api.nvim_set_hl(0, 'GitGutterChangeDelete', { bg = 'bg' })
vim.api.nvim_set_hl(0, 'IncSearch', { bg = '#66cccc' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#FF8800', bg = 'NONE' }) -- Replace '#FF8800' with a color you prefer
vim.api.nvim_set_hl(0, 'MatchParen', { bold = true, bg = '#56b6c2' })
vim.api.nvim_set_hl(0, 'NeomakeErrorSign', { bold = true, fg = '#fb4934', bg = 'bg' })
vim.api.nvim_set_hl(0, 'NeomakeWarningSign', { bold = true, fg = '#fb4934', bg = 'bg' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'bg' })
vim.api.nvim_set_hl(0, 'TermCursor', { fg = '#e5c07b' })
