set -x PAGER 'less'
set -x LESS '-FR'
set -x LESSOPEN '|lesspipe.sh %s'

if type -q bat
    set -x LESSCOLORIZER bat
end

