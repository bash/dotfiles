if test (uname) = Darwin; and type -q gmake
    function make --wraps gmake
        gmake "$MAKE_FLAGS" $argv
    end
else if type -q make
    function make
        command make "$MAKE_FLAGS" $argv
    end
end
