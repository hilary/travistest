#!/usr/bin/env bash

set -euo pipefail

echo "generating changelog"

currentDir=$(pwd)

# work in temp dir to prevent polluting our go.mod
cd "$(mktemp -d)"

go get -u github.com/digitalocean/github-changelog-generator

tfile=$(mktemp)
github-changelog-generator -org digitalocean -repo doctl >"$tfile"

cat "$tfile"

cd "$currentDir"
goreleaser --rm-dist --release-notes="$tfile"

echo "released!"
