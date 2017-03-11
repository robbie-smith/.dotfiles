set nocompatible               " Be iMproved
" turn off any existing search
" if has("autocmd")
"   au VimEnter * :nohlsearch
" endif
au VimEnter,VimLeavePre * :nohlsearch
"Text Wrapping
if !exists('*s:setupWrapping')
  set wm=2
  set textwidth=80
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:python3_host_prog = "/usr/local/bin/python3"

" Enable filetype detection
filetype on

" Path for plug
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

" Reload files changed outside vim
set autoread

" Needed for vim markdown
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
  endif
endfunction

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))
"*******************
" Coding Assist
"*******************
Plug 'gregsexton/MatchTag'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-commentary'
"*******************
" Formatting/Linting
"*******************
Plug 'w0rp/ale'
Plug 'neomake/neomake', { 'for': 'ruby'}
Plug 'Chiel92/vim-autoformat'
"**********
" Git
"**********
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
"**********
" Languages
"**********
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir'}
Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh', 'for': 'elixir' }
Plug 'zchee/nvim-go', { 'do': 'make'}
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-bundler', { 'for': 'ruby'}
"**************
" Miscellaneous
"**************
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'metakirby5/codi.vim'
"*******************
" Snippets
"*******************
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets', { 'frozen': '1' }
"**********
" Visual
"**********
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
