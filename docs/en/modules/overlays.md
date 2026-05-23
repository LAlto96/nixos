# Overlays

- `overlays/imagemagick-compat.nix`: active overlay used by the flake.
- `inputs.millennium.overlays.default`: active overlay from the `millennium` input. It exposes `pkgs.millennium-steam`, used by `programs.steam.package`.
- `overlays/resolve-no-multiarch.nix`: present but not currently wired.
- `overlays/rtl8852cu.nix`: present but not currently wired.
