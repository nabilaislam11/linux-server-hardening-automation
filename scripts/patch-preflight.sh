#!/usr/bin/env bash
set -euo pipefail
echo "== Patch readiness: read-only preflight =="
date -u '+UTC %Y-%m-%dT%H:%M:%SZ'
uname -r
df -hP / /boot 2>&1 || true
if command -v dnf >/dev/null 2>&1; then
  echo "== Available package updates (dnf) =="
  set +e
  dnf -q check-update
  status=$?
  set -e
  if [[ "$status" -eq 100 ]]; then echo "Updates available"; elif [[ "$status" -eq 0 ]]; then echo "No updates reported"; else echo "Package query failed (exit $status)" >&2; exit "$status"; fi
elif command -v yum >/dev/null 2>&1; then
  echo "== Available package updates (yum) =="
  set +e
  yum -q check-update
  status=$?
  set -e
  if [[ "$status" -eq 100 ]]; then echo "Updates available"; elif [[ "$status" -eq 0 ]]; then echo "No updates reported"; else echo "Package query failed (exit $status)" >&2; exit "$status"; fi
else
  echo "Neither dnf nor yum is available." >&2
  exit 2
fi
if [[ -f /run/reboot-required ]]; then echo "Reboot flag present"; fi
echo "No packages were installed or modified."
