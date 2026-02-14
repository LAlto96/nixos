#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

fail=0

if rg -n "windowrulev2\\s*=" .; then
  echo "ERROR: deprecated windowrulev2 syntax found. Use windowrule with match:* props." >&2
  fail=1
fi

if rg -n "windowrule\\s*=.*(class:|title:|initialTitle:|initialClass:)" .; then
  echo "ERROR: legacy v2 matcher syntax found in windowrule. Use match:class/title/initial_title/initial_class." >&2
  fail=1
fi

if rg -n "windowrule\\s*=.*stayfocused" .; then
  echo "ERROR: deprecated stayfocused rule found. Use stay_focused." >&2
  fail=1
fi

exit "$fail"
