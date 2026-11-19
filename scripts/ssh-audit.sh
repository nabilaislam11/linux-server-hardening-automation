#!/usr/bin/env bash
set -euo pipefail
if ! command -v sshd >/dev/null 2>&1; then
  echo "sshd unavailable; install OpenSSH server to audit effective settings." >&2
  exit 2
fi
echo "== SSH configuration syntax =="
if ! sshd -t; then
  echo "SSH configuration validation failed (or insufficient permissions)." >&2
  exit 1
fi
echo "== Effective SSH configuration =="
echo "Match blocks can vary by connection context; inspect with sshd -T -C when applicable."
sshd -T | awk '
  $1 ~ /^(permitrootlogin|passwordauthentication|pubkeyauthentication|permitemptypasswords|x11forwarding|maxauthtries|loglevel|allowusers|allowgroups|authenticationmethods)$/ {print}
'
echo "Review the effective policy against the approved security baseline."
