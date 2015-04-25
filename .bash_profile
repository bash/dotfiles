# Aliases
source .bash_aliases

# [tl;dr ~]
export PS1="\[$(tput setaf 2)\][\[$(tput setaf 7)\]tl;dr \W\[$(tput setaf 2)\]] \[$(tput sgr0)\]"

# Set the default editor for GIT, ...
export EDITOR="/usr/local/bin/mate -w"

# Include .profile
source ~/.profile 

PATH="~/Homebox/bin:${PATH}"
export PATH
