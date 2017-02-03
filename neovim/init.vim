set nocompatible               " Be iMproved
" Path for python
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" Enable filetype detection
filetype on
" Path for plug
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
" The Silver Searcher
let g:ackprg = 'ag --vimgrep'
" Reload files changed outside vim
set autoread
" Required:
call plug#begin(expand('~/.config/nvim/plugged'))
"*****************************************************************************
" Plug install packages
"*****************************************************************************
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" AutoSave
Plug '907th/vim-auto-save'
" Color Schemes
Plug 'davb5/wombat256dave'
Plug 'KeitaNakamura/neodark.vim'
Plug 'morhetz/gruvbox'
" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Fugitive(git-addon)
Plug 'tpope/vim-fugitive'
" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" GitGutter
Plug 'airblade/vim-gitgutter'
" NeoMake
Plug 'neomake/neomake'
" NerdTree
Plug 'scrooloose/nerdtree'
" NerdTree Git Plugin
Plug 'Xuyuanp/nerdtree-git-plugin'
" NeoSnippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" Nvim GO
Plug 'zchee/nvim-go', { 'do': 'make'}
" Ulti Snips engine
Plug 'SirVer/ultisnips'
" Vim AutoFormat
Plug 'Chiel92/vim-autoformat'
" Vim Bundler
Plug 'tpope/vim-bundler'
" Vim Commentary
Plug 'tpope/vim-commentary'
" Vim Polyglot
Plug 'sheerun/vim-polyglot'
" Vim Snippets
Plug 'honza/vim-snippets'
" Vim Surround
Plug 'tpope/vim-surround'
" VimTest
Plug 'janko-m/vim-test'
" Vim Rails
Plug 'tpope/vim-rails'
call plug#end()
"*****************************************************************************
" Basic Setup
"*****************************************************************************
" Encoding
set encoding=utf-8
" Highlight cursor line
set cursorline
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
filetype plugin on
set clipboard=unnamed
set mouse=a
" Map the leader key to SPACE
let mapleader="\<SPACE>"
" Use ; for commands
nnoremap ; :
"Text Wrapping
if !exists('*s:setupWrapping')
  set wm=2
  set textwidth=80
endif

"Automatically delete whitespace, and repositions cursor
autocmd BufWritePre * :%s/\s\+$//e
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
filetype plugin indent on
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
" Automatically resize splits when resizing window
autocmd VimResized * wincmd =
" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
syntax on
syntax enable
set ruler
set number
" Tell the term has 256 colors
if has("gui_running")
  set t_Co=256
end
"**********************
" color scheme
"**********************
"colorscheme gruvbox
"colorscheme wombat256dave
let g:neodark#background='brown' " black, gray or brown
colorscheme neodark
" sets dark mode
" set background=dark
"**********************
" status bar
"**********************
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
"****************************************************************************
" Abbreviations
"****************************************************************************
ia sav <CR>save_and_open_page
"****************************************************************************
" Plug-in Configurations
"****************************************************************************
"**********************
" Airline
"**********************
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
let g:airline_powerline_fonts = 1
let g:airline_theme = 'neodark'
let g:airline_skip_empty_sections = 1
let g:airline#extensions#neomake#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_y = '%{strftime("%H:%M")}'
call airline#parts#define_raw('linenr', '%l:%c')
call airline#parts#define_accent('linenr', 'bold')
let g:airline_section_z = airline#section#create([
      \ g:airline_symbols.linenr .' ', 'linenr'])
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'y', 'z', 'error', 'warning']
      \ ]
"**********************
" Autoformat
"**********************
au BufWrite * :Autoformat
" let g:formatters_javascript =['eslint']
"**********************
" Autosave
"**********************
" Enable AutoSave on Vim startup
let g:auto_save = 1
"**********************
" Deoplete
"**********************
let g:deoplete#enable_at_startup = 1
"Set shift-k and shift-j to cycle through autocomplete options
inoremap <expr><S-k> pumvisible() ? "\<c-n>" : "\<S-k>"
inoremap <expr><S-j> pumvisible() ? "\<c-p>" : "\<S-j>"
"**********************
" FZF
"**********************
nmap <leader>p :FZF <CR>
imap <C-f> <plug>(fzf-complete-file-ag)
imap <C-l> <plug>(fzf-complete-line)
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
"**********************
" NeoMake
"**********************
autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_error_sign = {'text': '❌', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {
      \   'text': '⚠️ ',
      \   'texthl': 'NeomakeWarningSign',
      \ }
let g:neomake_message_sign = {
      \   'text': '➤',
      \   'texthl': 'NeomakeMessageSign',
      \ }
let g:neomake_info_sign = {'text': '⁉️ ', 'texthl': 'NeomakeInfoSign'}
let g:neomake_ruby_enabled_makers = ['mri']
"**********************
" NerdTree
"**********************
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

" Auto close nerdtree when a file is opened
let NERDTreeQuitOnOpen = 1
" NerdTree Mappings
noremap <silent>  <Leader>\ :NERDTreeToggle<CR>
nnoremap <silent> <F2> :NERDTreeFind<CR>
map <Leader>n <plug>NERDTreeTabsToggle<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>
"**********************
" Utili Snips
"**********************
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"
"**********************
" VimFugitive
"**********************
if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif
"**********************
" VimTest
"**********************
let test#strategy = 'neovim'
nmap <silent> <leader>T :TestFile <CR>
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>g :TestVisit<CR>
"*****************************************************************************
" Mappings
"*****************************************************************************
" Open current file on GitHub
nnoremap <leader>o :Gbrowse<CR>
" Maps G to the enter key for jumping to a line, ex: 223 <enter>
nnoremap <CR> G
" Buffer switching
map <silent> <leader>l :bnext<CR>
map <silent> <leader>h :bprev<CR>
" Exit normal
imap <Leader>q <ESC>
" Clear search
nmap <Leader>c :noh<CR>
" Reload Source
nmap <Leader>r :so %<CR>
" Find and replace
nmap <leader>s :%s//gc<left><left>
nmap <silent> <s-k> :wincmd k<cr>
nmap <silent> <s-j> :wincmd j<cr>
nmap <silent> <s-h> :wincmd h<cr>
nmap <silent> <s-l> :wincmd l<cr>
