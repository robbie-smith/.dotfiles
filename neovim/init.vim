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
Plug 'chriskempson/base16-vim'
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
" Automatically resize splits when resizing window
" au VimResized * wincmd =
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
"**********************
" status bar
"**********************
" set laststatus=2
" set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
"******************************************************************************
" Plug-in Configurations
"******************************************************************************
"**********************
" Ale and Neomake
"**********************
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_set_highlights = 0
let g:ale_linters = {'javascript': ['jshint'], 'html': ['tidy']}
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️ '
let g:ale_sign_column_always = 1

" au InsertChange,TextChanged *.rb update | Neomake
let g:neomake_error_sign = {'text':  '❌', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = { 'text': '⚠️ ', 'texthl': 'NeomakeWarningSign'}
let g:neomake_ruby_enabled_makers = ['mri']
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
      \ [ 'y', 'z']
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
" Searches the project for the word under the cursor
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
" GitGutter
"**********************
let g:gitgutter_highlight_lines = 0
"**********************
" NerdTree
"**********************
" Auto close nerdtree when a file is opened
let NERDTreeQuitOnOpen = 1
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
" au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

noremap <silent>  <Leader>\ :NERDTreeToggle<CR>
nnoremap <silent> <F2> :NERDTreeFind<CR>
map <Leader>n <plug>NERDTreeTabsToggle<CR>
nnoremap <Leader>q :bp<CR>:bd #<CR>
"**********************
" Utili snips
"**********************
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"
"**********************
" VimFugitive
"**********************
" if exists("*fugitive#statusline")
"   set statusline+=%{fugitive#statusline()}
" endif

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
"**********************
" VimMarkdown Composer
"**********************
let g:markdown_composer_autostart=0
"*****************************************************************************
" Auto Commands
"*****************************************************************************
" Automatically resize splits when resizing window
au VimResized * wincmd =
au InsertChange,TextChanged *.rb update | Neomake
au InsertLeave * :Autoformat
au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"Automatically delete whitespace, and repositions cursor
au BufWritePre * :%s/\s\+$//e
" au BufWritePre * :Autoformat
au InsertLeave * :update
"*****************************************************************************
" MAPPINGS
"*****************************************************************************
" Turns off the arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
" Open current file on GitHub
noremap <Leader>b :! hub browse<CR>
" Clears the paste mode
noremap <Leader>p :set nopaste<CR>
" Maps G to the enter key for jumping to a line, ex: 223 <enter>
nnoremap <CR> G
nnoremap <Leader>j <gu>
" Save
noremap <Leader>w :w <CR>
" Clear search
nmap <Leader>c :nohlsearch<CR>
" Reload Source
nmap <Leader>r :so %<CR>
" Find and Replace
nmap <Leader>s :%s//gc<left><left>
" AutoFormat
noremap <s-f> :Autoformat<CR>
" Buffer switching
nmap <silent> <s-h> :bprev<CR>
nmap <silent> <s-l> :bnext<CR>
" Maps Shift + k/j/h/l to move panes
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
" Map Ctrl + q to close a window
nmap <silent> <c-q> :q <CR>
