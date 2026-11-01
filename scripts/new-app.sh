#!/usr/bin/env bash
# Turns a fresh copy of the template into a new app.
# Usage: scripts/new-app.sh MyApp com.yourname
set -euo pipefail
cd "$(dirname "$0")/.."

name="${1:?Usage: scripts/new-app.sh AppName com.bundle.prefix}"
prefix="${2:?Usage: scripts/new-app.sh AppName com.bundle.prefix}"
[[ "$name" =~ ^[A-Za-z][A-Za-z0-9]*$ ]] || { echo "AppName must be letters and digits, starting with a letter"; exit 1; }

files=$(grep -rlI --exclude-dir=.git --exclude-dir=.claude --exclude-dir=.build -e AppTemplate -e com.example . || true)
for f in $files; do
  perl -pi -e "s/AppTemplate/$name/g; s/com\.example/$prefix/g" "$f"
done
[ -f App/Sources/AppTemplateApp.swift ] && mv App/Sources/AppTemplateApp.swift "App/Sources/${name}App.swift"

perl -pi -e 's/^status: .*/status: draft/' docs/design-brief.md
echo "Renamed to $name ($prefix.$name). Next: scripts/bootstrap.sh, then start Claude; it will ask about colours and motion first."
