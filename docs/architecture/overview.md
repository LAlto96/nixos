# Vue d'ensemble

La flake expose deux configurations NixOS:

- `desktop`
- `laptop`

Les deux hosts partagent un socle commun (`common-modules.nix` + `configuration.nix`) puis ajoutent leurs modules spécifiques (GPU, paquets, services).

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

## Principes

1. **Base commune**: boot, réseau, sécurité, audio, services partagés.
2. **Spécificité par machine**: GPU, virtualisation, firewall, tuning.
3. **Session utilisateur**: Home Manager + configuration WM.
