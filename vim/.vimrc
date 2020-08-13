" -----------------------------------------------------------------------------
" > Basic settings
" -----------------------------------------------------------------------------

set encoding=utf-8      " Use UTF-8
set hidden

set number              " Display numbering on the left
set relativenumber      " Numbering is relative to current line

" Status bar settings
set laststatus=2        " Always display a status bar
set ruler               " Display current cursor position in status bar
set showmode            " Display current mode in status bar
set showcmd             " Display an incomplete command in status bar
set shortmess+=r        " Use shorter message for [readonly] in status bar

" Search and history
set incsearch           " Display the match of a search pattern while typing it
set hlsearch            " Highlight matches of the last used search pattern
set history=100         " Keep 50 commands and search patterns in the history
set ignorecase          " Ignore case on searches
set smartcase           " Don't ignore case if search includs an uppercase

" Window actions
set splitright          " Split vertically to the right
set splitbelow          " Split horizontally to the bottom

" Cursor settings
set scrolloff=2         " Number of lines to keep above and below the cursor
set nostartofline       " On movement, keep cursor in same column if possible

" Text options
set nowrap              " Disable wrapping of lines
set nojoinspaces        " Only use one space after . ! and ?

" Security and encryption
set nomodeline          " Disable mode line for security reasons
set cm=blowfish2        " Strong encryption (7.4.3+)

" Display unprintable characters (whitespace), npbsp:  
set list listchars=tab:»·,trail:·,precedes:·,nbsp:⌴

" Set cursor style depending on mode
if &term =~ '^xterm'
    let &t_SI .= "\<Esc>[4 q"
    let &t_EI .= "\<Esc>[2 q"
endif


" -----------------------------------------------------------------------------
" > Indentation
" -----------------------------------------------------------------------------

" This is the default for all our files: use 4 spaces over tabs.
set expandtab           " Always expands tabs into spaces
set tabstop=8           " A tab is _always_ worth 8 spaces
set shiftwidth=4        " For <<, >>, and ==. And for autoindent
set softtabstop=4       " Insert this many spaces instead of a tab
set autoindent          " Use the indent of the previous line on the new line
set backspace=2         " Allow backspacing over indent, eol, and start

syntax enable           " Use syntax highlighting
filetype indent on      " Use filetype-specific indentation
filetype plugin on      " Use filetype-specific plugins

" File specific settings go here:
" autocmd FileType python setlocal shiftwidth=4 softtabstop=4


" -----------------------------------------------------------------------------
" > Custom key bindings
" -----------------------------------------------------------------------------

let mapleader = ","

" Toggle options
nnoremap cos :setlocal spell!<CR>
nnoremap cop :setlocal paste!<CR>
nnoremap col :setlocal list!<CR>
nnoremap cow :setlocal wrap!<CR>
nnoremap coi :setlocal ignorecase!<CR>
nnoremap con :set number!<CR>
nnoremap cor :set relativenumber!<CR>
nnoremap coe :set cursorline!<CR>
nnoremap coc :set cursorcolumn!<CR>
nnoremap coh :noh<CR>
nnoremap cod :<C-R>=&diff ? "diffoff" : "diffthis"<CR><CR>
nnoremap cov :set <C-R>=(&virtualedit =~# "all") ? "virtualedit-=all" : "virtualedit+=all"<CR><CR>
nnoremap cob :set background=<C-R>=&background == "dark" ? "light" : "dark"<CR><CR>
nnoremap com <ESC>:exec &mouse!=""? "set mouse=" : "set mouse=a"<CR>

" Buffer commands
noremap gb :buffer<Space>
noremap gB :ls<CR>:buffer<Space>
noremap BB :b#<CR>
nnoremap BD :bd<CR>
nnoremap <C-J> :bnext<CR>
nnoremap <C-K> :bprev<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>

" Stay in visual mode when indenting
vnoremap > >gv
vnoremap < <gv

"Line operations
nnoremap <silent> dJ :+1d<CR>k
nnoremap <silent> dK :-1d<CR>
nnoremap <silent> ]<Space> :pu! _<CR>:']+1<CR>
nnoremap <silent> [<Space> :pu _<CR>:'[-1<CR>

" Folding
nnoremap \" :setlocal foldexpr=getline(v:lnum)=~'^\"\ >'?'>1':1 foldmethod=expr<CR>
nnoremap \# :setlocal foldexpr=getline(v:lnum)=~'^#\ >'?'>1':1 foldmethod=expr<CR>
nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum)=~@/)\\|\\|(getline(v:lnum)=~@/)?0:1 foldmethod=expr foldlevel=0 foldcolumn=2<CR>

