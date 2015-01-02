" Shortcut to auto indent entire file
nmap <leader>= 1G=G
imap <leader>= <ESC>1G=Ga

" Shortcut to rapidly toggle `set list`
nmap <leader>tl :set list!<CR>

" allow easy editing/sourcing of the .vimrc file
nmap <leader>ve :tabedit ~/.vimrc<CR>
nmap <leader>vs :source ~/.vimrc<CR>

" allow easy handling of tabs
nmap <D-t>      :tabnew<CR>
nmap <leader>l  :tabnext<CR>
nmap <leader>h  :tabprevious<CR>
nmap <Right>    :tabnext<CR>
nmap <Left>     :tabprevious<CR>
nmap <leader>tc :tabclose<CR>
nmap <leader>te :tabedit<Space>
nmap <leader>tf :tabm +1<CR>
nmap <leader>tb :tabm -1<CR>
nmap <leader>tm :tabm<Space>

" allow easy movement between horizontal windows
nnoremap <silent> H <C-w>h
nnoremap <silent> L <C-w>l

" easy way to run macro on visual selection
vmap <leader>@ :normal @

" easy autocomplete with Ctrl+Space
imap <C-Space> <C-n>

" alias yw to 'yank inner word'
nnoremap ,yw yiww
" make Y yank entire line, like C or D
nnoremap Y y$
" Open the project tree and expose current file in the nerdtree with Ctrl-\
nnoremap <silent> <C-\> :NERDTreeFind<CR>
" Use numbers to pick the tab you want (like iTerm)
map <silent> <D-1> :tabn 1<cr>
map <silent> <D-2> :tabn 2<cr>
map <silent> <D-3> :tabn 3<cr>
map <silent> <D-4> :tabn 4<cr>
map <silent> <D-5> :tabn 5<cr>
map <silent> <D-6> :tabn 6<cr>
map <silent> <D-7> :tabn 7<cr>
map <silent> <D-8> :tabn 8<cr>
map <silent> <D-9> :tabn 9<cr>
" Create window splits easier. The default
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s
" Resize windows with arrow keys
nnoremap <D-Up> <C-w>+
nnoremap <D-Down> <C-w>-
nnoremap <D-Left> <C-w><
nnoremap <D-Right>  <C-w>>
"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" Allow easy change between large and normal font size on MacVim
if has("gui_running")
  function! ToggleTextSize()
    if exists("g:large_text")
      set guifont=Source\ Code\ Pro:h14
      unlet g:large_text
    else
      set guifont=Source\ Code\ Pro:h17
      let g:large_text=1
    endif
  endfunction
  nmap <leader>tF :call ToggleTextSize()<CR>
endif

" Allow easier management of virtualenvs
nmap <leader>ed :VirtualEnvDeactivate<CR>
nmap <leader>el :VirtualEnvList<CR>
nmap <leader>ea :VirtualEnvActivate 
