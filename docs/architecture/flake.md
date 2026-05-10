# Flake

## Inputs principaux

La flake déclare notamment:

- `nixpkgs` (canal stable principal, branche `nixos-25.11`)
- `nixpkgs-unstable` (exceptions explicites)
- `home-manager` (branche `release-25.11`, suit `nixpkgs`)
- `stylix` (branche `release-25.11`)
- `zen-browser`
- `pipewire-screenaudio`
- `codex-cli-nix`

Voir aussi la page [Inputs](../reference/inputs.md).

## Outputs utilisés

- `nixosConfigurations.desktop`
- `nixosConfigurations.laptop`
- `overlays.imagemagick-compat`
- `checks.x86_64-linux.hyprland-rules`

## Spécificités

- `nixpkgs` est le canal stable par défaut.
- `desktop` et `laptop` reçoivent `pkgs-unstable` dans `specialArgs` pour les paquets rapides explicitement sélectionnés.
- Les modules Home Manager reçoivent aussi `pkgs-unstable` via `home-manager.extraSpecialArgs`.
- Les paquets doivent venir de `pkgs` par défaut; les exceptions depuis `pkgs-unstable` restent regroupées dans des listes explicites (`unstableGamingPkgs`, `unstableCompatibilityPkgs`, etc.).
- Les deux hosts utilisent `commonModules` puis ajoutent leur module host.
