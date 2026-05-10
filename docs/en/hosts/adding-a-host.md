# Adding a host

## 1. Create the Host Module

Create `hosts/<new-host>/default.nix` and import:

- the hardware configuration file,
- the required GPU modules,
- host-specific packages,
- optional service/driver modules.

## 2. Declare the Host in `flake.nix`

```nix
nixosConfigurations.<new-host> = nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit inputs;
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  };
  modules = commonModules ++ [
    { nixpkgs.hostPlatform = system; }
    ./hosts/<new-host>
  ];
};
```

`pkgs-unstable` is passed for explicit package exceptions only. Default package selections should still use stable `pkgs`.

## 3. Add the Home Manager User

In the host module:

```nix
home-manager.users.<user> = import ../../home-<host>.nix;
nix.settings.trusted-users = [ "<user>" ];
```

## 4. Validate

```sh
nix flake show
nix flake check --no-build
sudo nixos-rebuild dry-activate --flake .#<new-host>
```
