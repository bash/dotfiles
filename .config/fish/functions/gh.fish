set --export GITHUB_TOKEN "op://Development/GitHub-CLI-Token/token"

function gh
    op run -- gh $argv
end
