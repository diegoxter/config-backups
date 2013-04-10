filetype on
syntax on
highlight Comment term=bold ctermfg=6 guifg=Cyan
highlight Special term=bold ctermfg=6 guifg=Cyan
filetype plugin on
filetype plugin indent on

" Visual
set nu
set nowrap
set ruler
colorscheme delek
set showmatch

""Shortcuts
" Tabs
map <S-t>  :tabnew <CR>
map <S-n>  :tabnext <CR>
map <S-p>  :tabprevious <CR>
map <S-w>  :tabclose <CR>
"Tagbar
nmap <F8> :TagbarToggle<CR> 

"Barra
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [POS=%04v]\ [%p%%]\ [TYPE=%Y]
set laststatus=2

" Pathogen
execute pathogen#infect()

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

" searching
set hlsearch            
set incsearch          
set ignorecase         
set smartcase         
" Apagar highlight de una apenas se entre en IM
autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch
" Enter activa y desactiva el highlight
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

"Columnas y Filas
set cursorline
highlight CursorLine term=underline cterm=underline guibg=Grey90    
set cursorcolumn
highlight CursorColumn term=reverse cterm=underline guibg=Grey90

set showmode
set tabstop=2
set shiftwidth=2
set expandtab    
set ruler
set nowrap
set smartindent
set backspace=2
set nobackup
set noswapfile

""Vala
au BufRead,BufNewFile *.vala,*.vapi setfiletype vala
autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
"Highlight space errors
let vala_space_errors = 1
"Disable space-tab-space errors
let vala_no_tab_space_error = 1
