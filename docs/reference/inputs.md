# Inputs de la flake

## Inputs déclarés

| Input | Source | Usage principal |
|---|---|---|
| `nixpkgs` | `github:nixos/nixpkgs/nixos-25.11` | base stable packages/modules |
| `nixpkgs-unstable` | `github:NixOS/nixpkgs/nixpkgs-unstable` | exceptions rapides explicites, principalement gaming |
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
