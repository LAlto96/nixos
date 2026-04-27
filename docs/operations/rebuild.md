# Rebuild

## Modes utiles

| Mode | Commande | Effet |
|---|---|---|
| Aperçu | `sudo nixos-rebuild dry-activate --flake .#desktop` | simulation |
| Temporaire | `sudo nixos-rebuild test --flake .#desktop` | actif jusqu'au reboot |
| Permanent | `sudo nixos-rebuild switch --flake .#desktop` | actif immédiatement |
| Boot suivant | `sudo nixos-rebuild boot --flake .#desktop` | appliqué au prochain démarrage |

Remplacez `desktop` par `laptop` selon le cas.
