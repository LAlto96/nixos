# Inputs de la flake

## Inputs déclarés

| Input | Source | Usage principal |
|---|---|---|
| `nixpkgs` | `github:nixos/nixpkgs/nixos-26.05` | base stable par défaut pour les packages/modules |
| `nixpkgs-unstable` | `github:NixOS/nixpkgs/nixpkgs-unstable` | exceptions rapides explicites, principalement gaming/compatibilité |
| `home-manager` | `github:nix-community/home-manager/release-26.05` | configuration utilisateur, suit `nixpkgs` |
| `stylix` | `github:danth/stylix/release-26.05` | theming aligné sur la branche stable |
| `pipewire-screenaudio` | `github:IceDBorn/pipewire-screenaudio` | dépendance potentielle navigateur/audio |
| `codex-cli-nix` | `github:sadjow/codex-cli-nix` | package `codex` |
| `millennium` | `github:SteamClientHomebrew/Millennium/next?dir=packages/nix` | overlay et package Steam patché par Millennium |
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

## Fixes suivis

### Millennium

- Source officielle: <https://docs.steambrew.app/users/getting-started/installation>
- Megathread NixOS: <https://github.com/SteamClientHomebrew/Millennium/issues/551>
- Fix appliqué: `millennium.inputs.nixpkgs.follows = "nixpkgs-unstable";`.
- Raison: le megathread NixOS recommande la branche `next` de Millennium. Faire suivre `nixpkgs-unstable` à Millennium garde son packaging sur une base récente sans basculer tout le système stable.
- Workaround local retiré: l'overlay `overlays/millennium-compat.nix` et la copie locale du packaging ont été supprimés pour revenir au packaging officiel.
- Note de maintenance: utiliser la branche `next` et, après l'ajout ou la mise à jour de cet input, mettre à jour le lock avec `nix flake update millennium`.
