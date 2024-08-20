# more or less direct port of `console-login-helper-messages`:
# https://github.com/coreos/console-login-helper-messages/blob/main/usr/share/console-login-helper-messages/profile.sh

if status is-interactive
    # Test if we're booted with systemd:
    # https://www.freedesktop.org/software/systemd/man/latest/sd_booted.html#Notes
    if test -d /run/systemd/system
        set -l failed "$(systemctl list-units --state=failed --no-legend --plain)"
        if test -n "$failed"
            set -l count (echo "$failed" | wc -l)
            echo '[systemd]' 1>&2
            echo -e "  Failed units: \e[31m$count\e[39m" 1>&2
            echo -n "$failed" | awk '{ print "    " $1 }' 1>&2
        end
    end
end
