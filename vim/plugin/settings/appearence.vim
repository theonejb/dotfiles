" Make it beautiful - colors and fonts
"tell the term has 256 colors
"set t_Co=256

" http://ethanschoonover.com/solarized/vim-colors-solarized
let g:solarized_visibility="high"
let g:solarized_contrast="high"
set background=dark

" Don't set the colorscheme in the quake like terminal
if &term != "xterm"
  " colorscheme solarized
  colorscheme molokai
endif

" Show tab number (useful for Cmd-1, Cmd-2.. mapping)
" For some reason this doesn't work as a regular set command,
" (the numbers don't show up) so I made it a VimEnter event
autocmd VimEnter * set guitablabel=%N:\ %t\ %M

set guifont=Source\ Code\ Pro:h14

" Always show status line
set laststatus=2

if has("gui_running")
  set lines=60
  set columns=150
endif
