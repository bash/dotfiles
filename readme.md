## Per-device config

### ~/.config/git/local.gitconfig
```gitconfig
[user]
	signingkey = ssh-ed25519 ...
[gpg]
	format = ssh
[gpg "ssh"]
	program = "/opt/1Password/op-ssh-sign"
```

### ~/.ssh/config
```ssh_config
# This ensures that the IdentityAgent is not overwritten
# when the agent is forwarded from the client
Match host * exec "test -z $SSH_TTY"
IdentityAgent ~/.1password/agent.sock
```

## Authenticate with Yubikey
(work in progress)

To enable authentication with Yubikey, run:
```shell
# Writes the key to the "allowed keys" file
mkdir -p ~/.config/Yubico
pamu2fcfg > ~/.config/Yubico/u2f_keys

sudo dnf install pam-u2f
sudo authselect enable-feature with-pam-u2f
sudo authselect apply-changes
```

## 1Password
1Password sometimes struggles opening with `--ozone-platform-hint=auto`.
Enabling hardware acceleration seems to help ([source](https://www.1password.community/discussions/1password/i-cant-start-wayland-native-version-of-1password-/103974/replies/155047)).

## Fonts
* [`-apple-system`](https://codeberg.org/tautropfli/apple-system-font)

## Tools
* [delta](https://github.com/dandavison/delta)
* [just](https://just.systems/)
* [gimoji](https://github.com/zeenix/gimoji)
* [rustup](https://rustup.rs/)
* [color-scheme-sync](https://github.com/bash/color-scheme-sync) \
   Needed for:
   * 1Password (otherwise only switches when mode is toggled, but not correct on startup)
   * Sublime Merge
   Also might require the `gnome-themes-extra` to fully work.

## Linux Apps
* [Warp](https://apps.gnome.org/en-GB/app/app.drey.Warp/)
* [Dynamic Wallpaper](https://flathub.org/apps/me.dusansimic.DynamicWallpaper)
* [Loupe](https://apps.gnome.org/en-GB/app/org.gnome.Loupe/)
* [Sticky Notes](https://flathub.org/en-GB/apps/com.vixalien.sticky)
* [Blanket](https://flathub.org/en-GB/apps/com.rafaelmardojai.Blanket)
* [Cartridges](https://flathub.org/en-GB/apps/hu.kramo.Cartridges)
* [Tuba](https://flathub.org/en-GB/apps/dev.geopjr.Tuba)

