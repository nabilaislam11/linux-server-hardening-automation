#!/usr/bin/env bash
set -euo pipefail
section() { printf '\n== %s ==\n' "$1"; }
run_if_present() { if command -v "$1" >/dev/null 2>&1; then "$@" || true; else printf '%s not installed\n' "$1"; fi; }
section "Host"
hostnamectl 2>/dev/null || uname -a
section "OS"
if [[ -r /etc/os-release ]]; then grep -E '^(NAME|VERSION)=' /etc/os-release; fi
section "Uptime"
uptime
section "Disk usage"
df -hP
section "Memory"
free -h
section "SELinux"
run_if_present getenforce
section "Firewall"
if command -v firewall-cmd >/dev/null 2>&1; then firewall-cmd --state 2>&1 || true; else echo "firewalld command unavailable"; fi
section "Failed systemd units"
if command -v systemctl >/dev/null 2>&1; then systemctl --failed --no-pager --plain 2>&1 || true; fi
section "Time synchronization"
if command -v timedatectl >/dev/null 2>&1; then timedatectl show -p NTPSynchronized -p Timezone 2>&1 || true; fi
