" .vimrc file
"
" Initialization commands for Vim

set nocompatible        " Set vi compatibility off

syntax on               " Turn on syntax highlighting 
colorscheme desert      " Our default color scheme

set number              " Display numbering on the left
set relativenumber      " Numbering is relative to current line

set laststatus=2        " Always display a status bar
set showmode            " Display current mode in status bar
set ruler               " Display current cursor position in status bar
set showcmd             " Display an incomplete command in status bar
set shortmess+=r        " Use shorter message for [readonly] in status bar

set incsearch           " Display the match of a search pattern while typing it
set hlsearch            " Highlight matches of the last used search pattern
set history=50          " Keep 50 commands and search patterns in the history

set autoindent          " Use the indent of the previous line on the new line
set backspace=2         " Allow backspacing over indent, eol, and start

set nowrap              " Disable wrapping of lines
set textwidth=80        " Maximum width of the text that is being inserted
set formatoptions-=t    " Auto-wrap text using textwidth

set showmatch           " Highlight the matching bracket
set matchpairs+=<:>     " Include anger brackets in showmatch

set splitright          " Split vertically to the right
set splitbelow          " Split horizontally to the bottom

set lazyredraw          " Screen will not be redrawn during macro execution
set scrolloff=4         " Number of lines to keep above and below the cursor
set ttyfast             " Indicates a fast terminal connection
set nostartofline       " On movement, keep cursor in same column if possible
set autowrite           " Automatically write the file before some commands


" File type detection

filetype on             " Enable filetype detection
filetype indent on      " Use filetype-specific indentation
filetype plugin on      " Use filetype-specific plugins

" tabstop      changes the width of a TAB character
" softtabstop  affects what happens when you press TAB or BS
" shiftwidth   affects >> << and ==
" expandtab    if set, will insert 'softtabstop'spaces, otherwise tabs

autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2 textwidth=80
autocmd FileType bash setlocal expandtab shiftwidth=2 softtabstop=2 textwidth=80
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2 textwidth=80
autocmd FileType text setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType yaml setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType xml setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType css setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2 textwidth=80
autocmd FileType java setlocal expandtab shiftwidth=2 softtabstop=2 textwidth=100
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 textwidth=79
autocmd FileType markdown setlocal expandtab shiftwidth=4 softtabstop=4


" Custom mappings --

let mapleader = ","

" Toggle spelling
map <Leader>S :set spell!<CR>

" Toggle paste
map <Leader>P :set paste!<CR>

" Reload .vimrc
map <Leader>v :so ~/.vimrc<CR>

" Explore in new window
map <Leader>e :Sexplore!<CR>

" Nerd tree
map <Leader>t :NERDTree<CR>

" Ctrl-p
map <Leader>f :CtrlP<CR>

" Tab navigation
nmap <C-J> :tabnext<CR>
nmap <C-K> :tabprev<CR>

" Append a single character after the cursor
nnoremap <Leader>p :exec "normal a".nr2char(getchar())."\e"<CR>

" Stay in visual mode when indenting
vnoremap > >gv
vnoremap < <gv


" Plugins 

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
call plug#end()
