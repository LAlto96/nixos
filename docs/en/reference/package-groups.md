# Package groups

Shared package groups are maintained in `packages/common.nix` under `pkgs2_*` lists. Those lists use stable `pkgs` by default.

Common unstable exception lists:

- `unstableGamingPkgs`: gaming packages from `pkgs-unstable`
- `unstableCompatibilityPkgs`: packages missing from stable, sourced from `pkgs-unstable`

Host-specific package additions:

- `packages/desktop.nix` (`pkgs3_*` lists + `unstableGamingDesktopPkgs`)
- `packages/laptop.nix`
