set nocompatible
:set spell
:set spelllang=es,en
:set spellsuggest=5
:set spellfile=~/.vim/dict.add
colorscheme biogoo
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

"Columnas y Filas
:set cursorline
:highlight CursorLine term=underline cterm=underline guibg=Grey90    
:set cursorcolumn
:highlight CursorColumn term=reverse ctermbg=7 guibg=Grey90

"Lineas 
":set number
":set numberwidth=3

"Barra
:set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [POS=%04l,%04v]\ [%p%%]\ [TYPE=%Y]
:set laststatus=2

set mouse=a
set complete+=k 
set clipboard+=unnamed
filetype plugin on
 let g:pydiction_location = '~/.vim/complete-dict'
 let g:pydiction_menu_height = 20
