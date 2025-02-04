-- Key Mappings

-- COC Mappings
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', { silent = true }) -- Jump to the definition of a symbol
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', { silent = true }) -- Jump to the type definition of a symbol
vim.api.nvim_set_keymap('n', 'fu', '<Plug>(coc-references)', { silent = true }) -- Show references to the current symbol
vim.api.nvim_set_keymap('n', '<leader>rn', '<Plug>(coc-rename)', {}) -- Rename the current symbol
vim.api.nvim_set_keymap('n', 'K', ':call ShowDocumentation()<CR>', { noremap = true, silent = true }) -- Show documentation for the symbol under the cursor

-- Show Documentation Function
_G.ShowDocumentation = function()
  if vim.fn.CocAction('hasProvider', 'hover') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_feedkeys('K', 'in', true)
  end
end

-- Format Selected Code
vim.api.nvim_set_keymap('x', '<leader>f', '<Plug>(coc-format-selected)', {}) -- Format selected code
vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>(coc-format-selected)', {}) -- Format current buffer

-- Autocommands for COC
vim.api.nvim_create_augroup('cocGroup', { clear = true }) -- Group for COC autocommands
vim.api.nvim_create_autocmd('FileType', {
  group = 'cocGroup',
  pattern = { 'python', 'json' },
  command = "setl formatexpr=CocAction('formatSelected')",
}) -- Setup formatexpr for specific filetypes
vim.api.nvim_create_autocmd('User', {
  group = 'cocGroup',
  pattern = 'CocJumpPlaceholder',
  command = "call CocActionAsync('showSignatureHelp')",
}) -- Update signature help on placeholder jump

-- Add Format Command
vim.api.nvim_create_user_command('Format', function()
  vim.fn.CocActionAsync('format')
end, { nargs = 0 }) -- Command to format current buffer

-- COC Snippets
vim.api.nvim_set_keymap('i', '<C-l>', '<Plug>(coc-snippets-expand)', { silent = true }) -- Expand snippet
vim.api.nvim_set_keymap('v', '<C-j>', '<Plug>(coc-snippets-select)', { silent = true }) -- Select snippet placeholder

-- FZF Mappings
vim.api.nvim_set_keymap('n', '<Leader>o', ':Files<CR>', { noremap = true, silent = true }) -- Open FZF file search
vim.api.nvim_set_keymap('i', '<C-f>', '<plug>(fzf-complete-file-ag)', {}) -- FZF file completion
vim.api.nvim_set_keymap('i', '<C-l>', '<plug>(fzf-complete-line)', {}) -- FZF line completion
vim.g.fzf_action = {
  ['ctrl-s'] = 'split', -- Split window for FZF
  ['ctrl-v'] = 'vsplit', -- Vertical split for FZF
}
vim.api.nvim_set_keymap('n', '<Leader>fa', ':Lines <C-R><C-W><CR>', { noremap = true, silent = true }) -- Search project for word under cursor
vim.api.nvim_set_keymap('n', '<Leader>b', ':BTags<CR>', { noremap = true }) -- Open buffer tags
vim.api.nvim_set_keymap('n', '<C-b>', ':BLines<CR>', { noremap = true, silent = true }) -- Search buffer lines

-- NerdTree Mappings
vim.api.nvim_set_keymap('n', '<Leader>\\', ':NERDTreeToggle<CR>', { noremap = true, silent = true }) -- Toggle NERDTree
vim.api.nvim_set_keymap('n', '<F2>', ':NERDTreeFind<CR>', { noremap = true, silent = true }) -- Find current file in NERDTree

-- VimFugitive Mappings
vim.api.nvim_set_keymap('n', '<space>ga', ':Gwrite<CR><CR>', { noremap = true, silent = true }) -- Stage file for Git
vim.api.nvim_set_keymap('n', '<space>gs', ':Gstatus<CR>', { noremap = true, silent = true }) -- Show Git status
vim.api.nvim_set_keymap('n', '<space>gd', ':Gvdiff<CR>', { noremap = true, silent = true }) -- Show Git diff
vim.api.nvim_set_keymap('n', '<space>gb', ':Git branch ', { noremap = true }) -- List Git branches
vim.api.nvim_set_keymap('n', '<space>gcb', ':Git checkout ', { noremap = true }) -- Checkout Git branch
vim.api.nvim_set_keymap('n', '<space>gc', ':Git commit -v -q<CR>', { noremap = true, silent = true }) -- Commit changes
vim.api.nvim_set_keymap('n', '<space>gp', ':Git push<CR>', { noremap = true, silent = true }) -- Push changes

-- VimTest Mappings
vim.api.nvim_set_keymap('n', '<Leader>t', ':TestFile<CR>', { noremap = true, silent = true }) -- Run tests for current file
vim.api.nvim_set_keymap('n', '<Leader>l', ':TestNearest<CR>', { noremap = true, silent = true }) -- Run nearest test

-- General Mappings
vim.api.nvim_set_keymap('n', '<Up>', '<NOP>', { noremap = true }) -- Disable Up arrow key
vim.api.nvim_set_keymap('n', '<Down>', '<NOP>', { noremap = true }) -- Disable Down arrow key
vim.api.nvim_set_keymap('n', '<Left>', '<NOP>', { noremap = true }) -- Disable Left arrow key
vim.api.nvim_set_keymap('n', '<Right>', '<NOP>', { noremap = true }) -- Disable Right arrow key
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true }) -- Save file
vim.api.nvim_set_keymap('n', '<Leader>p', ':set nopaste<CR>', { noremap = true }) -- Disable paste mode
vim.api.nvim_set_keymap('n', '<CR>', 'G', { noremap = true }) -- Jump to last line
vim.api.nvim_set_keymap('n', '<Leader>rl', ':so %<CR>', { noremap = true }) -- Reload source file
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprev<CR>', { noremap = true, silent = true }) -- Switch to previous buffer
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', { noremap = true, silent = true }) -- Switch to next buffer
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<CR>', { noremap = true, silent = true }) -- Move to pane below
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<CR>', { noremap = true, silent = true }) -- Move to pane above
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', { noremap = true, silent = true }) -- Move to pane left
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', { noremap = true, silent = true }) -- Move to pane right
