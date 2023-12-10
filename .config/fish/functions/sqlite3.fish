set original_command (which sqlite3)
if not set -q XDG_CONFIG_HOME
    set XDG_CONFIG_HOME $HOME/.config
end

function sqlite3
    $original_command --init "$XDG_CONFIG_HOME/sqlite3/sqliterc" $argv
end
