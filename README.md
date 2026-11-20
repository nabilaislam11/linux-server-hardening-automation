# Linux Server Hardening & Automation

A practical Linux infrastructure engineering toolkit for repeatable host audits, SSH configuration review, account lifecycle checks, patch readiness, and operational verification.

## Capabilities

| Area | Implementation |
| --- | --- |
| Host audit | Read-only system inventory, services, firewall, SELinux, and security status |
| SSH hardening | Configuration assessment using effective `sshd -T` settings |
| Account management | Read-only account expiry and privileged-access review |
| Patch management | Preflight assessment and an operator-controlled patch workflow |
| Automation | Bash scripts with explicit error handling and structured output |
| Quality | Bash syntax validation, ShellCheck, and CI |

## Quick start

Requires Bash, standard GNU/Linux utilities, and appropriate permissions for the checks being performed. Designed for RHEL-compatible systems; some checks are conditional on available commands.

```bash
git clone https://github.com/nabilaislam11/linux-server-hardening-automation.git
cd linux-server-hardening-automation
bash scripts/host-audit.sh
bash scripts/ssh-audit.sh
bash scripts/account-audit.sh
bash scripts/patch-preflight.sh
bash scripts/validate.sh
```

The scripts run in read-only mode by default and report findings for review.

## Patch workflow

1. Capture host baseline and application/service health.
2. Review available updates, security advisories, disk capacity, and package-manager state.
3. Coordinate a maintenance window, backups, recovery plan, and approvals.
4. Apply approved updates through the established change process.
5. Reboot when required, then verify kernel, services, network connectivity, and monitoring.
6. Record evidence and close the change.

See [Patch management runbook](docs/patch-management.md), [SSH hardening guide](docs/ssh-hardening.md), and [Access management guide](docs/access-management.md).

## Repository layout

```text
scripts/
  host-audit.sh
  ssh-audit.sh
  account-audit.sh
  patch-preflight.sh
  validate.sh
docs/
  patch-management.md
  ssh-hardening.md
  access-management.md
.github/workflows/
  quality.yml
```

## License

MIT — see [LICENSE](LICENSE).
