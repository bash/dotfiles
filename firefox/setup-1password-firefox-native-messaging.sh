#!/bin/sh
# shellcheck disable=SC3040
set -euxo pipefail

if ! type jq >/dev/null 2>&1; then
    echo 'Missing required dependency: jq'
    exit 1
fi

flatpak_name=org.mozilla.firefox

# Allow firefox to spawn processes on the host
# with `flatpak-spawn`
flatpak override --user --talk-name=org.freedesktop.Flatpak "$flatpak_name"

# Add flatpak's session helper to the custom allowed browsers
sudo mkdir -p /etc/1password
echo "flatpak-session-helper" | sudo tee /etc/1password/custom_allowed_browsers

# Create a shim that forwards to the host's browser support executable
mkdir -p "$HOME/.var/app/$flatpak_name/data/bin"
echo '#!/bin/sh
exec flatpak-spawn --host /opt/1Password/1Password-BrowserSupport $@' \
    > "$HOME/.var/app/$flatpak_name/data/bin/1Password-BrowserSupport"
chmod +x "$HOME/.var/app/$flatpak_name/data/bin/1Password-BrowserSupport"

# Configure native messaging for our shim
mkdir -p "$HOME/.var/app/$flatpak_name/.mozilla/native-messaging-hosts"
jq --arg path "$HOME/.var/app/$flatpak_name/data/bin/1Password-BrowserSupport" '.path = $path' \
    < "$HOME/.mozilla/native-messaging-hosts/com.1password.1password.json" \
    > "$HOME/.var/app/$flatpak_name/.mozilla/native-messaging-hosts/com.1password.1password.json"
