# Workflow documentation

## Ajouter/modifier une page

1. Modifier le fichier Markdown ciblé sous `docs/`.
2. Si nécessaire, mettre à jour `mkdocs.yml` (navigation).
3. Prévisualiser localement.

```sh
nix-shell mkdocs.nix --run "mkdocs serve"
```

## Build local

```sh
nix-shell mkdocs.nix --run "mkdocs build"
```

Toute nouvelle documentation doit être ajoutée dans les pages structurées de `docs/`.
