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
- Normal NixOS CPU policy outside games; GameMode temporarily requests a performance profile without aggressive renice or I/O priority
- Stable kernel from the selected NixOS release
- SDDM + Plasma 6 + default session `hyprland`
- Discord and Discord Canary patched at the Nix package level for NVIDIA screen sharing
