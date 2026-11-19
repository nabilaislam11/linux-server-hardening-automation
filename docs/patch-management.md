# Linux Patch Management Runbook

## Scope
RHEL-compatible servers managed through an approved change process.

## Pre-change
- Identify target hosts, maintenance window, accountable owner, and rollback criteria.
- Confirm recent recoverable backups or snapshots and the restoration procedure.
- Record OS release, running kernel, package baseline, disk availability, and service health.
- Run `bash scripts/patch-preflight.sh` and review available advisories.
- Confirm repository access, package-manager locks, and monitoring coverage.
- Notify stakeholders and secure change approval.

## Execution
1. Confirm the maintenance window and pre-change checkpoints.
2. Apply only approved package updates using the organization\x27s supported package-management procedure.
3. Record package transaction details and any errors.
4. Reboot if required by the change plan, with console access and recovery options available.

## Post-change verification
- Check `uname -r`, `systemctl --failed`, and application service health.
- Validate expected listening services and network dependencies.
- Check monitoring, logs, resource usage, and any relevant security agents.
- Compare before/after package and kernel baselines.
- Record outcomes and obtain service-owner confirmation.

## Rollback and escalation
Stop if repositories fail, package transactions are incomplete, critical services do not recover, or validation fails. Use the approved restore/snapshot or package rollback procedure only after assessing dependencies and data consistency. Escalate according to incident severity; avoid blind downgrades.
