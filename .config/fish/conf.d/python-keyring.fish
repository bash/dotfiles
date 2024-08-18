# Poetry depends on keyring, and we don't want the KDE's keyring service
# to pop up.

if status is-interactive && test "$(uname)" = "Linux"
    set -x PYTHON_KEYRING_BACKEND keyring.backends.SecretService.Keyring
end
