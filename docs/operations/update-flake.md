# Mise à jour de la flake

## Mettre à jour tous les inputs

```sh
nix flake update
```

## Mettre à jour un input précis

```sh
nix flake lock --update-input nixpkgs
```

## Policy branches

- `nixpkgs`, `home-manager` et `stylix` restent alignés sur la release stable courante.
- `nixpkgs-unstable` peut être mis à jour séparément pour les exceptions explicites.
- Un changement de release stable doit mettre à jour les branches concernées dans `flake.nix`, puis le lock.

## Vérifier après mise à jour

```sh
nix flake check --no-build
sudo nixos-rebuild dry-activate --flake .#desktop
sudo nixos-rebuild dry-activate --flake .#laptop
```
