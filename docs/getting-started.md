# Getting started

## Prérequis

- Nix avec les fonctionnalités `nix-command` et `flakes`.
- Un host déclaré dans `flake.nix` (`desktop` ou `laptop`).

## Cloner la repository

```sh
git clone https://github.com/LAlto96/nixos.git
cd nixos
```

## Explorer les sorties

```sh
nix flake show
```

## Vérification rapide

```sh
nix flake check --no-build
```

## Appliquer un host

```sh
sudo nixos-rebuild switch --flake .#desktop
```

Pour le laptop:

```sh
sudo nixos-rebuild switch --flake .#laptop
```

## Après premier switch

Si vous utilisez Tailscale:

```sh
sudo tailscale up --auth-key=<VOTRE_CLE>
```
