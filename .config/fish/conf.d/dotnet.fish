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
