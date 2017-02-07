# -*- mode: bash -*-
alias git=hub
alias ll='ls -lAG'
alias vim='/usr/local/opt/vim/bin/vim'
alias vi='vim'
alias showhiddenfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidehiddenfiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias cleandocker='docker rm `docker ps -f status=exited --format {{.ID}}`'
alias perf='curl -s -w "\n%{time_connect} + %{time_starttransfer} = %{time_total}\n"'
