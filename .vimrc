" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" don't allow backspacing over everything in insert mode
set backspace=

set nobackup
set nowritebackup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number
set cursorline

colorscheme jellybeans
"colorscheme hickop

" Don't use Ex mode, use Q for formatting
map Q gq

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v]\ [%p%%]\ [LEN=%L]

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set nohlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

"setlocal spell spelllang=en

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
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_ViewRule_pdf = 'evince'
