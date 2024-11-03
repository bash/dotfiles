if test (uname) = "Darwin"; and type -q gdircolors
    function dircolors --wraps gdircolors
        gdircolors $argv
    end
end
