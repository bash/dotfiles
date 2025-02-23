if type -q dotnet
    # Disable welcome message
    set -x DOTNET_NOLOGO 1
    # Disable telemetry
    set -x DOTNET_CLI_TELEMETRY_OPTOUT 1
    # Suppress warnings when using a preview SDK
    set -x SuppressNETCoreSdkPreviewMessage 1
    # Do not try to modify PATH
    set -s DOTNET_ADD_GLOBAL_TOOLS_TO_PATH 0
    # Environment for host
    set -x DOTNET_ENVIRONMENT Development
    # Disable emojis for `dotnet watch`
    set -x DOTNET_WATCH_SUPPRESS_EMOJIS 1

    # Stop `Verify` from automatically opening a diff tool
    # I want to use `dotnet verify review` instead.
    # See: https://github.com/VerifyTests/DiffEngine?tab=readme-ov-file#disable-for-a-machineprocess
    set -x DiffEngine_Disabled true

    fish_add_path --path "$HOME/.dotnet/tools"

    if not set -q XDG_CACHE_HOME
        set XDG_CACHE_HOME "$HOME/.cache"
    end

    # Try to make NuGet follow XDG conventions.
    # Unfortunately, it still creates ~/.nuget/NuGet/NuGet.Config.
    # See: <https://github.com/NuGet/Home/issues/13027>
    set -x NUGET_PACKAGES "$XDG_CACHE_HOME/NuGet/packages"
    set -x NUGET_HTTP_CACHE_PATH "$XDG_CACHE_HOME/NuGet/http-cache"
    set -x NUGET_PLUGINS_CACHE_PATH "$XDG_CACHE_HOME/NuGet/plugin-cache"
end
