if test (uname) = "Darwin"; and type -q gmake
    function make --wraps gmake
        gmake $argv
    end
end
