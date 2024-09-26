if type -q cargo && type -q cargo-mommy
    function cargo
        if not set -q NO_CARGO_MOMMY
            switch $argv[1]
                case '+*'
                    command cargo "$argv[1]" mommy $argv[2..(count $argv)]
                case '*'
                    command cargo mommy $argv
            end
        else
            command cargo $argv
        end
    end
end
