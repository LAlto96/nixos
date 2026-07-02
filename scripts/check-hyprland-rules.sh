#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

fail=0

if rg -n "windowrulev2\\s*=" --glob "*.conf" .; then
  echo "ERROR: deprecated windowrulev2 syntax found. Use windowrule with match:* properties." >&2
  fail=1
fi

if rg -n "windowrule\\s*=.*(^|,\\s*)(class|title|initialTitle|initialClass):" --glob "*.conf" .; then
  echo "ERROR: deprecated window matcher syntax found. Use match:class, match:title, match:initial_class, or match:initial_title." >&2
  fail=1
fi

if rg -n "windowrule\\s*=.*stayfocused" --glob "*.conf" .; then
  echo "ERROR: deprecated stayfocused effect found. Use 'stay_focused on'." >&2
  fail=1
fi

if rg -n "layerrule\\s*=\\s*(noanim|blur|blurpopups|ignorealpha|dimaround|xray|animation|order|abovelock|noscreenshare)," --glob "*.conf" .; then
  echo "ERROR: deprecated layer rule syntax found. Use a current effect and match:namespace." >&2
  fail=1
fi

if rg -n "layerrule\\s*=.*,[[:space:]]*[^,[:space:]]+[[:space:]]*(#.*)?$" --glob "*.conf" .; then
  echo "ERROR: layer rule without match:namespace found." >&2
  fail=1
fi

exit "$fail"
