 set -x LESS '-F'
 set -x LESSOPEN '|lesspipe.sh %s'

 if type -q bat
     set -x LESSCOLORIZER bat
 end

 set -x MANROFFOPT '-c'

 if type -q bat
     set -x MANPAGER 'sh -c \'col -bx | bat -l man -p\''
 end
