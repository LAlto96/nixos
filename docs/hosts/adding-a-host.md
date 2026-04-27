# Ajouter un host

## 1) Créer le module host

Créer `hosts/<nouveau-host>/default.nix` puis importer:

- un fichier hardware (`hardware-configuration-*.nix`),
- les modules GPU adaptés,
- les paquets spécifiques,
- éventuels modules services/drivers.

## 2) Déclarer le host dans `flake.nix`

```nix
nixosConfigurations.<nouveau-host> = nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit inputs;
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  };
  modules = commonModules ++ [
    { nixpkgs.hostPlatform = system; }
    ./hosts/<nouveau-host>
  ];
};
```

## 3) Ajouter le Home Manager utilisateur

Dans le module host:

```nix
home-manager.users.<user> = import ../../home-<host>.nix;
nix.settings.trusted-users = [ "<user>" ];
```

## 4) Vérifier

```sh
nix flake show
nix flake check --no-build
sudo nixos-rebuild dry-activate --flake .#<nouveau-host>
```
