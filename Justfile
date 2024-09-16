default:
    just --list

install:
    ./install

brew-cleanup *args:
	brew bundle cleanup --global --verbose {{args}}

brew-install:
	brew bundle install --global --verbose
