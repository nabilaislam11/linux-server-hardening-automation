#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
echo "Checking Bash syntax..."
for file in scripts/*.sh; do bash -n "$file"; done
if command -v shellcheck >/dev/null 2>&1; then
  echo "Running ShellCheck..."
  shellcheck scripts/*.sh
else
  echo "ShellCheck unavailable; install it for full linting." >&2
fi
echo "Validation complete."
