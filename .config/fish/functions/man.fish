if test (uname) = "Darwin"; and type -q gman
    function man --wraps gman
        gman $argv
    end
end
