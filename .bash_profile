# Aliases
source ~/.bash_aliases

# Hub
eval "$(hub alias -s)"

# Git autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Hub autocomplete
if [ -f ~/.hub-completion.bash ]; then
  . ~/.hub-completion.bash
fi

# Make autocomplete (https://gist.github.com/tlrobinson/1073865)
complete -o default -W "\`test -e Makefile && grep -oE '^[a-zA-Z0-9_-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_-]*$//'\`" make

merge_into() {
  # backup current branch
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
