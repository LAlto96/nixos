# Host `laptop`

## Imports

- `hardware-configuration-laptop.nix`
- `amdgpu.nix`
- `packages/laptop.nix`
- `tlp.nix`
- `drivers/rtw89.nix`

## Particularités

- Bluetooth activé (`blueman` activé).
- Swapfile de 16 GiB (`/var/lib/swapfile`).
- `vm.swappiness = 20`.
- SDDM + Plasma 6 + session par défaut `hyprland`.
- Home Manager utilisateur: `laptop`.
- Alias énergie: `ac`, `bat`.
