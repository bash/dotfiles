# Aliases
source ~/.bash_aliases

# Hub
eval "$(hub alias -s)"

# Git Autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

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
export PS1="\[$(tput setaf 2)\][\[$(tput setaf 7)\]tl;dr \W\[$(tput setaf 6)\]\[$(tput setaf 2)\]] \[$(tput sgr0)\]"

PATH="~/Homebox/bin:~/Projects/Ganked/GankedUtilities/bin:${PATH}"
export PATH
