function prompt_login --description "display user name for the prompt"
    # If we're running inside toolbox or distrobox, show icon.
    if set -q CONTAINER_ID
        echo -n -s (set_color 613583) "⬢ " (set_color normal)
    end

    # If we're running via SSH, change the host color.
    set -l color_host $fish_color_host
    if set -q SSH_TTY; and set -q fish_color_host_remote
        set color_host $fish_color_host_remote
    end

    echo -n -s (set_color $fish_color_user) "$USER" (set_color normal) @ (set_color $color_host) (prompt_hostname) (set_color normal)
end
