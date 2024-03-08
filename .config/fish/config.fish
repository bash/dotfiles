set -g fish_greeting

if status is-interactive
    # Set cursor style
    printf '\e[3 q'
end
