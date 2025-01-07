if status is-interactive
    # Cargo uses detection based on TERM
    # and only emits OSC 8 hyperlinks if it deems
    # the terminal compatible. Ghostty is not on that list.
    set -x FORCE_HYPERLINK 1
end
