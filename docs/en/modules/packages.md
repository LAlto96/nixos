# Package modules

## `packages/common.nix`

- Enables Java, Steam, and Gamescope.
- Builds `environment.systemPackages` from `pkgs2_*` groups.
- Adds `unstableGamingPkgs` from `pkgs-unstable` for fast-moving gaming exceptions.
- Adds `unstableCompatibilityPkgs` from `pkgs-unstable` for packages missing from stable.

## `packages/desktop.nix`

Adds desktop-focused packages:

- audio/production (`reaper`, `yabridge`)
- video (`davinci-resolve`)
- virtualization (`quickemu`)
- benchmark/overclocking (`phoronix-test-suite`)
- Steam/gaming utilities (`sgdboop` from stable, `alvr` and `nvidia_oc` from unstable)

## `packages/laptop.nix`

Adds `powertop`.

## Package Policy

- Add packages to a `with pkgs; [...]` list by default.
- Use `pkgs-unstable` only when a package is missing from stable or needs a faster-moving branch.
- Keep every unstable exception in a named list that explains the reason (`unstableGamingPkgs`, `unstableCompatibilityPkgs`, `unstableGamingDesktopPkgs`).
