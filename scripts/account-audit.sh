#!/usr/bin/env bash
set -euo pipefail
echo "== Current account =="
id
echo
echo "== Local interactive account names =="
awk -F: '($7 !~ /(nologin|false)$/) {print $1 " (uid=" $3 ", shell=" $7 ")"}' /etc/passwd
echo
echo "== Account expiration for specified user =="
if [[ $# -gt 1 ]]; then echo "Usage: bash scripts/account-audit.sh [username]" >&2; exit 2; fi
if [[ $# -eq 1 ]]; then
  if ! id "$1" >/dev/null 2>&1; then echo "Unknown user: $1" >&2; exit 2; fi
  if command -v chage >/dev/null 2>&1; then chage -l "$1"; else echo "chage unavailable"; fi
else
  echo "Provide a username to inspect password and account expiration (requires sufficient privileges)."
fi
echo
echo "== Sudo configuration syntax =="
if command -v visudo >/dev/null 2>&1; then visudo -c 2>&1 || true; else echo "visudo unavailable"; fi
