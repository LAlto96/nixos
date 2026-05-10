# Update flake

## Update Inputs

```sh
nix flake update
nix flake lock --update-input nixpkgs
```

## Branch Policy

- Keep `nixpkgs`, `home-manager`, and `stylix` aligned on the current stable release.
- `nixpkgs-unstable` can be updated separately for explicit exceptions.
- A stable release change should update the related branches in `flake.nix`, then refresh the lock.

## Validate

```sh
nix flake check --no-build
sudo nixos-rebuild dry-activate --flake .#desktop
sudo nixos-rebuild dry-activate --flake .#laptop
```
