#!/usr/bin/env bash
set -u

wallpaper="${HOME}/.config/hypr/wallpaper.png"

if command -v awww-daemon >/dev/null && command -v awww >/dev/null; then
  awww-daemon &

  for _ in {1..50}; do
    if awww query >/dev/null 2>&1; then
      exec awww img "$wallpaper" --transition-type none
    fi
    sleep 0.1
  done
fi

# Keep a visible wallpaper if awww is unavailable or fails to initialize.
exec swaybg -i "$wallpaper" -m fill
