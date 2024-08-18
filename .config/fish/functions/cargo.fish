if type -q cargo && type -q cargo-mommy
    function cargo
        set -x CARGO_MOMMYS_LITTLE 'pet/baby/toy'
        set -x CARGO_MOMMYS_PRONOUNS 'their'
        set -x CARGO_MOMMYS_ROLES 'daddy'
        set -x CARGO_MOMMYS_MOODS 'chill/ominous/thirsty/yikes'
        set -x CARGO_MOMMYS_PARTS 'sugar/milk'

        switch $argv[1]
            case '+*'
                command cargo "$argv[1]" mommy $argv[2..(count $argv)]
            case '*'
                command cargo mommy $argv
        end
    end
end
