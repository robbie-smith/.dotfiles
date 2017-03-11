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
au InsertLeave * :Autoformat
