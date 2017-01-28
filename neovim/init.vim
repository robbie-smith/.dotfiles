set nocompatible               " Be iMproved

" Path for python
let g:ycm_python_binary_path = '/usr/bin/python3'
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Enable filetype detection
filetype on

" Path for plug
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
" The Silver Searcher
let g:ackprg = 'ag --vimgrep'
" Enable setting title
" Reload files changed outside vim
set autoread

" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
" Plug install packages
"*****************************************************************************
" Color Schemes
Plug 'davb5/wombat256dave'
Plug 'KeitaNakamura/neodark.vim'
Plug 'morhetz/gruvbox'
" NerdTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
"Fugitive(git-addon)
Plug 'tpope/vim-fugitive'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"GitGutter
Plug 'airblade/vim-gitgutter'
" NeoSnippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" Ulti Snips engine
Plug 'SirVer/ultisnips'
" Vim Snippets
" Plug 'honza/vim-snippets'
" Syntastic
Plug 'scrooloose/syntastic'
"FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Surround
Plug 'tpope/vim-surround'
" Vim-Rspec
Plug 'thoughtbot/vim-rspec'
" Autoformat
Plug 'chiel92/vim-autoformat'
" NeoFormat
Plug 'sbdchd/neoformat'
" VimTest
Plug 'janko-m/vim-test'
" AutoSave
Plug '907th/vim-auto-save'
" NerdCommenter
Plug 'scrooloose/nerdcommenter'
" VimPolyglot
Plug 'sheerun/vim-polyglot'
"Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" VimCommentary
Plug 'tpope/vim-commentary'
" Nvim GO
Plug 'zchee/nvim-go', { 'do': 'make'}
call plug#end()

"*****************************************************************************
" Basic Setup
"*****************************************************************************

" Encoding
set encoding=utf-8

" Fix backspace indent
" Tabs. May be overriten by autocmd rules
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set showcmd

" Enable hidden buffers
set hidden

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Automatically resize splits when resizing window
autocmd VimResized * wincmd =

set updatetime=250

" Directories for swp files
set nobackup
set noswapfile

filetype plugin on
set clipboard=unnamed
set mouse=a
"*****************************************************************************
" Visual Settings
"*****************************************************************************

syntax on
syntax enable
set ruler
set number
set relativenumber

" Color Scheme
"colorscheme gruvbox
"colorscheme wombat256dave
let g:neodark#background='brown' " black, gray or brown
colorscheme neodark

" Sets dark mode
set background=dark

" Tell the term has 256 colors
if has("gui_running")
  set t_Co=256
end
" Status bar
set laststatus=2

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
" match ExtraWhitespace /\s\+$\|\t/

" ****************************************************************************
" Abbreviations
" ****************************************************************************

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
ia bind <CR>binding.pry
ia sav <CR>save_and_open_page

"******************************************************************************
" Plug-in Configurations
"******************************************************************************
let g:move_key_modifier = 'S'
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.config/nvim/snippets/'
let g:deoplete#enable_at_startup = 1

" Auto-format
"au InsertLeave * :Autoformat "Auto-formats when leaving insert mode
let g:autoformat_retab = 0 " uses default tabbing

let g:neoformat_enabled_ruby = ['rubybeautify']
let g:neoformat_enabled_go = ['gofmt']
" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 28
let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "!",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✔︎",
      \ "Unknown"   : "?"
      \ }
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Auto open nerdtree when vim is opened
" autocmd VimEnter * NERDTree

" Auto close nerdtree when a file is opened
let NERDTreeQuitOnOpen = 1
" VimTest
let test#strategy = 'neovim'

" Enable AutoSave on Vim startup
let g:auto_save = 1

" VimFugitive
if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" Powerline Symbols for Airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''

" VimAirline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'neodark'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline_section_c = airline#section#create_left([' %l'])
let g:ariline_section_x = 'filetype'
let g:airline_section_y = '%{strftime("%H:%M")}'
let g:airline_section_z = ''
"*****************************************************************************
" Functions
"*****************************************************************************
" Text Wrapping
if !exists('*s:setupWrapping')
  set wm=2
  set textwidth=80
endif

"Automatically delete whitespace, and repositions cursor
autocmd BufWritePre * :%s/\s\+$//e
"*****************************************************************************
" Mappings
"*****************************************************************************

" Map the leader key to SPACE
let mapleader="\<SPACE>"
" Use ; for commands
nnoremap ; :

" Open current file on GitHub
nnoremap <leader>o :Gbrowse<CR>

" Maps G to the enter key for jumping to a line, ex: 223 <enter>
:nnoremap <CR> G

" Buffer switching
map <C-]> :bnext<CR>
map <C-[> :bprev<CR>
map <Leader>q :bd <CR>

" Exit normal
imap <Leader>q <ESC>

"" Clear search
nmap <Leader>s :noh<CR>

" Reload Source
nmap <Leader>r :so %<CR>

" Move line up
nnoremap <S-Up>   :<C-u>silent! move-2<CR>==
" xnoremap <S-Up>   :<C-u>silent! '<S'>move-2<CR>gv=gv
nnoremap <S-Down> :<C-u>silent! move+<CR>==
" xnoremap <S-Down> :<C-u>silent! '<S'>move'>+<CR>gv=gv

"FZF <space> p to open FZF
nmap <leader>p :FZF <CR>
imap <C-f> <plug>(fzf-complete-line)
imap <C-l> <plug>(fzf-complete-word)
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()
" Utili Snips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<C-R>=UltiSnips#ExpandSnippet()"

" NerdTree Mapping
noremap <silent>  <Leader>\ :NERDTreeToggle<CR>
nnoremap <silent> <F2> :NERDTreeFind<CR>
map <Leader>n <plug>NERDTreeTabsToggle<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>

" AutoFormat for NeoFormat
map <Leader>f :Neoformat<CR>

" Format on save for Neoformat
augroup fmt
  autocmd!
  autocmd BufWritePre * :Neoformat
augroup END

" VimTest Mapping
nmap <silent> <leader>T :TestFile <CR>
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Mapping for find and replace
nmap <Leader>s :%s//gc<Left><Left>
