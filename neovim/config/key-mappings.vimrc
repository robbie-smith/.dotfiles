"*****************************************************************************
" MAPPINGS
"*****************************************************************************
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
"**********************
" Deoplete
"**********************
"Maps shift-k and shift-j to cycle through autocomplete options
inoremap <expr><S-k> pumvisible() ? "\<c-n>" : "\<S-k>"
inoremap <expr><S-j> pumvisible() ? "\<c-p>" : "\<S-j>"
"**********************
" NerdTree
"**********************
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
" Open current file on GitHub
noremap <Leader>b :! hub browse<CR>
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
noremap <S-q> <NOP>
