# CI

## État actuel

Aucune pipeline CI versionnée dans `.github/workflows/` dans cette repo.

## Recommandation minimale

- lancer `nix flake check --no-build`
- lancer `bash scripts/check-hyprland-rules.sh`
- (optionnel) `nix flake show`

## À compléter

Ajouter une CI GitHub Actions pour automatiser ces commandes à chaque PR.
