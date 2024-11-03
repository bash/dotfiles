if test (uname) = "Darwin"; and type -q gls
    function ls --wraps gls
        gls --color=auto $argv
    end
end
