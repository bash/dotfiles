if type -q lazygit
    function lg --wraps lazygit
        lazygit $argv
    end
end