" Misc
nmap , ;
nnoremap Y y$<CR>
nnoremap WW :w<CR>
nnoremap dL :%s/\s\+$//e<CR>
nnoremap <Leader>c :let @/ = ""<CR>

" Plugin shortcuts
nnoremap <silent> gG :Git<CR>
nnoremap <silent> gE :NERDTreeToggle<CR>

" .vimrc editing and reloading
nnoremap <leader>ve :e $MYVIMRC<CR>
nnoremap <leader>vv :source $MYVIMRC<CR>


" -----------------------------------------------------------------------------
" > Functions
" -----------------------------------------------------------------------------

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()

nnoremap <silent> <Leader>z :ZoomToggle<CR>


" -----------------------------------------------------------------------------
" > Plugin definition and configurations
" -----------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
" Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'majutsushi/tagbar'
Plug 'preservim/nerdtree'
Plug 'kshenoy/vim-signature'
if has('python3')
    Plug 'SirVer/ultisnips'
end

" Color schemes
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'jacoborus/tender.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
call plug#end()


" -----------------------------------------------------------------------------
" Colors
" ------

" See xterm-true-color
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
set termguicolors

" Choose theme
set background=light
colorscheme onehalflight
let g:airline_theme='onehalflight'

set colorcolumn=80


" -----------------------------------------------------------------------------
" UltiSnips
" -----------------

let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsJumpBackwardTrigger = '<c-p>'
let g:UltiSnipsJumpForwardTrigger  = '<c-n>'
let g:UltiSnipsSnippetDirectories=['custom_snippets', 'UltiSnips']


" -----------------------------------------------------------------------------
" ALE customization
" -----------------

let g:ale_sign_column_always = 1

let g:ale_linters = {
\   'python': ['flake8', 'pyls']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['yapf', 'isort'],
\}

" Completion
let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc

" Custom symbols
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"
highlight ALEErrorSign ctermfg=9
highlight ALEWarningSign ctermfg=11
highlight clear SignColumn

" ALE key bindings
nnoremap coa :ALEToggle<CR>
nnoremap <silent> <Leader>d <Plug>(ale_go_to_definition)
nnoremap <silent> <Leader>k <Plug>(ale_documentation)
nnoremap <silent> <Leader>n <Plug>(ale_next)
nnoremap <silent> <Leader>p <Plug>(ale_previous)
nnoremap <silent> <Leader>f <Plug>(ale_fix)
nnoremap <silent> <Leader>r <Plug>(ale_find_references)


" -----------------------------------------------------------------------------
" vim-easy-align
" --------------

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" -----------------------------------------------------------------------------
" fzf (https://github.com/junegunn/fzf.vim)
" -----------------------------------------

nmap <C-F> <Nop>
nnoremap <c-f>b :Buffers<CR>
nnoremap <c-f>c :Colors<CR>
nnoremap <c-f>g :GFiles<CR>
nnoremap <c-f>t :BTags<CR>
nnoremap <c-f>h :Helptags<CR>
nnoremap <c-f>l :Lines<CR>
nnoremap <c-f>f :Files<CR>
nnoremap <c-f>m :Maps<CR>
nnoremap <c-f>s :Snippets<CR>
nnoremap <c-f>y :History<CR>


" -----------------------------------------------------------------------------
" Tagbar
" ------
"
nnoremap <silent> <Leader>t :TagbarToggle<CR>

let g:tagbar_type_python = {
    \ 'kinds' : [
        \ 'h:headers',
        \ 'i:imports:1:0',
        \ 'c:classes',
        \ 'f:functions',
        \ 'm:members',
        \ 'v:variables:0:0',
        \ '?:unknown',
    \ ],
\ }

let g:tagbar_type_make = {
    \ 'kinds':[
        \ 'h:headers',
        \ 'm:macros',
        \ 't:targets',
    \ ],
    \ 'sort': 0
\}

let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:headers',
        \ 'i:subheaders',
        \ 'k:sub-subheaders'
    \ ]
\ }


" -----------------------------------------------------------------------------
" Airline
" -------

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1


" -----------------------------------------------------------------------------
" Set auto commands
" -----------------------------------------------------------------------------

augroup spellChecking
    autocmd!
    autocmd FileType markdown setlocal spell
    autocmd FileType tex setlocal spell
augroup END


" -----------------------------------------------------------------------------
" Load local settings
" -----------------------------------------------------------------------------

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
