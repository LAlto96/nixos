# Conventions

## Nix

- Éviter les refactors de masse sans besoin fonctionnel.
- Ajouter les nouveaux modules via imports explicites.
- Garder la séparation `commun` / `host`.
- Garder `nixpkgs`, `home-manager` et `stylix` sur la branche stable courante.
- Ajouter les paquets depuis `pkgs` par défaut; réserver `pkgs-unstable` aux exceptions nommées et regroupées.

## Documentation

- Langue: français.
- Commandes shell prêtes à copier.
- Préférer des pages courtes et ciblées.
- Marquer les zones incertaines avec **À compléter**.
