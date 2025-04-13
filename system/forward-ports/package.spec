# Helpful documentation links:
# * Documentation of rpkg: https://docs.pagure.org/rpkg-util/v3/index.html
# * Directives for the %files list: http://ftp.rpm.org/max-rpm/s1-rpm-inside-files-list-directives.html
# * RPM Macros: https://docs.fedoraproject.org/en-US/packaging-guidelines/RPMMacros/
# * RPM Macros available locally: /usr/lib/rpm/macros.d/
# * Sysusers: `man sysusers.d`

Name:       taus-dotfiles-%{_packagename}
Version:    1.0.0
Release:    %{_release}
Summary:    Forward Ports
License:    🤷🏽
BuildArch: noarch

Source:     sources.tar.gz

%description
🤷🏽

%prep
tar -xf %{SOURCE0}

%install
install -D -p -m 755 bin/forward-dns-port %{buildroot}/usr/local/bin/forward-dns-port
install -D -p -m 644 lib/systemd/system/* -t %{buildroot}/usr/local/lib/systemd/system/

%post
systemctl daemon-reload
systemctl enable --now forward-ports-dns.service
systemctl enable --now forward-ports-http.socket
systemctl enable --now forward-ports-https.socket

%preun
systemctl daemon-reload
systemctl disable --now forward-ports-dns.service
systemctl disable --now forward-ports-http.socket
systemctl disable --now forward-ports-https.socket

%files
/usr/local/bin/forward-dns-port
/usr/local/lib/systemd/system/*
