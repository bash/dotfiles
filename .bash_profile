. ~/.bash_aliases

export MAKEFLAGS='-j8'
export LANG=en_US.UTF-8
export TERM=xterm-256color

if [ "${IDE}" = "PHPSTORM" ]; then
  export PS1="$(tput setaf 4){$(tput sgr0) \W $(tput bold)\$$(tput sgr0) $(tput setaf 4)}$(tput sgr0) "
else
  export PS1="\[$(tput setaf 4)\]{\[$(tput sgr0)\] 🌹  \W \[$(tput bold)\]\$\[$(tput sgr0)\] \[$(tput setaf 4)\]}\[$(tput sgr0)\] "
fi

eval "$(hub alias -s)"

. /usr/local/etc/bash_completion.d/open

# Git autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Hub autocomplete
if [ -f ~/.hub-completion.bash ]; then
  . ~/.hub-completion.bash
fi

complete -o default -W "\`test -e Makefile && grep -oE '^[a-zA-Z0-9_-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_-]*$//'\`" make
