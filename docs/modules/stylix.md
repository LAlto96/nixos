# Stylix

Stylix est injecté depuis `common-modules.nix` et configuré dans `configuration.nix`.

## Configuration active

- `stylix.enable = true`
- Image: `hm/wallpaper/wall3.png`
- Schéma base16: `catppuccin-latte`
- Curseur: `catppuccin-latte-sapphire-cursors` (taille 32)
- Police principale: `JetBrainsMono NF`
- `stylix.homeManagerIntegration.followSystem = true`

## Cible explicitement désactivée

- `stylix.targets.vscode.enable = false` dans `home-desktop.nix`.
