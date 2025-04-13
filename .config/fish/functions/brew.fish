if type -q brew
    function brew
        sudo -iu homebrew-user brew $argv
    end
end
