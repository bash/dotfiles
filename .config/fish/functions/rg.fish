if type -q rg; and type -q delta
    function rg
        command rg --json $argv | delta
    end
end
