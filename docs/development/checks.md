# Checks

## Checks sûrs (sans build complet)

```sh
nix flake show
nix flake check --no-build
bash scripts/check-hyprland-rules.sh
```

## Check défini dans la flake

La flake expose `checks.x86_64-linux.hyprland-rules` qui exécute `scripts/check-hyprland-rules.sh`.
