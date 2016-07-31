filetype off
set number

syntax on
colorscheme oxeded

hi clear CursorLine
augroup CLClear
    autocmd! ColorScheme * hi clear CursorLine
augroup END

set background=dark
set cursorline

set tabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
