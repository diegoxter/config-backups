set nocompatible
:set spell
:set spelllang=es,en
:set spellsuggest=5
:set spellfile=~/.vim/dict.add
colorscheme biogoo
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
:highlight CursorColumn term=reverse ctermbg=7 guibg=Grey90

"Lineas 
":set number
":set numberwidth=3

"FileType
autocmd FileType python set nospell
autocmd FileType python set omnifunc=pythoncomplete
autocmd FileType pythonautocmd FileType sh set nospell
autocmd FileType cfg set nospell
autocmd FileType hog set nospell

"Barra
:set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [POS=%04l,%04v]\ [%p%%]\ [TYPE=%Y]
:set laststatus=2

set mouse=a
set complete+=k 
set clipboard+=unnamed
filetype on
filetype plugin on
filetype indent on
        let g:pydiction_location = '~/.vim/complete-dict'
            let g:pydiction_menu_height = 20
