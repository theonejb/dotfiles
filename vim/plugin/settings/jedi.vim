let g:jedi#show_call_signatures = "0"
let g:jedi#use_tabs_not_buffers = 0

nnoremap <leader>f :call JediVimSlowInsertFixToggle()<cr>

function! JediVimSlowInsertFixToggle()
  if g:jedi#show_call_signatures
    let g:jedi#show_call_signatures = "0"
  else
    let g:jedi#show_call_signatures = "1"
  endif
endfunction
