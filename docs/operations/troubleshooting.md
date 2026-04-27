# Dépannage

## Commandes de base

```sh
nix flake show
nix flake check --no-build
git status
```

## Activer une trace détaillée

```sh
sudo nixos-rebuild dry-activate --flake .#desktop --show-trace
```

## Vérifier les règles Hyprland

```sh
bash scripts/check-hyprland-rules.sh
```

## Symptômes courants

| Symptôme | Vérification |
|---|---|
| Erreur flake | `nix flake check --no-build` |
| Erreur host introuvable | `nix flake show` puis vérifier `nixosConfigurations` |
| Problème Hyprland rules | script `check-hyprland-rules.sh` |
| Réseau/Tailscale | `systemctl status tailscaled` puis `tailscale status` |
