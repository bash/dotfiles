# Aliases
source ~/.bash_aliases

# https://github.com/jimeh/git-aware-prompt 
export GITAWAREPROMPT=~/Github/bash/dotfiles/lib/git-aware-prompt
source $GITAWAREPROMPT/main.sh

editor(){
  eval $EDITOR $1 
}

merge_into() {
  # Backup current branch
  branch_name=$(git symbolic-ref -q HEAD)
  branch_name=${branch_name##refs/heads/}
  branch_name=${branch_name:-HEAD}

  git checkout $1
  git pull && git merge --no-ff $branch_name
  git checkout $branch_name
}

push_commit() {
  git status
  echo 'Waiting 3 seconds...'
  sleep 3
  git pull
  git commit -m "$1"
  git push
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
