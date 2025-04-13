#!/usr/bin/env bash

set -eou pipefail

function step {
    echo "▷ $(tput bold)$1$(tput sgr0)"
}

if [[ -z "$1" ]]; then
    echo "Usage $0 FILE"
    exit 1
fi

cd "$(dirname "$0")"

temp_dir=$(mktemp -d -t dotfiles-rpm.XXXXXXXXXX)
source_dir="$temp_dir/source"
mkdir -p "$source_dir"
build_dir="$temp_dir/build"
mkdir -p "$build_dir"
build_root_dir="$temp_dir/buildroot"
mkdir -p "$build_root_dir"

function cleanup {
  rm -rf "$temp_dir"
}
trap cleanup EXIT

release=$(find "./$1" -type f -print0 | \
    sort -z | \
    xargs -0 sha1sum | \
    sha1sum | \
    awk '{printf "%s", $1}' | \
    cut -c -11)

step "Packaging $1 ($release)"
tar --strip-components=2 -cvf "$source_dir/sources.tar.gz" "$1/sources"

step "Building RPM package"
rpmbuild -ba "$1/package.spec" \
    --define "_sourcedir $source_dir" \
    --define "_builddir $build_dir" \
    --define "_buildrootdir $build_root_dir" \
    --buildroot "$build_root_dir" \
    --define '_rpmdir _rpms' \
    --define '_srcrpmdir _rpms' \
    --define '_topdir ./' \
    --define "_release $release" \
    --define "_packagename $1"

rpm -Uv "_rpms/noarch/taus-dotfiles-$1-1.0.0-${release}.noarch.rpm"
