#!/usr/bin/env bash
# Re-vendors the agent skills listed in .claude/skills/README.md from their upstream repos.
set -euo pipefail
cd "$(dirname "$0")/.."
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT

vendor() { # repo  path-in-repo  dest-name
  local repo="$1" src="$2" dest=".claude/skills/$3"
  git clone -q --depth 1 "https://github.com/$repo" "$tmp/$3"
  rm -rf "$dest"; cp -R "$tmp/$3/$src" "$dest"; cp "$tmp/$3/LICENSE" "$dest/LICENSE"
  echo "$3 -> $(git -C "$tmp/$3" rev-parse --short HEAD)"
}

vendor twostraws/SwiftUI-Agent-Skill swiftui-pro swiftui-pro
vendor twostraws/SwiftData-Agent-Skill swiftdata-pro swiftdata-pro
vendor twostraws/Swift-Concurrency-Agent-Skill swift-concurrency-pro swift-concurrency-pro
vendor Dimillian/Skills swiftui-liquid-glass swiftui-liquid-glass
vendor n0an/Background-Execution-Agent-Skill background-execution background-execution
echo "Update the commit column in .claude/skills/README.md, review 'git diff', then commit."
