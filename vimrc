set nocompatible
" for vim-powerline
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs
set visualbell "no pesky terminal bell
set bs=2 "set backspace to be able to delete previous characters
set number "Enable line numbering, taking up 6 spaces

"Turn off word wrapping
set wrap!
" give me a color column at 85
set colorcolumn=85


"Set backspace options to allow saner use
set backspace=indent,eol,start

"Turn on smart indent
set smartindent
set tabstop=2 "set tab character to 2 characters
set softtabstop=2 "allow easy backspace usage
set expandtab "turn tabs into whitespace
set shiftwidth=2 "indent width for autoindent

call pathogen#infect()

filetype on
filetype plugin on
filetype indent on "indent depends on filetype

"Turn on incremental search with ignore case (except explicit caps)
set incsearch
set ignorecase
set smartcase

"Informative status line
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]

"Set color scheme
set background=dark
colorscheme solarized
syntax enable

"Set font and size
set gfn=Inconsolata-dz\ for\ Powerline:h14

"Have 5 lines of offset (or buffer) when scrolling
set scrolloff=5

" coffee-script support 
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent

" django html template filetype setting
au BufNewFile,BufReadPost *.dhtml set filetype=htmldjango.html.javascript
au BufWritePost *.dhtml set filetype=htmldjango.html.javascript

" python support 
au BufNewFile,BufReadPost *.py setl foldmethod=indent nosmartindent

" snipmate snippets config
source /Users/asad/.vim/bundle/snipmate/snippets/support_functions.vim

" allow buffer switching without unsaved warning
set hidden

" custom leader key
let mapleader=","

"Shortcut to auto indent entire file
nmap <leader>= 1G=G
imap <leader>= <ESC>1G=Ga

" Shortcut to rapidly toggle `set list`
nmap <leader>tl :set list!<CR>
" Set encoding to utf-8 to allow showing unicode chars
set encoding=utf-8
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:.

" allow easy editing/sourcing of the .vimrc file
nmap <leader>ve :tabedit ~/.vimrc<CR>
nmap <leader>vs :source ~/.vimrc<CR>

" allow easy handling of tabs
nmap <C-t> :tab new<CR>
nmap <leader>l :tabnext<CR>
nmap <leader>h :tabprevious<CR>
nmap <leader>tc :tabclose<CR>
nmap <leader>te :tabedit<Space>

" easy way to run macro on visual selection
vmap <leader>@ :normal @

" easy autocomplete with Ctrl+Space
imap <C-Space> <C-n>

" NERDTree easy access
nmap <Leader>nt <plug>NERDTreeTabsToggle<CR>

" map F10 to allow refreshing syntax highligh
noremap <Leader>sr <Esc>:syntax sync fromstart<CR>

" vim-powerline opts
let g:Powerline_symbols='fancy'
let g:Powerline_theme='default'
let g:Powerline_colorscheme='skwp'

" ==============================
" Window/Tab/Split Manipulation
" ==============================
" Move between split windows by using the four directions H, L, I, N
" (note that  I use I and N instead of J and K because  J already does
" line joins and K is mapped to GitGrep the current word
nnoremap <silent> H <C-w>h
nnoremap <silent> L <C-w>l
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <leader>w <C-w>w

" Zoom in and out of current window with ,gz
map <silent> ,gz <C-w>o

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
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" Resize windows with arrow keys
nnoremap <D-Up> <C-w>+
nnoremap <D-Down> <C-w>-
nnoremap <D-Left> <C-w><
nnoremap <D-Right>  <C-w>>

" always start in the ~/.Programming direcotry
cd ~/Programming/
