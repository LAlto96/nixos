# Overview

The flake exposes two NixOS configurations:

- `desktop`
- `laptop`

Both hosts share a common base (`common-modules.nix` + `configuration.nix`) and then add host-specific modules (GPU, packages, services).

```mermaid
flowchart TD
  A[flake.nix] --> B[common-modules.nix]
  B --> C[configuration.nix]
  B --> D[stylix.nixosModules.stylix]
  B --> E[home-manager.nixosModules.home-manager]

  A --> F[hosts/desktop/default.nix]
  A --> G[hosts/laptop/default.nix]

  F --> H[home-desktop.nix]
  G --> I[home-laptop.nix]

  H --> J[wm-desktop/wm.nix]
  I --> K[wm-laptop/wm.nix]
```
