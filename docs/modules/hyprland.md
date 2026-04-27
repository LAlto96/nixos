# Hyprland

## Organisation

- Base partagée: `hyprland.base.conf`
- Surcharge host: `wm-desktop/hyprland.conf` ou `wm-laptop/hyprland.conf`
- Liaison Nix/Home Manager: `wm-desktop/wm.nix` et `wm-laptop/wm.nix`

Les modules WM concatènent la base et le fichier host via `wayland.windowManager.hyprland.extraConfig`.

## Outils liés

- `hyprpanel` (package système + fichiers JSON/SCSS côté home)
- `hyprlock` + `hypridle`
- script de check des règles: `scripts/check-hyprland-rules.sh`

## Validation des règles

```sh
bash scripts/check-hyprland-rules.sh
```

Ce script échoue si:

- `windowrulev2` est utilisé,
- l'ancienne syntaxe de matcher est utilisée,
- `stayfocused` est utilisé au lieu de `stay_focused`.
