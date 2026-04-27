# Arborescence du dépôt

## Répertoires clés

| Chemin | Rôle |
|---|---|
| `flake.nix` | Entrée principale et composition des outputs |
| `common-modules.nix` | Modules partagés par tous les hosts |
| `configuration.nix` | Configuration système commune |
| `hosts/` | Configuration spécifique par machine |
| `home-*.nix` | Entrées Home Manager par host |
| `hm/` | Modules Home Manager partagés |
| `wm-desktop/`, `wm-laptop/` | Config Hyprland/rofi/kitty par host |
| `packages/` | Paquets communs et paquets spécifiques |
| `overlays/` | Overlays Nixpkgs |
| `drivers/` | Modules de drivers noyau/firmware |
| `scripts/` | Scripts utilitaires/checks |
| `docs/` | Documentation MkDocs |
