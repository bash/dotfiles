if status is-interactive
    fish_add_path --prepend --path "$HOME/.local/bin"
    set --export EDITOR nvim
    set --export PKG_CONFIG_PATH "/usr/local/lib64/pkgconfig:$PKG_CONFIG_PATH"
    set --export LD_LIBRARY_PATH "/usr/local/lib64:$LD_LIBRARY_PATH"
end
