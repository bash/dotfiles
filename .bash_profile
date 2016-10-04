export MAKEFLAGS='-j8'
export LANG=en_US.UTF-8
export TERM=xterm-256color
export PATH="/usr/local/opt/php70/bin:${PATH}:~/.bin"
export EDITOR='vim'
export GPG_TTY=`tty`
export DEP_OPENSSL_INCLUDE=/usr/local/opt/openssl/include
export PS1="[\u@\h \W]$ "
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"

. ~/.bash_aliases
. resty
. ~/.git-completion.bash
. ~/.hub-completion.bash
. ~/.cargo/env
. /usr/local/etc/bash_completion.d/coop-completion.bash 

complete -o default -W "\`test -e Makefile && grep -oE '^[a-zA-Z0-9_-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_-]*$//'\`" make
