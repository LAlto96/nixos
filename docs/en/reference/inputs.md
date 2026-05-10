# Flake inputs

## Declared inputs

| Input | Source | Main usage |
|---|---|---|
| `nixpkgs` | `github:nixos/nixpkgs/nixos-25.11` | default stable package/module base |
| `nixpkgs-unstable` | `github:NixOS/nixpkgs/nixpkgs-unstable` | explicit fast-moving exceptions, mainly gaming/compatibility |
| `home-manager` | `github:nix-community/home-manager/release-25.11` | user configuration, follows `nixpkgs` |
| `stylix` | `github:danth/stylix/release-25.11` | theming aligned with the stable branch |
| `pipewire-screenaudio` | `github:IceDBorn/pipewire-screenaudio` | potential browser/audio dependency |
| `codex-cli-nix` | `github:sadjow/codex-cli-nix` | `codex` package |
| `zen-browser` | `github:youwen5/zen-browser-flake` | browser package |

## Branch Policy

- Keep `nixpkgs`, `home-manager`, and `stylix` aligned on the same stable release.
- Do not add a second stable nixpkgs input: `nixpkgs` is already the stable base.
- Use `nixpkgs-unstable` only for named, localized exceptions.
