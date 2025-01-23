if type -q rg; and type -q delta
    function rg
        if test "$argv[1]" = "--help"
            command rg $argv
        else
            command rg --json $argv | delta
        end
    end
end
