" Be iMproved
set nocompatible

"Text Wrapping
if !exists('*s:setupWrapping')
  set wm=2
  set textwidth=80
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:python3_host_prog = '/usr/local/bin/python3'

" Enable filetype detection
filetype on
" Path for plug
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

" Reload files changed outside vim
set autoread
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
set rtp+=~/.dotfiles/nvim/ftdetect/journal.vim
"****************
" Basic Setup
"****************
" Encoding
set encoding=utf-8
" Enable hidden buffers
set hidden
" Number of undo levels
set undolevels=1000
set undodir=~/.config/nvim/undodir
set undofile
" Set updatetime
set updatetime=100
" Directories for swp files
set nobackup
set noswapfile
filetype plugin indent on
set clipboard=unnamed
set mouse=a
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
" Map the leader key to SPACE
let mapleader="\<SPACE>"
" Use ; for commands
nnoremap ; :
"****************
" Indenting
"****************
" Fix backspace indent
" Tabs. May be overriten by autocmd rules
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set showcmd
"****************
" Searching
"****************
set hlsearch  " Highlight all search results
set smartcase " Enable smart-case search
set ignorecase  " Always case-insensitive
set incsearch " Searches for strings incrementally
"****************
" Visual Settings
"****************
let python_highlight_all=1
" Highlight all tabs and trailing whitespace characters.
syntax on
syntax enable
set ruler
set number

" Tell the term has 256 colors
if (has("termguicolors"))
set termguicolors
endif

"****************
" Color Scheme
"****************
set background=dark
" colorscheme base16-tomorrow-night
" colorscheme base16-gruvbox-dark-hard
" colorscheme two-firewatch
colorscheme base16-oceanicnext
" colorscheme base16-onedark
" colorscheme base16-darktooth
" colorscheme deus
" colorscheme neodark
" colorscheme base16-eighties
set signcolumn=yes
"****************
" Highlighting
"****************
hi ALEErrorSign gui=bold guifg=#fb4934 guibg=bg
hi ALEWarningSign gui=bold guifg=#60ff60 guibg=bg
hi CursorLineNr guifg=#e5c07b guibg=bg
hi ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
hi GitGutterAdd gui=bold guifg=#8ec07c guibg=bg
hi GitGutterDelete gui=bold guifg=#fb4934 guibg=bg
hi GitGutterChange gui=bold guifg=#fabd2f guibg=bg
hi GitGutterAddLine gui=bold guifg=#8ec07c guibg=bg
hi GitGutterChangeDelete guibg=bg
hi IncSearch guibg=#66cccc
hi LineNr guifg=String guibg=bg
hi MatchParen gui=bold guibg=#56b6c2
hi NeomakeErrorSign gui=bold guifg=#fb4934 guibg=bg
hi NeomakeWarningSign gui=bold guifg=#fb4934 guibg=bg
hi SignColumn guibg=bg
hi TermCursor ctermfg=red guifg=#e5c07b
