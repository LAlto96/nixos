#!/usr/bin/env bash
set -euo pipefail

hyprpicker -r -z >/dev/null 2>&1 &
picker_pid=$!
cleanup() {
  kill "$picker_pid" 2>/dev/null || true
}
trap cleanup EXIT

sleep 0.2
geometry="$(slurp -d)" || exit 0
kill "$picker_pid" 2>/dev/null || true
grim -g "$geometry" -t ppm - | satty --filename - --fullscreen
