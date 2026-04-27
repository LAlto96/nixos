# Host `desktop`

## Imports

- `hardware-configuration-desktop.nix`
- `nvidiagpu.nix`
- `packages/desktop.nix`
- `drivers/rtw89.nix`

## Particularités

- SSH activé sur le port `2268`.
- Docker + libvirtd + virt-manager activés.
- `vm.swappiness = 60`.
- Gouverneur CPU `performance`.
- SDDM + Plasma 6 + session par défaut `hyprland`.
- Home Manager utilisateur: `desktop`.

## Firewall

Les ports sont centralisés dans `hosts/desktop/ports.nix` et appliqués en TCP/UDP.
