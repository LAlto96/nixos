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
- Politique CPU NixOS normale hors jeu ; GameMode demande temporairement un profil de performance sans renice ni priorité d'E/S agressifs.
- Kernel stable de la release NixOS sélectionnée.
- SDDM + Plasma 6 + session par défaut `hyprland`.
- Home Manager utilisateur: `desktop`.
- Discord et Discord Canary patchés côté paquet Nix pour NVIDIA screen sharing.

## Firewall

Les ports sont centralisés dans `hosts/desktop/ports.nix` et appliqués en TCP/UDP.
