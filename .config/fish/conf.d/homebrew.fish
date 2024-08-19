if type -q brew
    set -x HOMEBREW_NO_ENV_HINTS 1
    set -x HOMEBREW_BUNDLE_FILE_GLOBAL "$HOME/.config/homebrew/Brewfile"
    set -x HOMEBREW_INSTALL_BADGE "☕️"
end
