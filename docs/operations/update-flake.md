# Mise à jour de la flake

## Mettre à jour tous les inputs

```sh
nix flake update
```

## Mettre à jour un input précis

```sh
nix flake lock --update-input nixpkgs
```

## Vérifier après mise à jour

```sh
nix flake check --no-build
sudo nixos-rebuild dry-activate --flake .#desktop
sudo nixos-rebuild dry-activate --flake .#laptop
```
