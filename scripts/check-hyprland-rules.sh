#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

fail=0

if rg -n "windowrule\\s*=" .; then
  echo "ERROR: legacy windowrule syntax found. Use windowrulev2 instead." >&2
  fail=1
fi

if rg -n "type:\\s*initialTitle" .; then
  echo "ERROR: legacy type:initialTitle matcher found. Use initialTitle instead." >&2
  fail=1
fi

exit "$fail"
