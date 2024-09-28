if type -q eza
    function ll --wraps eza
        eza --long --group --hyperlink --binary $argv
    end
end
