" Required:
call plug#begin(expand('~/.config/nvim/plugged'))
"*******************
" Coding Assist
"*******************
Plug 'gregsexton/MatchTag'
Plug 'valloric/MatchTagAlways', { 'for': ['html', 'xml'] }
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-commentary'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install',  'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby'] }
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
" Plug 'xolox/vim-easytags'
" Plug 'xolox/vim-misc'
"*******************
" Formatting/Linting
"*******************
Plug 'w0rp/ale', { 'for': ['javascript', 'html', 'go', 'ruby']}
Plug 'Chiel92/vim-autoformat'
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
Plug 'tpope/vim-dispatch'
Plug 'kassio/neoterm'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
"*******************
" Snippets
"*******************
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'honza/vim-snippets', { 'frozen': '1' }
Plug 'shougo/neosnippet'
Plug 'shougo/neosnippet-snippets', { 'frozen': '1'}
Plug 'zchee/deoplete-go', { 'do': 'make'}
"**********
" Visual
"**********
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug '~/.dotfiles/neovim/colors'
call plug#end()
