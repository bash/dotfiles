if not set -q XDG_STATE_HOME
    set XDG_STATE_HOME $HOME/.local/state
end

set -x SQLITE_HISTORY $XDG_STATE_HOME/sqlite/history
if not test -d $XDG_STATE_HOME/sqlite
    mkdir -p $XDG_STATE_HOME/sqlite
end
