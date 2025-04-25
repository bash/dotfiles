set -l aliases_path "$HOME/.local/share/flatpak-aliases"
if test -d "$aliases_path"
    fish_add_path --path "$aliases_path"
end
