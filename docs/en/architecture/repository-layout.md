# Repository layout

| Path | Role |
|---|---|
| `flake.nix` | Main entry point |
| `common-modules.nix` | Shared modules for all hosts |
| `configuration.nix` | Shared system configuration |
| `hosts/` | Host-specific modules |
| `home-*.nix` | Home Manager entry points |
| `hm/` | Shared Home Manager modules |
| `packages/` | Shared + host package sets |
| `overlays/` | Nixpkgs overlays |
| `drivers/` | Driver modules |
| `scripts/` | Utility/check scripts |
