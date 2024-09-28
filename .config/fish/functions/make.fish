if test (uname) = "Darwin"
    if type -q gmake
        function make
            gmake $argv
        end
    end
end
