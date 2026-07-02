# Hyprland

Configuration is split into:

- shared base: `hyprland.base.lua`
- host overrides: `wm-desktop/hyprland.lua` / `wm-laptop/hyprland.lua`

Both Home Manager modules explicitly select `configType = "lua"`. They deploy
the shared and host fragments under `$XDG_CONFIG_HOME/hypr` with
`xdg.configFile`; the generated `hyprland.lua` loads them with `require()`.

Validation helper:

```sh
bash scripts/check-hyprland-rules.sh
```

The helper runs `luac -p` on all three fragments and keeps checks for obsolete
Hyprlang rule syntax. After the first activation, run:

```sh
hyprctl reload full-reset
hyprctl configerrors
```

Then verify monitors, workspace assignments, key bindings, and the wallpaper.
