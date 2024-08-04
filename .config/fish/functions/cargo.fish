function cargo
    switch $argv[1]
        case '+*'
            command cargo "$argv[1]" mommy $argv[2..(count $argv)]
        case '*'
            command cargo mommy $argv
    end
end
