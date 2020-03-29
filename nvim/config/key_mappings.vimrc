"**********************
" MAPPINGS
"**********************
" Jedi
let g:jedi#smart_auto_mappings = 1
"**********************
" Deoplete
"**********************
"Maps tab and shift-tab to cycle through autocomplete options
inoremap <expr><TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<c-p>" : "\<S-TAB>"
"**********************
" FZF
"**********************
nmap <Leader>o :Files <CR>
imap <C-f> <plug>(fzf-complete-file-ag)
imap <C-l> <plug>(fzf-complete-line)
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
" Searches the project for the word under the cursor
nnoremap <silent> <Leader>f :BLines <C-R><C-W><CR>
nnoremap <silent> <Leader>fa :Lines <C-R><C-W><CR>
noremap <Leader>b :BTags<CR>
nnoremap <silent> <C-b> :BLines <CR>
" Jump to definition functionality
nnoremap <leader>d :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>

function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R')
  endif

  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  \            '| grep -v -a ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')})
endfunction

command! Tags call s:tags()
function! s:align_lists(lists)
  let maxes = {}
  for list in a:lists
    let i = 0
    while i < len(list)
      let maxes[i] = max([get(maxes, i, 0), len(list[i])])
      let i += 1
    endwhile
  endfor
  for list in a:lists
    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
  endfor
  return a:lists
endfunction

function! s:btags_source()
  let lines = map(split(system(printf(
    \ 'ctags -f - --sort=no --excmd=number --language-force=%s %s',
    \ &filetype, expand('%:S'))), "\n"), 'split(v:val, "\t")')
  if v:shell_error
    throw 'failed to extract tags'
  endif
  return map(s:align_lists(lines), 'join(v:val, "\t")')
endfunction

function! s:btags_sink(line)
  execute split(a:line, "\t")[2]
endfunction

function! s:btags()
  try
    call fzf#run({
    \ 'source':  s:btags_source(),
    \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
    \ 'down':    '40%',
    \ 'sink':    function('s:btags_sink')})
  catch
    echohl WarningMsg
    echom v:exception
    echohl None
  endtry
endfunction

command! BTags call s:btags()
"**********************
" NeoSnippet
"**********************
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
"**********************
" NerdTree
"**********************
noremap <silent>  <Leader>\ :NERDTreeToggle<CR>
nnoremap <silent> <F2> :NERDTreeFind<CR>
map <Leader>n <plug>NERDTreeTabsToggle<CR>
nnoremap <Leader>q :bp<CR>:bd! #<CR>
"**********************
" W0rp-Ale
  "**********************
nmap <space>ap <Plug>(ale_previous_wrap)
nmap <space>an <Plug>(ale_next_wrap)
"**********************
" VimFugitive
"**********************
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
nmap <silent> <Leader>t :TestFile <CR>
nmap <silent> <Leader>l :TestNearest<CR>
nmap <silent> <Leader>a :TestSuite<CR>
nmap <silent> <Leader>g :TestVisit<CR>

" Turns off the arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Turns off visual mode
noremap <S-q> <NOP>

" Open current file on GitHub
" noremap <Leader>b :! hub browse<CR>

" Clears the paste mode
noremap <Leader>p :set nopaste<CR>

" Maps G to the enter key for jumping to a line, ex: 223 <enter>
nnoremap <CR> G

" Save
noremap <Leader>w :w <CR>

" Clear search
nmap <Leader>c :nohlsearch<CR>

" Reload Source
nmap <Leader>r :so %<CR>


" AutoFormat
" nmap <s-f> :%s//gc<left><left>
" noremap <s-f> :Autoformat<CR>

" Buffer switching
nmap <silent> <S-TAB> :bprev<CR>
nmap <silent> <TAB> :bnext<CR>

" Maps Ctrl + k/j/h/l to move panes
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

tnoremap <C-D> <C-\><C-n>

" Relative numbering
function! NumberToggle()
if(&relativenumber == 1)
  set nornu
  " set number
else
  set rnu
endif
endfunc

" Toggle between normal and relative numbering.
nnoremap <S-Q> :call NumberToggle()<cr>
" Map jk to escape
inoremap jk <Esc>
" Highlight word under the cursor
nnoremap <expr><c-f> pumvisible() ? "\<c-f>" : "\<#>"
" move to beginning/end of line
nnoremap B ^
nnoremap E $
" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>
"
" Find and Replace
nmap <Leader>s :%s/\<<C-r><C-w>\>//gc<left><left><left>
nmap <c-s> :%s/\<<C-r><C-w>\>//gc<left><left><left>
