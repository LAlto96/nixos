# Host `desktop`

## Imports

- `hardware-configuration-desktop.nix`
- `nvidiagpu.nix`
- `packages/desktop.nix`
- `drivers/rtw89.nix`

## Key specifics

- SSH enabled on port `2268`
- Docker + libvirtd + virt-manager enabled
- `vm.swappiness = 60`
- CPU governor `performance`
- SDDM + Plasma 6 + default session `hyprland`
