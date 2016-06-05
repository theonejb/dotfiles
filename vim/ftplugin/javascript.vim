set shiftwidth=4
set softtabstop=4
set tabstop=4

" jshint validation
nnoremap <silent><F7> :JSHint<CR>
inoremap <silent><F7> <C-O>:JSHint<CR>
vnoremap <silent><F7> :JSHint<CR>

" show next jshint error
nnoremap <silent><F8> :lnext<CR>
inoremap <silent><F8> <C-O>:lnext<CR>
vnoremap <silent><F8> :lnext<CR>

" show previous jshint error
nnoremap <silent><F9> :lprevious<CR>
inoremap <silent><F9> <C-O>:lprevious<CR>
vnoremap <silent><F9> :lprevious<CR>
