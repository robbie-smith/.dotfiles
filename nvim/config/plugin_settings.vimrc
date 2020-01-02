"***********************
" Plug-in Configurations
"***********************
"**********************
" Ale/Neomake/Syntastic
"**********************
let g:ale_warn_about_trailing_whitespace = 1
let g:ale_set_highlights = 0
" let g:ale_emit_conflict_warnings = 0
let g:ale_linters = {'javascript': ['jshint'], 'html': ['tidy'], 'go': ['golint'], 'ruby': ['rubocop'], 'python' : ['flake8', 'pylint', 'black']}
let g:ale_fixers = {'javascript': ['jshint'], 'ruby': ['rubocop'], 'python' : ['black']}
" let g:ale_sign_error = '❌'
" let g:ale_sign_warning = '⚠️ '
let g:ale_set_signs = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 1
"**********************
" Airline
"**********************
" Powerline Symbols for Airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_theme = 'onedark'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branchi = ''
let g:airline_symbols.readonly = ''
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#ale#enabled = 1
" let g:airline#extensions#ale#error_symbol = 'E:'
" let g:airline#extensions#ale#warning_symbol = 'W:'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#hunks#enabled = 1
" let g:airline_section_y = '%{strftime("%H:%M")}'
" call airline#parts#define_raw('linenr', '%l:%c')
" call airline#parts#define_accent('linenr', 'bold')
" let g:airline_section_z = airline#section#create([
      " \ g:airline_symbols.linenr .' ', 'linenr'])
" let g:airline#extensions#default#layout = [
"       \ [ 'a', 'b', 'c', 'error', 'warning' ],
"       \ [ 'x', 'y', 'z']
"       \ ]
call airline#parts#define_function('ALE', 'ALEGetStatusLine')
call airline#parts#define_condition('ALE', 'exists("*ALEGetStatusLine")')
let g:airline_section_error = airline#section#create_left(['ALE'])
" let g:airline_section_error = '%{exists("ALEGetStatusLine") ? ALEGetStatusLine() : ""}'
"**********************
" Autoformat
"**********************
let g:formatterpath = ['~/.rbenv/shims/rubocop', '/usr/local/bin/flake8']
let g:format_ruby_style = 'rubocop'
let g:formatters_python = ['autopep8', 'pep8', 'black']
autocmd FileType ruby let b:autoformat_autoindent=1
let g:autoformat_remove_trailing_spaces = 1
"**********************
" Deoplete
"**********************
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources={}
call deoplete#custom#option('sources', {
\ '_': ['ale'],
\})
let g:deoplete#sources._=['buffer', 'file', 'neosnippet', $HOME.'/.dotfiles/nvim/mysnippets']
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
"**********************
" FZF
"**********************
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
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
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
"**********************
" GitGutter
"**********************
let g:gitgutter_highlight_lines = 0
let g:gitgutter_max_signs = 500
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
let g:go_auto_sameids = 0
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
" NeoSnippet
"**********************
let g:neosnippet#snippets_directory=[$HOME.'/.dotfiles/nvim/mysnippets', 'neosnippet']
let g:neosnippet#enable_snipmate_compatibility=1
"**********************
" Vim-Javascript
"**********************
let g:javascript_plugin_flow = 1
"**********************
" Vim-jsx
"**********************
let g:jsx_ext_required = 0
"**********************
" Vim-Ruby
"**********************
" let ruby_fold = 1
let ruby_spellcheck_strings = 1
let ruby_foldable_groups = 'def'
"**********************
" VimTest
"**********************
" let test#strategy = 'neovim'
" let test#strategy = 'neoterm'
" let test#strategy = 'terminal'
" let test#filename_modifier = ':~'
" let g:test#preserve_screen = 1

let test#strategy = 'iterm'
let test#python#pytest#options = {
  \ 'all': '-s',
  \ 'nearest': '-v',
  \ 'file':    '-v',
  \ 'suite':   '-v',
\}

let test#ruby#rspec#options = '--format documentation'
let test#ruby#rspec#options = {
  \ 'nearest': '--backtrace',
  \ 'file':    '--format documentation',
  \ 'suite':   '--tag ~slow',
\}
" let test#ruby#use_binstubs = 0
