let mapleader='`'

" ViM
set nocompatible

" Enable mouse
set mouse=a
  
" Use dl to duplicate a line
noremap dl Yp

" Use system clipboard (requires gVim)
set clipboard^=unnamed,unnamedplus

" Map Ctrl + Shift + C to yank
map <C-S-c> y

" Map r to redo
map r <C-r>

" Add relative line numbers, cursor shows current line
set relativenumber
set number

" Set syntax highlighting
syntax on
colors delek

" ViM autocompletion
set wildmode=longest,list,full

" Spell checker at <F6>
map <F6> :setlocal spell! spelllang=en_gb<CR>

" Open using o + leader 
map <leader>o :e
map <leader>n :enew<CR>

" Move on visual lines instead of actual lines
noremap <Up> gk
noremap <Down> gj

" Cursor line
" set cursorline

" Set tabs to 4 spaces
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=0
set tabstop=8

" Set auto indentations
set autoindent
set cindent

" Set comments for file 
autocmd FileType c,cpp,java,scala 		let b:comment_leader = '// '
autocmd FileType sh,ruby,python,conf,fstab    	let b:comment_leader = '# '
autocmd FileType vim              		let b:comment_leader = '" '

" Set Compilers
autocmd FileType        c       let compiler='gcc -o' 
autocmd FileType        cpp     let compiler='g++ -o' 

autocmd FileType        python  let compiler='python'
autocmd FileType        sh      let compiler='bash'

" Compile and run files
autocmd FileType        c,cpp   map cm :! <c-r>=compiler<CR>  "%:r" "%:p"<CR>
autocmd FileType        c,cpp   map cr cm :!./"%:r"<CR>

autocmd FileType        python,sh  map cr :! <c-r>=compiler<CR> "%:p"<CR>

map m   :!make<CR>
map mc  :!make clean<CR>

" Set the shortucts for the commenting and uncommenting 
noremap <silent> cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>l
noremap <silent> cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>l

" Split the window using the arrow keys 
nnoremap <leader><Up> :split<CR>
nnoremap <leader><Down> :split<CR>
nnoremap <leader><Right> :vsplit<CR>
nnoremap <leader><Left> :vsplit<CR>

" Set the default splits to right and below
set splitbelow
set splitright

" Move between the windows using CTRL + arrow keys
map <A-Up> <C-W><Up>
map <A-Down> <C-W><Down>
map <A-Left> <C-W><Left>
map <A-Right> <C-W><Right>

" Autocomplete to ctrl space
inoremap <C-@> <C-p>

" Set filetype
map <leader>f :set ft=

" Bracket auto open
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O


" https://vim.fandom.com/wiki/Making_Parenthesis_And_Brackets_Handling_Easier
" Don't type another closing character when one is already present
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
 return "\<Right>"
 else
 return a:char
 endif
endf

function CloseBracket()
 if match(getline(line('.') + 1), '\s*}') < 0
 return "\<CR>}"
 else
 return "\<Esc>j0f}a"
 endif
endf

function QuoteDelim(char)
 let line = getline('.')
 let col = col('.')
 if line[col - 2] == "\\"
 "Inserting a quoted quotation mark into the string
 return a:char
 elseif line[col - 1] == a:char
 "Escaping out of the string
 return "\<Right>"
 else
 "Starting a string
 return a:char.a:char."\<Esc>i"
 endif
endf


"""""""""""""""""""""""""""""Plugin Configs""""""""""""""""""""""""""""""

"""NERDTree"""

"Make it more minimal
let NERDTreeMinimalUI = 1

" Open NERDTree if `vim file`
autocmd VimEnter * NERDTree

" Open NERDTree if `vim`
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open NERDTree if `vim dir`
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Set the editor as the window on focus
autocmd VimEnter * wincmd p

" Close vim if only NERDTree is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endifi

" Toggle NERDTree
map <leader>t :NERDTreeToggle<CR>
""""""""""""""

"""Airline"""
let g:airline_theme = 'deus'
""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
