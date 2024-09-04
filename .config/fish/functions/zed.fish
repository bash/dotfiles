if type -q flatpak && not type -q zed
    function zed
        flatpak run dev.zed.Zed $argv
    end
end
