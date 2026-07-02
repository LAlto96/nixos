# Hyprland

## Organisation

- Base partagée : `hyprland.base.lua`
- Surcharge hôte : `wm-desktop/hyprland.lua` ou `wm-laptop/hyprland.lua`
- Liaison Nix/Home Manager: `wm-desktop/wm.nix` et `wm-laptop/wm.nix`

Les modules WM sélectionnent explicitement `configType = "lua"`. Les deux
fragments sont déployés dans `$XDG_CONFIG_HOME/hypr` via `xdg.configFile`, puis
chargés avec `require()` depuis le `hyprland.lua` généré par Home Manager.

## Outils liés

- `hyprpanel` (package système + fichiers JSON/SCSS côté home)
- `hyprlock` + `hypridle`
- script de check des règles: `scripts/check-hyprland-rules.sh`

## Validation des règles

```sh
bash scripts/check-hyprland-rules.sh
```

Ce script valide les trois fragments avec `luac -p`. Il échoue aussi si une
ancienne configuration Hyprlang contient :

- `windowrulev2` est utilisé,
- l'ancienne syntaxe de matcher est utilisée,
- `stayfocused` est utilisé au lieu de `stay_focused`.

Après la première activation de la migration :

```sh
hyprctl reload full-reset
hyprctl configerrors
```

Vérifier ensuite les écrans, l'affectation des workspaces, les raccourcis et le
fond d'écran.
