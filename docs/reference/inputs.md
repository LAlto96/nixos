# Inputs de la flake

## Inputs déclarés

| Input | Source | Usage principal |
|---|---|---|
| `nixpkgs` | `github:NixOS/nixpkgs/nixos-unstable` | base packages/modules |
| `nixpkgs-stable` | `github:nixos/nixpkgs/nixos-25.11` | paquets stables additionnels |
| `nixpkgs-unstable` | `github:NixOS/nixpkgs/nixpkgs-unstable` | paquets récents (desktop) |
| `home-manager` | `github:nix-community/home-manager` | configuration utilisateur |
| `stylix` | `github:danth/stylix` | theming |
| `pipewire-screenaudio` | `github:IceDBorn/pipewire-screenaudio` | dépendance potentielle navigateur/audio |
| `codex-cli-nix` | `github:sadjow/codex-cli-nix` | package `codex` |
| `zen-browser` | `github:youwen5/zen-browser-flake` | package navigateur |

## Vérifier les versions lockées

```sh
nix flake metadata
```

ou consulter directement `flake.lock`.
