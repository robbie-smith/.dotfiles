-- Plug-in Configurations

-- ALE / Neomake / Syntastic configuration
vim.g.ale_linters = {
  javascript = { 'jshint' },
  html = { 'tidy' },
  go = { 'golint' },
  ruby = { 'rubocop' },
  python = { 'flake8', 'pylint', 'black' }
}

vim.g.ale_fixers = {
  javascript = { 'jshint' },
  ruby = { 'rubocop' },
  python = { 'black' }
}

vim.g.coc_global_extensions = { 'coc-pyright' }
vim.o.statusline = '%{coc#status()}%{get(b:,"coc_current_function","")}'

-- Airline Configuration
vim.g.airline_theme = 'onedark'
vim.g.airline_left_sep = ''
vim.g.airline_left_alt_sep = ''
vim.g.airline_right_sep = ''
vim.g.airline_right_alt_sep = ''
vim.g.airline_symbols = {
  branchi = '',
  readonly = ''
}
vim.g.airline_powerline_fonts = 1
vim.g.airline_skip_empty_sections = 1
vim.g['airline#extensions#tagbar#enabled'] = 1
vim.g['airline#extensions#ale#enabled'] = 1
vim.g['airline#extensions#branch#enabled'] = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#hunks#enabled'] = 1

-- FZF Configuration
vim.g.fzf_colors = {
  fg = { 'fg', 'Normal' },
  bg = { 'bg', 'Normal' },
  hl = { 'fg', 'Comment' },
  ['fg+'] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
  ['bg+'] = { 'bg', 'CursorLine', 'CursorColumn' },
  ['hl+'] = { 'fg', 'Statement' },
  info = { 'fg', 'PreProc' },
  prompt = { 'fg', 'Conditional' },
  pointer = { 'fg', 'Exception' },
  marker = { 'fg', 'Keyword' },
  spinner = { 'fg', 'Label' },
  header = { 'fg', 'Comment' }
}

-- Custom Ripgrep Command for FZF
vim.api.nvim_create_user_command('Rg', function(opts)
  local args = opts.args
  local preview_option = opts.bang and 'up:60%' or 'right:50%:hidden'
  vim.fn['fzf#vim#grep'](
    'rg --column --line-number --no-heading --color=always ' .. vim.fn.shellescape(args),
    1,
    vim.fn['fzf#vim#with_preview'](preview_option)
  )
end, { bang = true, nargs = '*' })

-- Files Command with Preview Window
vim.api.nvim_create_user_command('Files', function(opts)
  local args = opts.args
  local preview_option = vim.fn['fzf#vim#with_preview']()
  vim.fn['fzf#vim#files'](args, preview_option, opts.bang)
end, { bang = true, nargs = '?', complete = 'dir' })

-- GitGutter Configuration
vim.g.gitgutter_highlight_lines = 0
vim.g.gitgutter_max_signs = 500

-- NerdTree Configuration
vim.g.nerdtreequitonopen = 1
vim.g.nerdtreechdirmode = 2
vim.g.nerdtreeignore = { '\\.rbc$', '\\~$', '\\.pyc$', '\\.db$', '\\.sqlite$', '__pycache__' }
vim.g.nerdtreesortorder = { '^__\\.py$', '\\/$', '*', '\\.swp$', '\\.bak$', '\\~$' }
vim.g.nerdtreewinsize = 28
vim.g.nerdtreeindicatormapcustom = {
  modified = '!',
  staged = '✚',
  untracked = '✭',
  renamed = '➜',
  unmerged = '═',
  deleted = '✖',
  dirty = '✗',
  clean = '✔︎',
  unknown = '?'
}

-- NeoSnippet Configuration
vim.g['neosnippet#snippets_directory'] = { vim.fn.expand('$HOME/.dotfiles/nvim/mysnippets'), 'neosnippet' }
vim.g['neosnippet#enable_snipmate_compatibility'] = 1

-- VimTest Configuration
vim.g['test#strategy'] = 'iterm'
vim.g['test#python#pytest#options'] = {
  all = '-s',
  nearest = '-v',
  file = '-v',
  suite = '-v'
}

vim.g['test#ruby#rspec#options'] = {
  nearest = '--backtrace',
  file = '--format documentation',
  suite = '--tag ~slow'
}

vim.g['test#scala#runner'] = 'gradletest'
vim.g['test#typescript#runner'] = 'mocha'
vim.g['test#javascript#mocha#options'] = '--reporter spec'
vim.g['test#javascript#mocha#file_pattern'] = '\\v^spec[\\\\/].*spec\\.(js|ts)$'
