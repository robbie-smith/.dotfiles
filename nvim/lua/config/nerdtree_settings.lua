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
