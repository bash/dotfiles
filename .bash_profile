# Aliases
source ~/.bash_aliases

export GITAWAREPROMPT=~/Github/bash/dotfiles/lib/git-aware-prompt
source $GITAWAREPROMPT/main.sh

editor(){
  eval $EDITOR $1 
}

# [tl;dr ~]
# Custom bash prompt via kirsle.net/wizards/ps1.html
export PS1="\[$(tput setaf 2)\][\[$(tput setaf 7)\]tl;dr \W \[$(tput setaf 6)\]\$git_branch\[$(tput setaf 2)\]] \[$(tput sgr0)\]"


# Set the default editor for GIT, ...
export EDITOR="/usr/local/bin/mate -w"

# Include .profile
source ~/.profile 

PATH="~/Homebox/bin:${PATH}"
export PATH
