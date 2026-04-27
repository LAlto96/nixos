# Getting started

## Prerequisites

- Nix with `nix-command` and `flakes` enabled.
- A host declared in `flake.nix` (`desktop` or `laptop`).

## Clone the repository

```sh
git clone https://github.com/LAlto96/nixos.git
cd nixos
```

## Explore flake outputs

```sh
nix flake show
```

## Quick validation

```sh
nix flake check --no-build
```

## Apply a host config

```sh
sudo nixos-rebuild switch --flake .#desktop
```

For laptop:

```sh
sudo nixos-rebuild switch --flake .#laptop
```

## After first switch

If you use Tailscale:

```sh
sudo tailscale up --auth-key=<YOUR_KEY>
```
