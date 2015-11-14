# -*- mode: bash -*-
# vi: set ft=bash :
alias ll='ls -lG'
alias gs='git status'
alias gp='git push'
alias gc='git commit'
alias gaa='git add --all'
alias undo='git reset HEAD~1 --soft'
alias unstage='git reset HEAD'
alias showHiddenFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideHiddenFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias vtop='vtop --theme wizard'

set-upstream() {
  local branch=$(git rev-parse --abbrev-ref HEAD)
  git branch --set-upstream-to=origin/$branch $branch
}
