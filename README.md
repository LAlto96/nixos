# NixOS Configuration

This repository contains the NixOS configuration for both a desktop and a laptop setup. For a full description of the available modules and options see [docs/CONFIGURATION.md](docs/CONFIGURATION.md).

## Getting Started

1. Clone the repository:
   ```sh
   git clone https://github.com/LAlto96/nixos.git
   cd nixos-config
   ```

2. Apply the configuration for a host:
   ```sh
   sudo nixos-rebuild switch --flake .#desktop
   ```
   Use `.#laptop` in place of `.#desktop` to build the laptop configuration.

Home-manager modules for each user are included automatically via the flake.

