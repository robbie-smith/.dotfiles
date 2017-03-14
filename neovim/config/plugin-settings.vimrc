au BufEnter,BufLeave * :nohlsearch
"***********************
" Plug-in Configurations
"***********************
"**********************
" Ale and Neomake
"**********************
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_set_highlights = 0
let g:ale_linters = {'javascript': ['jshint'], 'html': ['tidy']}
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️ '
let g:ale_sign_column_always = 1
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
" Codi
"**********************
let g:codi#width = 90
"**********************
" Deoplete
"**********************
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources={}
let g:deoplete#sources._=['neosnippet', 'buffer', 'file' ]
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
let g:gitgutter_max_signs = 1000
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
let g:UltiSnipsEnableSnipMate=1

let g:UltiSnipsSnippetDirectories=['UltiSnips', $HOME.'/.dotfiles/neovim/mysnippets', 'neosnippet']
let g:neosnippet#enable_snipmate_compatibility=1
"**********************
" VimTest
"**********************
let test#strategy = 'neovim'
"**********************
" VimMarkdown Composer
"**********************
let g:markdown_composer_autostart=0
