function sqlite3
    if not set -q XDG_CONFIG_HOME
        set XDG_CONFIG_HOME $HOME/.config
    end
    command sqlite3 --init "$XDG_CONFIG_HOME/sqlite3/sqliterc" $argv
end
