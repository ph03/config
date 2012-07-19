colorscheme jellybeans
"colorscheme hickop

set number

set cursorline

set incsearch

"setlocal spell spelllang=en

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]

map <silent> <C-F2> :if &guioptions =~# 'T' <Bar>
			\set guioptions-=T  <Bar>
			\set guioptions-=m  <bar>
		    \else <Bar>
			\set guioptions+=T  <Bar>
			\set guioptions+=m  <Bar>
		    \endif<CR>

map <C-Left>  <Esc>:tabprev<CR>
map <C-Right> <Esc>:tabnext<CR>
map <C-n>     <Esc>:tabnew
map <A-Left>  <ESC>:bn<CR>
map <A-Right> <ESC>:bp<CR>

so $VIMRUNTIME/mswin.vim

"evince synctex
nmap <F4> :call EVS_Sync()<CR>

"help for name under cursor
map <F1> <ESC>:exec "help ".expand("<cWORD>")<CR>

set backupdir=./.backup,.,/tmp
set directory=.,./.backup,/tmp

"vim-latex
filetype plugin on
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_ViewRule_pdf = 'evince'
