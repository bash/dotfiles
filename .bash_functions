git-set-upstream() {
  local branch=$(git rev-parse --abbrev-ref HEAD)
  git branch --set-upstream-to=origin/$branch $branch
}

git-pull() {
  tput setaf 6
  echo "Pulling..."
  tput sgr0
  git pull

  tput setaf 6
  echo "Fetching tags..."
  tput sgr0
  git fetch --tags

  tput setaf 6
  echo "Updating submodules..."
  tput sgr0
  git submodule init
  git submodule update
}
