# Adding a host

1. Create `hosts/<new-host>/default.nix` and import required hardware/GPU/package modules.
2. Declare the host under `nixosConfigurations` in `flake.nix`.
3. Wire Home Manager user (`home-manager.users.<user>`) and trusted user.
4. Validate:

```sh
nix flake show
nix flake check --no-build
sudo nixos-rebuild dry-activate --flake .#<new-host>
```
