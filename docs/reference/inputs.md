# Inputs de la flake

## Inputs déclarés

| Input | Source | Usage principal |
|---|---|---|
| `nixpkgs` | `github:nixos/nixpkgs/nixos-25.11` | base stable par défaut pour les packages/modules |
| `nixpkgs-unstable` | `github:NixOS/nixpkgs/nixpkgs-unstable` | exceptions rapides explicites, principalement gaming/compatibilité |
| `home-manager` | `github:nix-community/home-manager/release-25.11` | configuration utilisateur, suit `nixpkgs` |
| `stylix` | `github:danth/stylix/release-25.11` | theming aligné sur la branche stable |
| `pipewire-screenaudio` | `github:IceDBorn/pipewire-screenaudio` | dépendance potentielle navigateur/audio |
| `codex-cli-nix` | `github:sadjow/codex-cli-nix` | package `codex` |
| `zen-browser` | `github:youwen5/zen-browser-flake` | package navigateur |

## Vérifier les versions lockées

```sh
nix flake metadata
```

ou consulter directement `flake.lock`.

## Policy branches

- Garder `nixpkgs`, `home-manager` et `stylix` alignés sur la même release stable.
- Ne pas ajouter de nouvel input stable parallèle: `nixpkgs` est déjà la base stable.
- Utiliser `nixpkgs-unstable` uniquement pour une exception nommée et localisée.
