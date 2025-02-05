return {
  { "junegunn/gv.vim", cmd = "GV" }, -- Git commit browser
  { "tpope/vim-fugitive", cmd = { "G", "Git" } }, -- Git integration
  { "tpope/vim-rhubarb", lazy = true }, -- GitHub extension for Fugitive
  { "xuyuanp/nerdtree-git-plugin", cmd = "NERDTreeToggle" }, -- Git status in NERDTree
  { "airblade/vim-gitgutter", event = "BufRead" }, -- Git diff in the sign column
}
