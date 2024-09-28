if type -q just
    function j --wraps just
        just $argv
    end
end
