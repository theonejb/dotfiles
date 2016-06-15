" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" =============== Vundle Initialization ===============
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdtree.git'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'fholgado/minibufexpl.vim'

Plugin 'altercation/vim-colors-solarized'

Plugin 'tomtom/tlib_vim'
Plugin 'wincent/Command-T'
Plugin 'majutsushi/tagbar'

Plugin 'hynek/vim-python-pep8-indent'
Plugin 'davidhalter/jedi-vim'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'nvie/vim-flake8'
Bundle 'fisadev/vim-isort'
Bundle 'vim-scripts/python.vim'

Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'
Plugin 'Shutnik/jshint2.vim'
Plugin 'leafgarland/typescript-vim'
" Plugin 'clausreinke/typescript-tools.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'digitaltoad/vim-pug'
" Plugin 'ternjs/tern_for_vim'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tpope/vim-surround.git'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'myusuf3/numbers.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'MatchTag'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'tpope/vim-fugitive'
" Plugin 'kien/ctrlp.vim'
" Plugin 'tacahiroy/ctrlp-funky'
Plugin 'tpope/vim-commentary.git'
Plugin 'rking/ag.vim'

Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'mattn/emmet-vim'

Plugin 'godlygeek/tabular.git'

call vundle#end()

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set hidden                      "Allow hidden buffers w/o windows
set encoding=utf-8              "Necessary to show unicode glyphs

"turn on syntax highlighting
syntax on

" ================ Search Settings  =================

" Use Perl/Python regex when searching
nnoremap / /\v
vnoremap / /\v

set incsearch        "Find the next match as we type the search
set ignorecase       "Ignore case while searching except...
set smartcase        "When we use an uppercase char
set hlsearch         "Hilight searches by default
set gdefault         "Substitution is global by default
set viminfo='100,f1  "Save up to 100 marks, enable capital marks

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set listchars=tab:▸\ ,eol:¬,trail:.

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

for f in split(glob('~/.vim/plugin/settings/*.vim'), '\n')
  exe 'source' f
endfor

set exrc   " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files
