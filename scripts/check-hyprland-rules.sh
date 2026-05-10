#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

fail=0

if rg -n "windowrule\\s*=.*,\\s*match:" .; then
  echo "ERROR: unsupported match:* matcher syntax found in windowrule. Use windowrulev2 with class:/title:/initialTitle: matchers." >&2
  fail=1
fi

if rg -n "windowrule\\s*=.*(class:|title:|initialTitle:|initialClass:)" .; then
  echo "ERROR: v2 matcher syntax found in windowrule. Use windowrulev2 for class:/title:/initialTitle:/initialClass: matchers." >&2
  fail=1
fi

if rg -n "windowrulev2\\s*=.*stay_focused" .; then
  echo "ERROR: unsupported stay_focused rule found. Use stayfocused for stable Hyprland windowrulev2 syntax." >&2
  fail=1
fi

if rg -n "layerrule\\s*\\{" --glob "*.conf" .; then
  echo "ERROR: unsupported layerrule block syntax found. Use 'layerrule = rule, namespace' syntax." >&2
  fail=1
fi

if rg -n "match:namespace" --glob "*.conf" .; then
  echo "ERROR: unsupported match:namespace syntax found. Use layerrule namespace regex as the second field." >&2
  fail=1
fi

exit "$fail"
