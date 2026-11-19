# SSH Hardening Review

Use `bash scripts/ssh-audit.sh` to inspect the effective OpenSSH server configuration.

## Review checklist
- Verify permitted authentication methods and approved key-management practices.
- Review `PermitRootLogin`, `PermitEmptyPasswords`, `MaxAuthTries`, and logging policy.
- Check `AllowUsers` and `AllowGroups` only when present; do not introduce restrictive directives without an access impact assessment.
- Validate SSH port exposure and firewall policy.
- Inspect relevant `Match` blocks using `sshd -T -C user=...,host=...,addr=...` for a specific connection context.
- Confirm administrative access through an independent session before reloading SSH.

## Safe change sequence
1. Back up the current SSH configuration, preserving ownership and mode.
2. Apply an approved, minimal change.
3. Run `sshd -t` and inspect effective settings.
4. Maintain an existing administrative session while testing a new login.
5. Reload the service only after successful validation.
6. Verify access, audit logs, and rollback readiness.

Never disable an authentication mechanism or restrict users without confirming an alternative access path.
