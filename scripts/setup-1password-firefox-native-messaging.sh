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
# shellcheck disable=SC2016
echo '{
    "name": "com.1password.1password",
    "description": "1Password BrowserSupport",
    "path": "$HOME/.var/app/org.mozilla.firefox/data/bin/1password-wrapper.sh",
    "type": "stdio",
    "allowed_extensions": [
        "{0a75d802-9aed-41e7-8daa-24c067386e82}",
        "{25fc87fa-4d31-4fee-b5c1-c32a7844c063}",
        "{d634138d-c276-4fc8-924b-40a0ea21d284}"
    ]
}' \
    | jq --arg path "$HOME/.var/app/$flatpak_name/data/bin/1Password-BrowserSupport" '.path = $path' \
    > "$HOME/.var/app/$flatpak_name/.mozilla/native-messaging-hosts/com.1password.1password.json"


