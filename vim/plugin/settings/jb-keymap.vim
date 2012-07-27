" Shortcut to auto indent entire file
nmap <leader>= 1G=G
imap <leader>= <ESC>1G=Ga

" Shortcut to rapidly toggle `set list`
nmap <leader>tl :set list!<CR>

" allow easy editing/sourcing of the .vimrc file
nmap <leader>ve :tabedit ~/.vimrc<CR>
nmap <leader>vs :source ~/.vimrc<CR>

" allow easy handling of tabs
nmap <C-t>      :tabnew<CR>
nmap <leader>l  :tabnext<CR>
nmap <leader>h  :tabprevious<CR>
nmap <leader>tc :tabclose<CR>
nmap <leader>te :tabedit<Space>

" easy way to run macro on visual selection
vmap <leader>@ :normal @

" easy autocomplete with Ctrl+Space
imap <C-Space> <C-n>

nmap <leader>nt :NERDTreeTabsToggle<CR>
