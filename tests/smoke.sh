#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
bash scripts/validate.sh
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
cat > "$tmp/dnf" <<'MOCK'
#!/usr/bin/env bash
exit "${MOCK_DNF_STATUS:-0}"
MOCK
chmod +x "$tmp/dnf"
for status in 0 100; do
  MOCK_DNF_STATUS="$status" PATH="$tmp:$PATH" bash scripts/patch-preflight.sh >/dev/null
done
if MOCK_DNF_STATUS=1 PATH="$tmp:$PATH" bash scripts/patch-preflight.sh >/dev/null 2>&1; then
  echo "Expected package-manager failure to propagate" >&2
  exit 1
fi
echo "Patch preflight exit-code tests passed."
