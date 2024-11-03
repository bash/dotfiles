if type -q dircolors
    eval (dircolors --csh "$(dirname (status --current-filename))/LS_COLORS")
end
