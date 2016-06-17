if !has('nvim')
    map <leader>T :CommandT<CR>
    map <leader>B :CommandTBuffer<CR>
    map <leader>F :CommandTFlush<CR>

    let g:CommandTWildIgnore=&wildignore . ",**/node_modules/*"
endif
