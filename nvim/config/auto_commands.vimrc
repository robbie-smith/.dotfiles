"*****************************************************************************
" Auto Commands
"*****************************************************************************
" Automatically resize splits when resizing window
au VimResized * wincmd =
" au BufLeave,InsertChange,TextChanged *.rb update | Neomake
au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"Automatically delete whitespace, and repositions cursor
au BufWritePre,InsertLeave * :%s/\s\+$//e
"Saves on buffer leave, if changes were made
au InsertLeave * :update
" Clears out the search registery, no more highlights in a random places
au VimEnter,VimLeavePre * :let @/=""
