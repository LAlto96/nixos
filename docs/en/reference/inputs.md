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
| `millennium` | `github:SteamClientHomebrew/Millennium?dir=packages/nix` | overlay and Millennium-patched Steam package |
| `zen-browser` | `github:youwen5/zen-browser-flake` | browser package |

## Branch Policy

- Keep `nixpkgs`, `home-manager`, and `stylix` aligned on the same stable release.
- Do not add a second stable nixpkgs input: `nixpkgs` is already the stable base.
- Use `nixpkgs-unstable` only for named, localized exceptions.

## Tracked Fixes

### Millennium

- Official source: <https://docs.steambrew.app/users/getting-started/installation>
- NixOS megathread: <https://github.com/SteamClientHomebrew/Millennium/issues/551>
- Applied fix: `millennium.inputs.nixpkgs.follows = "nixpkgs";`.
- Reason: the NixOS megathread reports dependency drift during Millennium packaging, including frontend Bun/Pnpm dependency hash errors. Making Millennium follow this repository's `nixpkgs` input forces it to use the same base as the system configuration.
- Local workaround removed: the `overlays/millennium-compat.nix` overlay and local packaging copy were deleted to return to the official packaging.
- Maintenance note: after adding or updating this input, update the lock with `nix flake update millennium`.
