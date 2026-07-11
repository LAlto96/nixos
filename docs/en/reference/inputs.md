# Flake inputs

## Declared inputs

| Input | Source | Main usage |
|---|---|---|
| `nixpkgs` | `github:nixos/nixpkgs/nixos-26.05` | default stable package/module base |
| `nixpkgs-unstable` | `github:NixOS/nixpkgs/nixpkgs-unstable` | explicit fast-moving exceptions, mainly gaming/compatibility |
| `home-manager` | `github:nix-community/home-manager/release-26.05` | user configuration, follows `nixpkgs` |
| `stylix` | `github:danth/stylix/release-26.05` | theming aligned with the stable branch |
| `pipewire-screenaudio` | `github:IceDBorn/pipewire-screenaudio` | potential browser/audio dependency |
| `codex-cli-nix` | `github:sadjow/codex-cli-nix` | `codex` package |
| `claude-code-nix` | `github:sadjow/claude-code-nix` | `claude` package |
| `millennium` | `github:SteamClientHomebrew/Millennium/next?dir=packages/nix` | overlay and Millennium-patched Steam package |
| `zen-browser` | `github:youwen5/zen-browser-flake` | browser package |

## Branch Policy

- Keep `nixpkgs`, `home-manager`, and `stylix` aligned on the same stable release.
- Do not add a second stable nixpkgs input: `nixpkgs` is already the stable base.
- Use `nixpkgs-unstable` only for named, localized exceptions.

## Tracked Fixes

### Millennium

- Official source: <https://docs.steambrew.app/users/getting-started/installation>
- NixOS megathread: <https://github.com/SteamClientHomebrew/Millennium/issues/551>
- Applied fix: `millennium.inputs.nixpkgs.follows = "nixpkgs-unstable";`.
- Reason: the NixOS megathread recommends Millennium's `next` branch. Making Millennium follow `nixpkgs-unstable` keeps its packaging on a recent base without moving the whole stable system to unstable.
- Local workaround removed: the `overlays/millennium-compat.nix` overlay and local packaging copy were deleted to return to the official packaging.
- Maintenance note: use the `next` branch and, after adding or updating this input, update the lock with `nix flake update millennium`.
