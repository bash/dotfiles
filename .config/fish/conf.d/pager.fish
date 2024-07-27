set --export LESS '-F'
set --export LESSOPEN '|lesspipe.sh %s'
set --export LESSCOLORIZER bat

set --export MANROFFOPT '-c'
set --export MANPAGER 'sh -c \'col -bx | bat -l man -p\''
