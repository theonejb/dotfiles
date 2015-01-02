nnoremap <leader>f :call JediVimSlowInsertFixToggle()<cr>

function! JediVimSlowInsertFixToggle()
  if g:jedi#show_call_signatures
    let g:jedi#show_call_signatures = "0"
  else
    let g:jedi#show_call_signatures = "1"
  endif
endfunction
