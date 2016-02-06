. ~/.bash_aliases
. ~/.bash_functions

if [ -f ~/.profile ]; then
  . ~/.profile
fi

# Docker
eval "$(docker-machine env default)"

# Hub
eval "$(hub alias -s)"

# TheFuck
eval $(thefuck --alias)

# Git autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

if [ -f ~/.npm-completion.bash ]; then
  . ~/.npm-completion.bash
fi

# Hub autocomplete
if [ -f ~/.hub-completion.bash ]; then
  . ~/.hub-completion.bash
fi

# Make autocomplete (https://gist.github.com/tlrobinson/1073865)
complete -o default -W "\`test -e Makefile && grep -oE '^[a-zA-Z0-9_-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_-]*$//'\`" make

# [tl;dr ~]
# Custom bash prompt via kirsle.net/wizards/ps1.html
export PS1="\[$(tput setaf 2)\][\[$(tput setaf 7)\]tl;dr \W\[$(tput setaf 6)\]\[$(tput setaf 2)\]] \[$(tput sgr0)\]"

export PATH="~/Homebox/bin:~/Projects/Ganked/GankedUtilities/bin:${PATH}:node_modules/.bin"

export NVM_DIR="/Users/ruby/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
