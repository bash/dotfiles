export MAKEFLAGS='-j8'
export LANG=en_US.UTF-8
export TERM=xterm-256color
export PATH="${PATH}:~/.bin"
export EDITOR='vim'
export GPG_TTY=`tty`
export DEP_OPENSSL_INCLUDE=/usr/local/opt/openssl/include
export PROMPT_COMMAND="type _set_prompt >/dev/null 2>&1 && _set_prompt; $PROMPT_COMMAND"
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"

if [ $TERM = 'xterm-256color' ]; then
    export PS1="\W \$_git_branch_left\[$(tput setaf 2)\]\$_git_branch\[$(tput sgr0)\]\$_git_branch_right\[$(tput setaf 8)\]#\[$(tput sgr0)\] "
fi

_set_prompt () {
  _git_branch=''; _git_branch_right=''; _git_branch_left=''

  git rev-parse --git-dir > /dev/null 2>&1 && \
    _git_branch_left='(' && \
    _git_branch_right=') ' && \
    _git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
}

. ~/.bash_profile.local

. ~/.bash_aliases
. resty
. ~/.git-completion.bash
. ~/.hub-completion.bash
. ~/.cargo/env
. /usr/local/etc/bash_completion.d/coop-completion.bash

complete -o default -W "\`test -e Makefile && grep -oE '^[a-zA-Z0-9_-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_-]*$//'\`" make

