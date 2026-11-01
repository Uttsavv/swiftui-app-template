#!/usr/bin/env bash
# Installs XcodeGen if needed and generates the Xcode project.
set -euo pipefail
cd "$(dirname "$0")/.."
command -v xcodegen >/dev/null || brew install xcodegen
xcodegen generate
echo "Open $(ls -d *.xcodeproj | head -1)"
