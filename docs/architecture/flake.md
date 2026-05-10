# Flake

## Inputs principaux

La flake déclare notamment:

- `nixpkgs` (canal principal)
- `nixpkgs-unstable` (exceptions explicites)
- `home-manager`
- `stylix`
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
- Les deux hosts utilisent `commonModules` puis ajoutent leur module host.
