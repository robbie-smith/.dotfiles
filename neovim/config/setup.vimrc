"*****************************************************************************
" Basic Setup
"*****************************************************************************
" Encoding
set encoding=utf-8
" Enable hidden buffers
set hidden
" Number of undo levels
set undolevels=1000
set undodir=~/.config/nvim/undodir
set undofile
" Set updatetime
set updatetime=500
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
"*****************************************************************************
" Indenting
"*****************************************************************************
" Fix backspace indent
" Tabs. May be overriten by autocmd rules
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set showcmd

"*****************************************************************************
" Searching
"*****************************************************************************
set hlsearch  " Highlight all search results
set smartcase " Enable smart-case search
set ignorecase  " Always case-insensitive
set incsearch " Searches for strings incrementally
"*****************************************************************************
" Visual Settings
"*****************************************************************************
" Highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
syntax on
syntax enable
set ruler
set number

" Tell the term has 256 colors
if (has("termguicolors"))
  set termguicolors
endif
"**********************
" Color Scheme
"**********************
set background=dark
colorscheme base16-eighties
""**********************
" Highlighting
"**********************
hi LineNr guifg=String guibg=bg
hi ALEErrorSign guibg=bg
hi ALEWarningSign guibg=bg
hi NeomakeErrorSign guibg=bg
hi NeomakeWarningSign guibg=bg
hi GitGutterAdd guibg=bg
hi GitGutterChangeDelete guibg=bg
hi GitGutterDelete guibg=bg
hi GitGutterChange guibg=bg
hi GitGutterAddLine guibg=bg
hi MatchParen gui=bold guifg=#66cccc
