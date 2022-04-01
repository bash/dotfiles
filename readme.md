## Per-device config

### .gitconfig.d/local.gitconfig
```gitconfig
[includeIf "gitdir:/path/to/source/GitHub/"]
		path = "~/.gitconfig.d/github.gitconfig"
# ...
```

### .zshrc.local
```bash
hash -d Source=/path/to/source
// ..
```