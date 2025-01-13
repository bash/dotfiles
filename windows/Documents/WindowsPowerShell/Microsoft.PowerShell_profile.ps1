Set-Alias -Name subl -Value 'C:\Program Files\Sublime Text\subl.exe'

# From <https://superuser.com/a/1748972>:
Set-PSReadLineOption -Colors @{
  Command            = 'Black'
  Number             = 'DarkGray'
  Member             = 'DarkGray'
  Operator           = 'DarkGray'
  Type               = 'DarkGray'
  Variable           = 'DarkGreen'
  Parameter          = 'DarkGreen'
  ContinuationPrompt = 'DarkGray'
  Default            = 'DarkGray'
}


# History search is bound to F8/Shift-F8 by default
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord DownArrow -Function HistorySearchForward

# CTRL-a and CTRL-e for start and end of line
Set-PSReadLineKeyHandler -Chord Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord Ctrl+e -Function EndOfLine

function prompt {
    Write-Host

    $folderName = if ((Get-Location).Path -eq $HOME) { '~' } else { Split-Path -Path (Get-Location) -Leaf }
    Write-Host -NoNewline $folderName
    Write-Git-Branch-Indicator

    Write-Host
    return "▷ "
}

function env {
    gci env:* | Sort-Object name
}

function Write-Git-Branch-Indicator {
    $branch = git branch --show-current
    if ($LastExitCode -eq 0)
    {
        Write-Host -NoNewline " ("

        if ($branch -eq $null) {
            Write-Host -NoNewline -ForegroundColor Red "$(git rev-parse --short HEAD)..."
        }
        else {
            Write-Host -NoNewline -ForegroundColor Green $branch
            Write-Git-Dirty-State
            Write-Host -NoNewline (Get-Git-Upstream-Indicator)
        }

        Write-Host -NoNewline ")"
    }
}

function Write-Git-Dirty-State {
    git diff --no-ext-diff --quiet
    $dirty = $LastExitCode -eq 1

    git diff --no-ext-diff --cached --quiet
    $hasStagedFiles = $LastExitCode -eq 1

    if ($dirty -or $hasStagedFiles) {
        Write-Host -NoNewLine ' '
    }

    if ($dirty) {
        Write-Host -NoNewLine -ForegroundColor Red '*'
    }

    if ($hasStagedFiles) {
        Write-Host -NoNewLine -ForegroundColor Green '+'
    }
}

function Get-Git-Upstream-Indicator {
    $upstream = git rev-parse --abbrev-ref --symbolic-full-name '@{u}'
    $count = git rev-list --count --left-right "$upstream...HEAD"

    switch -Wildcard ($count) {
        "" { return "" }
        "0`t0" { return "=" }
        "0`t*" { return ">" }
        "*`t0" { return "<" }
        default { return "<>" }
    }
}
