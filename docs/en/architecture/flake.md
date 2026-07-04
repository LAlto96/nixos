# Flake

## Main inputs

- `nixpkgs` (main stable channel, `nixos-26.05`)
- `nixpkgs-unstable` (explicit exceptions)
- `home-manager` (`release-26.05`, follows `nixpkgs`)
- `stylix` (`release-26.05`)
- `zen-browser`
- `pipewire-screenaudio`
- `codex-cli-nix`

## Exposed outputs

- `nixosConfigurations.desktop`
- `nixosConfigurations.laptop`
- `overlays.imagemagick-compat`
- `checks.x86_64-linux.hyprland-rules`

## Channel Policy

- `nixpkgs` is the default stable channel.
- `desktop` and `laptop` receive `pkgs-unstable` through `specialArgs` for explicitly selected fast-moving packages.
- Home Manager modules also receive `pkgs-unstable` through `home-manager.extraSpecialArgs`.
- Packages should come from `pkgs` by default; unstable exceptions stay in clearly named lists such as `unstableGamingPkgs` and `unstableCompatibilityPkgs`.
- Both hosts use `commonModules`, then append their host module.
