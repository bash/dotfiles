if test (uname) = "Darwin"
    set -x SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
end

if test -z "$SSH_TTY" && test -S "$HOME/.1password/agent.sock"
    set -x SSH_AUTH_SOCK "$HOME/.1password/agent.sock"
end
