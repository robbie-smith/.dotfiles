set nocompatible               " Be iMproved
" turn off any existing search
if has("autocmd")
  au VimEnter * :nohlsearch
endif

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
"*****************************************************************************
" Plug install packages
"*****************************************************************************
Plug 'w0rp/ale'
" Plug 'chriskempson/base16-vim'
" NerdTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" MatchTag
Plug 'gregsexton/MatchTag'
" DelimitMate
Plug 'Raimondi/delimitMate'
" Fugitive(git-addon)
Plug 'tpope/vim-fugitive'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" GitGutter
Plug 'airblade/vim-gitgutter'
" NeoSnippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" Ulti Snips engine
Plug 'SirVer/ultisnips'
" Vim Snippets
Plug 'honza/vim-snippets'
" AutoFormat
Plug 'Chiel92/vim-autoformat'
" NeoMake
Plug 'neomake/neomake', { 'for': 'ruby'}
" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Surround
Plug 'tpope/vim-surround'
" Vim Rails
Plug 'tpope/vim-rails'
" Vim Bundler
Plug 'tpope/vim-bundler'
" VimTest
Plug 'janko-m/vim-test'
" VimPolyglot
Plug 'sheerun/vim-polyglot'
" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" VimCommentary
Plug 'tpope/vim-commentary'
" Nvim GO
Plug 'zchee/nvim-go', { 'do': 'make'}
" Git commit browser
Plug 'junegunn/gv.vim'
" Vim Markdown Composer
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
" Vim Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'metakirby5/codi.vim'
Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' }
call plug#end()
