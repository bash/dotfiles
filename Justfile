set windows-shell := ["powershell.exe", "-c"]

default:
    just --list

# Installs dotfiles to $HOME
[unix]
install:
    ./install

# Installs dotfiles to $HOME
[windows]
[working-directory("windows")]
install:
    .\install.cmd

# Uninstalls unused Homebrew formulas
brew-cleanup *args:
	brew bundle cleanup --global --verbose {{args}}

# Installs dependencies from Homebrew
brew-install:
	brew bundle install --global --verbose

# Sets custom folder icons (requires MoreWaita)
set-custom-folder-icons:
	gio set ~/Source metadata::custom-icon-name 'folder-git'
	gio set ~/Audiobooks metadata::custom-icon-name 'folder-books'
