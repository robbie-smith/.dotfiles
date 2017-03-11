"*****************************************************************************
" Auto Commands
"*****************************************************************************
" Automatically resize splits when resizing window
au VimResized * wincmd =
au InsertChange,TextChanged *.rb update | Neomake
au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"Automatically delete whitespace, and repositions cursor
au BufWritePre * :%s/\s\+$//e
"Saves on buffer leave, if changes were made
au InsertLeave * :update
au BufEnter,BufLeave * :nohlsearch
