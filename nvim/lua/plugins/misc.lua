return {
  {
    "junegunn/fzf",
    dir = "~/.fzf",
    build = "./install --all",
    lazy = false,
  },
  { "junegunn/fzf.vim", lazy = false}, -- FZF integration
  { "junegunn/vim-journal", ft = { "text", "txt" }, lazy = true }, -- Journal support
  { "tpope/vim-dispatch", cmd = { "Dispatch", "Make", "Focus", "Start" } }, -- Async build/test dispatcher
}
