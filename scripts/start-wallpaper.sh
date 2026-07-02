#!/usr/bin/env bash
set -u

wallpaper="${HOME}/.config/hypr/wallpaper.png"

if command -v swww-daemon >/dev/null && command -v swww >/dev/null; then
  swww-daemon &

  for _ in {1..50}; do
    if swww query >/dev/null 2>&1; then
      exec swww img "$wallpaper" --transition-type none
    fi
    sleep 0.1
  done
fi

# Keep a visible wallpaper if swww is unavailable or fails to initialize.
exec swaybg -i "$wallpaper" -m fill
