return {
  {
    "junegunn/fzf",
    build = "./install --all",
    lazy = false,
  },
  {
    "junegunn/fzf.vim",
    lazy = false,
  },
  {
    "junegunn/vim-journal",
    ft = { "text", "txt" },
    lazy = true,
  },
  {
    "tpope/vim-dispatch",
    cmd = { "Dispatch", "Make", "Focus", "Start" },
  },
}
