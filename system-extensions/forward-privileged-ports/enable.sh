#!/bin/sh
set -e
setsebool -P systemd_socket_proxyd_bind_any=true systemd_socket_proxyd_connect_any=true
systemctl daemon-reload
systemctl enable --now forward-privileged-ports-http.socket forward-privileged-ports-https.socket
