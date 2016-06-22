" Settings for the CtrlP extension
map <C-t> :CtrlPSmartTabs<CR>
nnoremap <C-r> :CtrlPFunky<Cr>
" Use the PWD as the starting point. No fancy stuff
let g:ctrlp_working_path_mode=0

let g:ctrlp_extensions = ['funky']
let g:ctrlp_funky_matchtype = 'path'
