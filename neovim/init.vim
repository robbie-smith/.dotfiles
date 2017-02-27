set nocompatible               " Be iMproved

" Path for python
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Enable filetype detection
filetype on
set rtp+='/usr/local/bin'
set rtp+='/usr/local/Cellar'
" Path for plug
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
" Reload files changed outside vim
set autoread
" Required:
call plug#begin(expand('~/.config/nvim/plugged'))
"*****************************************************************************
" Plug install packages
"*****************************************************************************
Plug 'w0rp/ale'
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
" Plug 'neomake/neomake'
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
" Vim Elixir
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'elixir-lang/vim-elixir'
Plug 'thinca/vim-ref'
Plug 'metakirby5/codi.vim'
Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' }
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
colorscheme Tomorrow-Night-Eighties
set background=dark
" Makes the highlighting better for the OceanicNext theme
"**********************
" status bar
"**********************
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
"****************************************************************************
" Abbreviations
"****************************************************************************
"******************************************************************************
" Plug-in Configurations
"******************************************************************************
" let g:ale_linters = {
"       \   'javascript': ['eslint'],
"       \}
" let g:ale_html_tidy_executable = 'tidy'
" let g:neomake_jsx_enabled_makers = ['eslint']
" augroup FiletypeGroup
"   autocmd!
"   au BufNewFile,BufRead *.jsx set filetype=js
" augroup END
" let g:neomake_javascript_eslint_exe='/usr/local/bin/eslint'
" let g:neomake_javascript_enabled_makers = ['eslint']
" let g:neomake_verbose=3
" let g:ale_javascript_eslint_use_global = 1
" let g:ale_linters = {
"       \   'javascript': ['jscs'],
"       \}
" let g:neomake_logfile='/tmp/error.log'
" let g:ale_sign_column_always = 1
" let g:neomake_open_list = 2
" let g:neomake_javascript_enabled_makers = ['jshint']
" let b:neomake_javascript_jscs_exe = '/usr/local/bin/jshint'
" let g:neomake_javascript_jscs_maker = {
"       \ 'exe': 'jshint',
"       \ 'args': ['-c'],
"       \ 'errorformat': '%f: line %l\, col %c\, %m',
"       \ }
let g:ale_linters = {'javascript': ['jshint']}
hi ALEErrorSign guibg=#1b2b34
hi ALEWarningSign guibg=#1b2b34
" let g:ale_sign_error = '>>'
" let g:ale_sign_warning = '--'
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️ '
let g:ale_sign_column_always = 1
" autocmd! BufWritePost,BufEnter * Neomake
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
let g:airline_theme = 'onedark'
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
au InsertLeave * :Autoformat
"**********************
" Codi
"**********************
let g:codi#width = 90
"**********************
" FZF
"**********************
nmap <Leader>o :FZF <CR>
imap <C-f> <plug>(fzf-complete-file-ag)
imap <C-l> <plug>(fzf-complete-line)
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

nnoremap <silent> <Leader>f :Rg <C-R><C-W><CR>
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
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0)
"**********************
" Deoplete
"**********************
" For some reason these keybindings have to come after the FZF set up. Or
" Deoplete will expand snippets and there will be an empty line and no
" indentation.
let g:deoplete#enable_at_startup = 1
"Maps shift-k and shift-j to cycle through autocomplete options
let g:neosnippet#snippets_directory='~/.config/nvim/plug/vim-snippets/snippets'
inoremap <expr><S-k> pumvisible() ? "\<c-n>" : "\<S-k>"
inoremap <expr><S-j> pumvisible() ? "\<c-p>" : "\<S-j>"
"**********************
" NeoMake
"**********************
" autocmd! BufWritePost,BufEnter * Neomake
" hi NeomakeErrorSign guibg=#1b2b34
" hi NeomakeWarningSign guibg=#1b2b34
" let g:neomake_error_sign = {'text':  '❌', 'texthl': 'NeomakeErrorSign'}
" let g:neomake_warning_sign = { 'text': '⚠️ ', 'texthl': 'NeomakeWarningSign'}
" let g:neomake_ruby_enabled_makers = ['mri']
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
nnoremap <Leader>q :bp<CR>:bd #<CR>
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
nnoremap <space>ga :Gwrite<CR><CR>
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gd :Gvdiff<CR>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>gcb :Git checkout<Space>
nnoremap <space>gc :Gcommit -v -q<CR>
nnoremap <space>gp :Gpush<CR>
"**********************
" VimTest
"**********************
let test#strategy = 'neovim'
nmap <silent> <Leader>t :TestFile <CR>
nmap <silent> <Leader>l :TestNearest<CR>
nmap <silent> <Leader>a :TestSuite<CR>
nmap <silent> <Leader>g :TestVisit<CR>
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
" autocmd BufWritePre * :Autoformat
autocmd InsertLeave * :update
"*****************************************************************************
" Mappings
"*****************************************************************************
" Turns off the arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
imap <Up> <NOP>
imap <Down> <NOP>
imap <Left> <NOP>
imap <Right> <NOP>
" Open current file on GitHub
noremap <Leader>b :! hub browse<CR>
" Clears the paste mode
noremap <Leader>p :set nopaste<CR>
" Maps G to the enter key for jumping to a line, ex: 223 <enter>
nnoremap <CR> G
" Save
noremap <Leader>w :w <CR>
" nmap <c-q> <ESC>
" Exit normal
" imap <Leader>q <ESC>
" Clear search
nmap <Leader>c :nohlsearch<CR>
" Reload Source
nmap <Leader>r :so %<CR>
" Find and replace
nmap <Leader>s :%s//gc<left><left>
" AutoFormat
noremap <s-f> :Autoformat<CR>
" Buffer switching
nmap <silent> <s-h> :bprev<CR>
nmap <silent> <s-l> :bnext<CR>
" nmap <silent> <Leader>[ :bprev<CR>
" nmap <silent> <Leader>] :bnext<CR>

" Maps Shift + k/j/h/l to move panes
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
nmap <silent> <c-q> :q <CR>
