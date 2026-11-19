# Linux Account & Privilege Review

## Account lifecycle
- Create accounts only from an authorized request, using unique identities.
- Assign least-privilege groups and approved sudo rules.
- Configure password-aging and account-expiration policy separately.
- Remove or disable access promptly when authorization ends.
- Review local interactive users and stale privileged accounts periodically.

## Commands for verification
```bash
id exampleuser
sudo chage -l exampleuser
sudo visudo -c
sudo -l -U exampleuser
```

`chage -l` distinguishes **Password expires** from **Account expires**. Changing one does not automatically change the other.

## Operational controls
- Preserve existing sudoers permissions and validate edits with `visudo`.
- Avoid unrestricted `NOPASSWD: ALL` where command-scoped access is sufficient.
- Test both permitted and denied operations using an authorized test account.
- Retain audit evidence in approved internal systems, not in this public repository.
