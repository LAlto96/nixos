# Flake

## Inputs principaux

La flake déclare notamment:

- `nixpkgs` (canal principal)
- `nixpkgs-stable`
- `nixpkgs-unstable`
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

- `desktop` reçoit `pkgs-stable` **et** `pkgs-unstable` dans `specialArgs`.
- `laptop` reçoit `pkgs-stable` dans `specialArgs`.
- Les deux hosts utilisent `commonModules` puis ajoutent leur module host.
