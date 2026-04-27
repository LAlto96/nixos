# Rollback

## Depuis le bootloader

Au démarrage, sélectionner une génération précédente NixOS.

## Depuis le système en cours

```sh
sudo nixos-rebuild switch --rollback
```

## Vérifier la génération active

```sh
nixos-rebuild list-generations
```
