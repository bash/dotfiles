if status is-interactive
    set --export LESS '-F'
    set --export LESSOPEN '|lesspipe.sh %s'

    if type -q bat
        set --export LESSCOLORIZER bat
    end

    set --export MANROFFOPT '-c'

    if type -q bat
        set --export MANPAGER 'sh -c \'col -bx | bat -l man -p\''
    end
end
