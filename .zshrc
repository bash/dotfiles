setopt PROMPT_SUBST
source $HOME/.zshrc.d/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWUPSTREAM=true
export PS1='
%1~$(__git_ps1)
$ '

autoload -Uz compinit && compinit

# Press CTRL-v to edit command line in vi
autoload edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

# Configure History
source "$HOME/.zshrc.d/zsh-history-substring-search.zsh"

if [[ -n "$WSLENV" ]]; then
    bindkey '^[OA' history-substring-search-up
    bindkey '^[OB' history-substring-search-down
else
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=127'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=55'

setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time
setopt HIST_VERIFY # show command with history expansion to user before running it
setopt SHARE_HISTORY # share command history data
setopt hist_ignore_space # ignore commands that start with a space

HISTSIZE=50000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt autocd

export EDITOR='vim'
export LESS=-r
export PATH="$PATH:$HOME/.local/bin"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export SuppressNETCoreSdkPreviewMessage=true
export ASPNETCORE_ENVIRONMENT=Development

# SQLite does not yet support loading from XDG_CONFIG_HOME in 3.40.1
alias sqlite3="$(which sqlite3) --init ${XDG_CONFIG_HOME=$HOME/.config}/sqlite3/sqliterc"

if [[ -n "$WSLENV" ]]; then
    alias subl='/mnt/c/Program\ Files/Sublime\ Text/subl.exe'
fi

if [[ -d "$HOME/.dotnet/tools" ]]; then
    export PATH="$PATH:$HOME/.dotnet/tools"
fi

if [[ -f "$HOME/.ghcup/env" ]]; then
    source "$HOME/.ghcup/env"
fi

export CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
fi

if [[ -d "$HOME/.local/share/JetBrains/Toolbox/scripts" ]]; then
    export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"
fi

alias ll='eza --long --group --git --hyperlink --binary'

if ! command -v open &> /dev/null && command -v xdg-open &> /dev/null; then
    alias open=xdg-open
fi

if command -v wget2 &> /dev/null; then
    alias wget=wget2
fi

test -f ~/.zshrc.local && source ~/.zshrc.local

source "$HOME/.zshrc.d/dotnet-autocomplete.zsh"
