""""""""""""""""----
""General
highlight Comment term=bold ctermfg=6 guifg=Cyan
highlight Special term=bold ctermfg=6 guifg=Cyan

"Plugins de filetype"
filetype plugin on
filetype indent on
""""""""""""""""----

""""""""""""""""----
"" Interfaz
"Color, sintaxis y demás"
colorscheme delek
syntax on

"No dejes de mostrarme dónde ando, sapo"
set ruler

"Qué coño hace esto????"
set nu

"Que se resalte el paréntesis hermano"
set showmatch

"Barra"
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [POS=%04v]\ [%p%%]\ [TYPE=%Y]
set laststatus=2

"Columnas y Filas"
set cursorline
highlight CursorLine term=underline cterm=underline guibg=Grey90    
set cursorcolumn
highlight CursorColumn term=reverse cterm=underline guibg=Grey90

"Autocompletar comillas (simples y dobles) y paréntesis"
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap ()     ()

inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     []

inoremap "      ""<Left>
inoremap "<CR>  "<CR>"<Esc>O
inoremap ""     "
inoremap ""     ""

inoremap '      ''<Left>
inoremap '<CR>  '<CR>'<Esc>O
inoremap ''     '
inoremap ''     ''

""""""""""""""""----

""""""""""""""""----
""Shortcuts
"Tabs"
map <S-t>  :tabnew <CR>
map <S-n>  :tabnext <CR>
map <S-p>  :tabprevious <CR>
map <S-w>  :tabclose <CR>

"Tagbar"
nmap <F8> :TagbarToggle<CR> 
""""""""""""""""----


" Pathogen
execute pathogen#infect()



""""""""""""""""----
"""Searching
"Resaltar resultados de búsqueda"
set hlsearch            

"Hace que search sea más moderno"
set incsearch         

"No importa si es mayúscula o minúscula..."
set ignorecase         

"... Aunque tampoco se puede ser bruto con eso"
set smartcase        

"Apagar highlight de una apenas se entre en InsMode"
autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch

"Enter activa y desactiva el highlight"
let g:highlighting = 0
function! Highlighting()
  if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
  endif
  let @/ = '\<'.expand('<cword>').'\>'
  let g:highlighting = 1
  return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> <CR> Highlighting()

""""""""""""""""----

""""""""""""""""----
""" Reglas
set showmode

"Hacer indent automático"
set smartindent 

"Realmente no sé que hace esto GGG"
set backspace=eol,start,indent
""""""""""""""""----

""""""""""""""""----
""" Archivos y backups
"No guardar un backup ni un archivo swap"
set nobackup
set noswapfile
""""""""""""""""----


""""""""""""""""----
""" Texto
"Romper la línea en 72 carácteres"
set lbr
set tw=72

"Hacer wraping de texto"
set wrap

"Tabular se vuelve dos espacios"
set expandtab

"Auto indent y Smart indent"
set ai
set si

"Muy relacionadas, tabular se vuelve 4 espacios"
set tabstop=4
set shiftwidth=4
""""""""""""""""----

""""""""""""""""----
""""""ESPECÍFICO DE CADA LENGUAJE!
""Vala
au BufRead,BufNewFile *.vala,*.vapi setfiletype vala
autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
"Highlight space errors
let vala_space_errors = 1
"Disable space-tab-space errors
let vala_no_tab_space_error = 1
