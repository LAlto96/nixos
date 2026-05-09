# NixOS configuration (flake)

Configuration NixOS personnelle pour deux machines (`desktop` et `laptop`) avec Home Manager, Stylix et Hyprland.

## Documentation

La documentation est maintenant structurée avec **MkDocs Material** et disponible en **français** et en **anglais**.

- Français: [`docs/index.md`](docs/index.md)
- English: [`docs/en/index.md`](docs/en/index.md)

### Lancer la doc en local

```sh
mkdocs serve
```

### Construire la doc statique

```sh
mkdocs build
```

## Commandes NixOS usuelles

```sh
# Prévisualiser les sorties de la flake
nix flake show

# Vérifier la flake sans build complet
nix flake check --no-build

# Appliquer la configuration desktop
sudo nixos-rebuild switch --flake .#desktop

# Appliquer la configuration laptop
sudo nixos-rebuild switch --flake .#laptop
```
