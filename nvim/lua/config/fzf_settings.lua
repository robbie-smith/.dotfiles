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
-- Use rg with fzf and ignore the undodir directory
-- Use rg with fzf and ignore the undodir directory
vim.g.fzf_default_command = "rg --files --hidden --glob '!/Users/robsmid/.dotfiles/nvim/undo/*'"
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
