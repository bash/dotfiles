function undo
  git reset HEAD~1 --soft $argv
end
