## Per-device config

### ~/.gitconfig.d/local.gitconfig
```gitconfig
[user]
	signingkey = ssh-ed25519 ...
[gpg]
	format = ssh
[gpg "ssh"]
	program = "/opt/1Password/op-ssh-sign"
[includeIf "gitdir:~/Source/GitHub/"]
	path = "~/.gitconfig.d/github.gitconfig"
```

### ~/.gitconfig.d/github.gitconfig
```gitconfig
[user]
	email = "..."
```

### ~/.zshrc.local
```bash
hash -d Source=/path/to/source
// ..
```

### ~/.ssh/config
```
Host *
	IdentityAgent ~/.1password/agent.sock
```

## Fonts
* [Last Resort Font](https://github.com/unicode-org/last-resort-font)
* [JetBrains Mono](https://www.jetbrains.com/lp/mono/)

## Tools
* [delta](https://github.com/dandavison/delta)
* [ghcup](https://www.haskell.org/ghcup/)
* [rustup](https://rustup.rs/)
* [exa](https://github.com/ogham/exa)
* [color-scheme-sync](https://github.com/bash/color-scheme-sync)

## Gnome Shell Extensions
* [Space Bar](https://github.com/christopher-l/space-bar)
* [Dash to Dock](https://micheleg.github.io/dash-to-dock/)
