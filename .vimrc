set nocompatible " must be first line

runtime! bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
syntax on
filetype plugin indent on

let s:is_win = has('win32')
let s:is_mac = has('mac')
let g:vitality_always_assume_iterm = 1
let g:jsx_ext_required = 0

noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

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

set wildmenu
set viminfo='100,f1 " save global arks upon exit
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compat
set shortmess+=filmnrxoOtT "abbrev. of messages (avioids 'hit enter')
set showmode

" go style tabs for go
" au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

" Automatically safe files when switchin between them / leaving vim
set autowriteall
autocmd FocusLost * silent! :wa
autocmd VimResized * silent! :wa
autocmd TabLeave * silent! :wa
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
    set guifont=Menlo:h16
    set lines=999
    set columns=999
  elseif has('unix')
    set guifont=Inconsolata\ 16
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

" set list
" set listchars=trail:.

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
set statusline=%f%m%r%h\ %w\ %=\ Line:\ %l/%L:%c


function! CurDir()
  let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
  return curdir
endfunction

" FileTypes {
  au BufNewFile,BufRead *.aspx.cs set ft=html
  au BufNewFile,BufRead *.aspx set ft=html
  au BufNewFile,BufRead *.coffee set ft=coffee
" }

" KeyMap {
  imap <c-a> <esc>0i
  imap <c-f> <right>
  imap <C-BS> <C-W>

  " Map space to / (search) and c-space to ? (backwards search)
  map <space> /
  map <leader>s :w<cr>
  map <silent> <leader><cr> :noh<cr>

  " Fugative mapping
  map <leader>g :Gstatus<cr>

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
  map <leader>cd :lcd %:p:h<cr>

  " visual shifting (does not exit Visual mode)
  vnoremap < <gv
  vnoremap > >gv
" }
" Fancy brackets/braces/parenthesis {
  inoremap ( ()<Esc>i
  inoremap [ []<Esc>i
  inoremap { {}<Esc>i
  autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
  inoremap ) <c-r>=ClosePair(')')<CR>
  inoremap ] <c-r>=ClosePair(']')<CR>
  inoremap } <c-r>=ClosePair('}')<CR>
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
" }
" autosave (potentially dangerous) {
  :set autowriteall
  :au FocusLost * silent! wa
" }

" Plugins {
  " python-mode {
    let g:pymode_breakpoint = 0
    let g:pymode_folding = 0
    let g:pymode_lint_write = 0
  " }
  " ctrlp {
    nmap <leader>b :CtrlPBuffer<cr>
    nmap <leader>j :CtrlPMRUFiles<cr>
    nmap <leader>f :CtrlPCurWD<cr>
    nmap <leader>F :CtrlPRoot<cr>

    if s:is_win
      set wildignore+=.git\*,.hg\*,.svn\*,.bin\*,.obj\*,node_modules\*,env\*,dist\*         " for Windows
    else
      set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*,*/jspm_packages/*,.DS_Store,*/jam/*,*/env/*,*.pyc,*/target/*,*/dist/*  " for Linux/MacOSX
    end

    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git$\|\.hg$\|\.svn$|node_modules$|target$|jspm_packages|dist',
      \ 'file': '\.exe$\|\.so$\|\.dll$|\DS_Store$',
      \ 'link': 'bad_symbolic_link',
      \ }

  " }
  " NerdTree {
    nmap <leader>t :NERDTreeToggle<cr>
  " }
  " vimux {
    " Prompt for a command to run
    map rp :PromptVimTmuxCommand<cr>
    
    " Run last command executed by RunVimTmuxCommand
    map rl :RunLastVimTmuxCommand<cr>
    
    " Inspect runner pane
    map ri :InspectVimTmuxRunner<cr>
   
    " Close all other tmux panes in current window
    map rx :CloseVimTmuxPanes<cr>
   
    " Interrupt any command running in the runner pane
    map rs :InterruptVimTmuxRunner"<cr>
  " }
" }
