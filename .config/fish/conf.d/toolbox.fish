set -l toolbox_path "$HOME/.local/share/JetBrains/Toolbox/scripts"
if test -d "$toolbox_path"
    fish_add_path --path "$toolbox_path"
end
