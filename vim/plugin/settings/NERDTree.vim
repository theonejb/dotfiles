" Make nerdtree look nice
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30

" Ignore python compiled files
let NERDTreeIgnore = ['\.pyc$']

" Keybinding to show current file in tree
map <leader>nf :NERDTreeFind<CR>
