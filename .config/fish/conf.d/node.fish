if type -q npm
    # Disable update notifications for NPM
    # https://docs.npmjs.com/cli/v6/using-npm/config#update-notifier
    set -x NPM_CONFIG_UPDATE_NOTIFIER false

    # Disable funding notifications
    # https://docs.npmjs.com/cli/v6/using-npm/config#fund
    set -x NPM_CONFIG_FUND false
end
