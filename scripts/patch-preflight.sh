#!/usr/bin/env bash
set -euo pipefail
echo "== Patch readiness: read-only preflight =="
date -u '+UTC %Y-%m-%dT%H:%M:%SZ'
uname -r
for mount in / /boot; do
  if mountpoint -q "$mount" 2>/dev/null || [[ "$mount" == "/" ]]; then df -hP "$mount"; fi
done
if command -v dnf >/dev/null 2>&1; then
  manager=dnf
elif command -v yum >/dev/null 2>&1; then
  manager=yum
else
  echo "Neither dnf nor yum is available." >&2
  exit 2
fi
echo "== Available package updates ($manager) =="
status=0
"$manager" -q check-update || status=$?
case "$status" in
  0) echo "No updates reported" ;;
  100) echo "Updates available" ;;
  *) echo "Package query failed (exit $status)" >&2; exit "$status" ;;
esac
if command -v needs-restarting >/dev/null 2>&1; then
  echo "== Reboot advisory =="
  reboot_status=0
  needs-restarting -r || reboot_status=$?
  case "$reboot_status" in
    0) echo "No reboot requirement reported" ;;
    1) echo "Reboot recommended" ;;
    *) echo "Unable to determine reboot requirement (exit $reboot_status)" ;;
  esac
fi
echo "No packages were installed or modified."
