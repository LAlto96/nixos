# Stylix

Stylix est injecté depuis `common-modules.nix` et configuré dans `configuration.nix`.

## Configuration active

- `stylix.enable = true`
- Le fond d'écran est géré par `awww`, pas par Stylix.
- Schéma base16: `catppuccin-latte`
- Accent principal (`base0D`): Pink (`ea76cb`)
- Curseur: `catppuccin-latte-pink-cursors` (taille 32)
- Police principale: `JetBrainsMono NF`
- `stylix.homeManagerIntegration.followSystem = true`

## Cible explicitement désactivée

- `stylix.targets.vscode.enable = false` dans `home-desktop.nix`.
