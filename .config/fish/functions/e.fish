if type -q npx
    function e
        npx @electron/build-tools $argv
    end
end
