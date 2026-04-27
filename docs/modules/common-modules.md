# `common-modules.nix`

Ce fichier assemble les briques communes:

- `stylix.nixosModules.stylix`
- `./configuration.nix`
- `home-manager.nixosModules.home-manager`
- overlay `imagemagick-compat` côté système et Home Manager

## Choix Home Manager

- `home-manager.useGlobalPkgs = false`
- `home-manager.useUserPackages = true`

Cela garde une séparation nette entre paquets système et paquets utilisateurs.
