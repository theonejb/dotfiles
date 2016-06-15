set wildignore+=*.pyc,.git

" close the preview window when autocompletion done
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
