set -e
systemctl daemon-reload
systemctl disable --now forward-privileged-ports-http.socket forward-privileged-ports-https.socket
systemctl stop forward-privileged-ports-http.service forward-privileged-ports-https.service
