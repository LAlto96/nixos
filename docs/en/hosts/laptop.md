# Host `laptop`

## Imports

- `hardware-configuration-laptop.nix`
- `amdgpu.nix`
- `packages/laptop.nix`
- `tlp.nix`
- `drivers/rtw89.nix`

## Key specifics

- Bluetooth + `blueman` enabled
- 16 GiB swapfile at `/var/lib/swapfile`
- `vm.swappiness = 20`
- SDDM + Plasma 6 + default session `hyprland`
