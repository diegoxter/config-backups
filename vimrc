set nocompatible
:set spell
:set spelllang=es,en
:set spellsuggest=5
:set spellfile=~/.vim/dict.add
colorscheme default
syntax on
set noerrorbells
set visualbell t_vb=
if has("autocmd")
    autocmd GUIEnter * set visualbell t_vb=
endif

set noswapfile

" searching
set hlsearch            
set incsearch          
set ignorecase         
set smartcase           
set textwidth=80
" set expandtab
set tabstop=8
set softtabstop=4
set autoindent

" number of space to use for auto indent
" you can use >> or << keys to indent current line or selection
" in normal mode.
set shiftwidth=4

"Columnas y Filas
:set cursorline
:highlight CursorLine term=underline cterm=underline guibg=Grey90    
:set cursorcolumn
:highlight CursorColumn term=reverse cterm=underline guibg=Grey90

"Lineas 
":set number
":set numberwidth=3

"FileType
autocmd FileType python set nospell
autocmd FileType ruby set nospell
autocmd FileType python set omnifunc=pythoncomplete
autocmd FileType sh set nospell
autocmd FileType cfg set nospell
autocmd FileType conf set nospell
autocmd FileType hog set nospell

map  <silent> <F7>    <Esc>:cp<CR>
map  <silent> <F8>    <Esc>:cn<CR>

"Barra
:set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [POS=%04l,%04v]\ [%p%%]\ [TYPE=%Y]
:set laststatus=2

"Vala stuff
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala
" Disable valadoc syntax highlight
"let vala_ignore_valadoc = 1

" Enable comment strings
let vala_comment_strings = 1

" Highlight space errors
let vala_space_errors = 1
" Disable trailing space errors
"let vala_no_trail_space_error = 1
" Disable space-tab-space errors
let vala_no_tab_space_error = 1

" Minimum lines used for comment syncing (default 50)
"let vala_minlines = 120

set mouse=a
set complete+=k 
set clipboard+=unnamed
filetype on
filetype plugin on
filetype indent on
        let g:pydiction_location = '~/.vim/complete-dict'
            let g:pydiction_menu_height = 20
