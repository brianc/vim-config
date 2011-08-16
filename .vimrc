set nocompatible " must be first line
filetype plugin on
filetype indent on

let s:is_win = has('win32')
let s:is_mac = has('mac')

runtime! autoload/pathogen.vim
silent! call pathogen#helptags()
silent! call pathogen#runtime_append_all_bundles()



let mapleader = ","
let g:mapleader = ","
set visualbell

set history=700
set ruler "Always show current position
set hid "Change buffer - without saving
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

set ignorecase "Ignore case when searching
set smartcase

set scrolljump=5 				" lines to scroll when cursor leaves screen
set scrolloff=3 				" minimum lines to keep above and below cursor
set foldenable  				" auto fold code
set gdefault					" the /g flag on :s substitutions by default

" No sound on errors
set noerrorbells
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

if has("gui_running")
  set guioptions-=T
  " set guioptions-=m
  set t_Co=256
  set background=dark
  set nonu
  colorscheme desert
  if has('win32')
    set guifont=Consolas:h13
  elseif s:is_mac
    set guifont=Menlo:h15
    set lines=999
    set columns=999
  elseif has('unix')
    set guifont=Inconsolata\ 17
    set novisualbell
  end
else
  colorscheme zellner
  set background=dark

  set nonu
endif

set encoding=utf8
try
  lang en_US
catch
endtry

" set ffs=unix,dos,mac "Default file types

""""""""""""""""""""""""""""""""
"  Text, tab and indent
"  """"""''''''
set expandtab
set shiftwidth=2
set tabstop=2
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Specify the behavior when switching between buffers
try
  set switchbuf=usetab
  set stal=2
catch
endtry

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
  let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
  return curdir
endfunction

" FileTypes {
  au BufNewFile,BufRead *.aspx.cs set ft=html
  au BufNewFile,BufRead *.aspx set ft=html
" }

" KeyMap {
  imap <c-a> <esc>0i
  imap <c-f> <right>
  imap kj <esc>
  imap <C-BS> <C-W>
  imap ( ()<esc>i
  imap [ []<esc>i
  imap { {}<esc>i

  " Map space to / (search) and c-space to ? (backwards search)
  map <space> /
  map <c-space> ?
  map <silent> <leader><cr> :noh<cr>

  " smart way to move between windows
  map <C-j> <C-W>j
  map <C-k> <C-W>k
  map <C-h> <C-W>h
  map <C-l> <C-W>l

  " Use the arrows to something useful
  map <right> :tabnext<cr>
  map <left> :tabprevious<cr>

  " Tab configuration
  map <leader>tn :tabnew<cr>
  map <leader>te :tabedit<cr>
  map <leader>tc :tabclose<cr>
  map <leader>tm :tabmove<cr>

  " When pressing <leader>cd switch to the directory of the open buffer
  map <leader>cd :cd %:p:h<cr>
" }

" Plugins {
  " Lusty {
    nmap <leader>b :LustyBufferExplorer<cr>
    nmap <leader>j :LustyJuggler<cr>
    nmap <leader>f :LustyFilesystemExplorer<cr>
    nmap <leader>F :LustyFilesystemExplorerFromHere<cr>
  " }
" }
