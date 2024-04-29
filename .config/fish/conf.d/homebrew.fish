if test "$(uname)" = "Darwin"
    set --export HOMEBREW_NO_ENV_HINTS 1
    set --export HOMEBREW_BUNDLE_FILE_GLOBAL "$HOME/.config/homebrew/Brewfile"
    set --export HOMEBREW_INSTALL_BADGE "☕️"
end
