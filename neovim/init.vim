set nocompatible               " Be iMproved

" Path for python
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Enable filetype detection
filetype on

" Path for plug
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
" Reload files changed outside vim
set autoread
" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

"*****************************************************************************
" Plug install packages
"*****************************************************************************
" Color Schemes
" Plug 'davb5/wombat256dave'
Plug 'KeitaNakamura/neodark.vim'
Plug 'morhetz/gruvbox'
" Plug 'AlessandroYorba/Alduin'
" Plug 'AlessandroYorba/sidonia'
" Plug 'junegunn/seoul256.vim'
" Plug 'junegunn/zenburn'
Plug 'mhartington/oceanic-next'
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
Plug 'neomake/neomake'
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
" AutoSave
Plug '907th/vim-auto-save'
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
if (has("termguicolors"))
  set termguicolors
endif
"**********************
" color scheme
"**********************
" let g:neodark#background='black' " black, gray or brown
" colorscheme neodark
set background=dark
colorscheme OceanicNext
" Makes the highlighting better for the OceanicNext theme
highlight LineNr guibg=#1b2b34
hi GitGutterChange guibg=#1b2b34
hi GitGutterAdd  guibg=#1b2b34
hi GitGutterDelete guibg=#1b2b34
hi GitGutterChangeDelete guibg=#1b2b34
" colorscheme gruvbox
"**********************
" status bar
"**********************
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
"****************************************************************************
" Abbreviations
"****************************************************************************
ia sav <CR>save_and_open_page
"******************************************************************************
" Plug-in Configurations
"******************************************************************************
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
let g:airline_symbols.branchi = ''
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
" Autosave
"**********************
au BufWrite * :Autoformat
"**********************
" Autosave
"**********************
" Enable AutoSave on Vim startup
let g:auto_save = 1
"**********************
" FZF
"**********************
nmap <leader>o :FZF <CR>
imap <C-f> <plug>(fzf-complete-file-ag)
imap <C-l> <plug>(fzf-complete-line)
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
" Integrates ripgrep with FZF to search through my files
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
"**********************
" Deoplete
"**********************
" For some reason these keybindings have to come after the FZF set up. Or
" Deoplete will expand snippets and there will be an empty line and no
" indentation.
let g:deoplete#enable_at_startup = 1
" let g:deoplete#sources = {}
" let g:deoplete#sources._=['omni', 'buffer', 'ultisnips', 'vim-snippets', 'neosnippet-snippets', 'file']
"Maps shift-k and shift-j to cycle through autocomplete options
let g:neosnippet#snippets_directory='~/.config/nvim/plug/vim-snippets/snippets'
inoremap <expr><S-k> pumvisible() ? "\<c-n>" : "\<S-k>"
inoremap <expr><S-j> pumvisible() ? "\<c-p>" : "\<S-j>"
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
" Functions
"*****************************************************************************
"Text Wrapping
if !exists('*s:setupWrapping')
  set wm=2
  set textwidth=80
endif
"Automatically delete whitespace, and repositions cursor
autocmd BufWritePre * :%s/\s\+$//e
"*****************************************************************************
" Mappings
"*****************************************************************************
" Open current file on GitHub
noremap <leader>g :Gbrowse<CR>
" Maps G to the enter key for jumping to a line, ex: 223 <enter>
nnoremap <CR> G
" Buffer switching
nmap <silent> <leader>] :bnext<CR>
nmap <silent> <leader>[ :bprev<CR>
" Exit normal
imap <Leader>q <ESC>
" Clear search
nmap <Leader>c :noh<CR>
" Reload Source
nmap <Leader>r :so %<CR>
" Find and replace
nmap <leader>s :%s//gc<left><left>
" Maps Shift + k/j/h/l to move panes
nmap <silent> <s-j> :wincmd j<cr>
nmap <silent> <s-k> :wincmd k<cr>
nmap <silent> <s-h> :wincmd h<cr>
nmap <silent> <s-l> :wincmd l<cr>

