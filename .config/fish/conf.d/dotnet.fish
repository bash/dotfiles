# Disable welcome message
set -x DOTNET_NOLOGO 1
# Disable telemetry
set -x DOTNET_CLI_TELEMETRY_OPTOUT 1
# Suppress warnings when using a preview SDK
set -x SuppressNETCoreSdkPreviewMessage 1
# Do not try to modify PATH
set -s DOTNET_ADD_GLOBAL_TOOLS_TO_PATH 0

# Make .NET follow the XDG base dir spec roughly
if not set -q XDG_CACHE_HOME
    set XDG_CACHE_HOME $HOME/.cache
end

set -x DOTNET_BUNDLE_EXTRACT_BASE_DIR $XDG_CACHE_HOME/dotnet
set -x NUGET_PACKAGES $XDG_CACHE_HOME/nuget/packages
set -x NUGET_HTTP_CACHE_PATH $XDG_CACHE_HOME/nuget/v3-cache
set -x NUGET_PLUGINS_CACHE_PATH $XDG_CACHE_HOME/nuget/plugins-cache

# Environment for host
set -x DOTNET_ENVIRONMENT Development
