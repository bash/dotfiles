filetype off
set number
set hlsearch

syntax on
colorscheme oxeded

hi clear CursorLine
augroup CLClear
    autocmd! ColorScheme * hi clear CursorLine
augroup END

set background=dark
set cursorline

set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start

