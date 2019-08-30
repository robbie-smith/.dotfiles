" Required:
call plug#begin(expand('~/.config/nvim/plugged'))
"*******************
" Coding Assist
"*******************
Plug 'hashivim/vim-terraform'
Plug 'gregsexton/MatchTag'
Plug 'valloric/MatchTagAlways', { 'for': ['html', 'xml'] }
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'janko-m/vim-test', { 'frozen': '1'}
Plug 'tpope/vim-commentary'
" Plug 'ternjs/tern_for_vim', { 'do': 'npm install',  'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'vim-ruby/vim-ruby', { 'for': ['ruby'] }
Plug 'ludovicchabant/vim-gutentags'
Plug 'rizzatti/dash.vim'
Plug 'ecomba/vim-ruby-refactoring'
"*******************
" Formatting/Linting
"*******************
Plug 'w0rp/ale', { 'for': ['javascript', 'html', 'go', 'ruby', 'python']}
Plug 'Chiel92/vim-autoformat'
Plug 'lifepillar/pgsql.vim', { 'for': 'sql' }
Plug 'nvie/vim-flake8'
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
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'jodosha/vim-godebug', { 'for': 'go' , 'do': 'GoInstallBinaries'}
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir'}
Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh', 'for': 'elixir' }
Plug 'tpope/vim-bundler', { 'for': 'ruby'}
Plug 'pangloss/vim-javascript', { 'for': 'javascript'}
Plug 'mxw/vim-jsx', { 'for': 'javascript'}
Plug 'leshill/vim-json'
"**************
" Miscellaneous
"**************
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-journal', { 'for': ['text', 'txt'], 'frozen': '1'}
Plug 'tpope/vim-dispatch'
" Plug 'kassio/neoterm'
Plug 'itchyny/calendar.vim'
"*******************
" Snippets
"*******************
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'shougo/neosnippet'
Plug 'shougo/neosnippet-snippets', { 'frozen': '1'}
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
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
