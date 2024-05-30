" Required:
call plug#begin(expand('~/.config/nvim/plugged'))
"*******************
" Coding Assist
"*******************
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'janko-m/vim-test', { 'frozen': '1'}
Plug 'tpope/vim-commentary'
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
Plug 'pmizio/typescript-tools.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'github/copilot.vim'
"*******************
" Formatting/Linting
"*******************
" Plug 'puremourning/vimspector'
" Plug 'dense-analysis/ale', { 'for': ['javascript', 'html', 'ruby', 'python']}
"**********
" Git
"**********
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter'
"**********
" Languages
"**********
Plug 'leshill/vim-json'
"**************
" Miscellaneous
"**************
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-journal', { 'for': ['text', 'txt'], 'frozen': '1'}
Plug 'tpope/vim-dispatch'
"*******************
" Snippets
"*******************
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"**********
" Visual
"**********
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug '~/.dotfiles/neovim/colors'

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
call plug#end()
