if type -q lazygit
    function lazygit
         command lazygit --use-config-file="$(__lazygit_config_file)" $argv
    end

    function __lazygit_config_file
        set -l config_home "$(set -q XDG_CONFIG_HOME && echo "$XDG_CONFIG_HOME" || echo "$HOME/.config")"
        echo "$config_home/lazygit/config.base.yml,$config_home/lazygit/config.$(__lazygit_theme).yml"
    end

    function __lazygit_theme
        status is-interactive \
            && type -q termtheme \
            && termtheme --force -n 2>/dev/null \
            || echo dark
    end
end
