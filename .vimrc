" pahtogen init
source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

syntax on
filetype plugin indent on

if has('mac')
  set guifont=Menlo\ Regular:h16
endif
