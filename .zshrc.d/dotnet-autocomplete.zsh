# zsh parameter completion for the dotnet CLI

# Copied from Oh My Zsh: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/dotnet/dotnet.plugin.zsh
# Licensed under the MIT license (c) 2009-2022 Robby Russell and contributors (https://github.com/ohmyzsh/ohmyzsh/contributors)
# see https://github.com/ohmyzsh/ohmyzsh/blob/master/LICENSE.txt for the full license.

if [[ -z "$DOTNET" ]]; then
    if [[ -n "$WSLENV" ]]; then
        DOTNET=dotnet.exe
    else
        DOTNET=dotnet
    fi
fi

_dotnet_zsh_complete() 
{
  local completions=("$($DOTNET complete "$words" | tr '\r\n' '\n')")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assigment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}

compdef _dotnet_zsh_complete "$DOTNET"
