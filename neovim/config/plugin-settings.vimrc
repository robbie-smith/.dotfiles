"***********************
" Plug-in Configurations
"***********************
"**********************
" Ale/Neomake/Syntastic
"**********************
let g:ale_warn_about_trailing_whitespace = 1
let g:ale_set_highlights = 0
" let g:ale_emit_conflict_warnings = 0
let g:ale_linters = {'javascript': ['jshint'], 'html': ['tidy'], 'go': ['golint'], 'ruby': ['rubocop']}
let g:ale_fixers = {
      \ 'javascript': ['jshint'],
      \ 'ruby': ['rubocop']
      \}
" let g:ale_sign_error = '❌'
" let g:ale_sign_warning = '⚠️ '
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 1
let g:neomake_error_sign = {'text':  '>>', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = { 'text': '--', 'texthl': 'NeomakeWarningSign'}
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
let g:airline#extensions#ale#enabled = 1
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
let g:autoformat_remove_trailing_spaces = 1
autocmd FileType javascript,ruby let b:autoformat_remove_trailing_spaces=1
autocmd FileType ruby let b:autoformat_autoindent=1
"**********************
" Codi
"**********************
let g:codi#width = 90
"**********************
" Deoplete
"**********************
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources={}
let g:deoplete#sources._=['buffer', 'file', 'neosnippet', $HOME.'/.dotfiles/neovim/mysnippets']
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
"**********************
" FZF
"**********************
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
" GitGutter
"**********************
let g:gitgutter_highlight_lines = 0
set signcolumn=yes
let g:gitgutter_max_signs = 1000
"**********************
" Vim-Go
"**********************
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_snippet_engine = "neosnippet"
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
"**********************
" UltiSnips
"**********************
let g:neosnippet#snippets_directory=[$HOME.'/.dotfiles/neovim/mysnippets', 'neosnippet']
let g:neosnippet#enable_snipmate_compatibility=1
"**********************
" Vim-Easytags
"**********************
set tags="./tags"
let g:easytags_dynamic_files = 1
let g:easytags_updatetime_min = 4000
let g:easytags_async = 1
"**********************
"**********************
" Vim-Javascript
"**********************
let g:javascript_plugin_flow = 1
"**********************
" Vim-jsx
"**********************
let g:jsx_ext_required = 0
"**********************
"**********************
" VimTest
"**********************
let test#strategy = 'neovim'
