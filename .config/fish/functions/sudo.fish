if type -q run0
    function sudo --wraps run0
        run0 $argv
    end
end
