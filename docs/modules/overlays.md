# Overlays

## `overlays/imagemagick-compat.nix`

Overlay appliqué globalement pour pinner `nixos-icons` et `imagemagick` sur une révision connue, afin d'éviter des crashs liés à Stylix/KDE.

## `overlays/resolve-no-multiarch.nix`

Présent dans la repo mais non branché dans la flake actuelle. Sert à désactiver le multi-arch dans l'environnement FHS de `davinci-resolve`.

## `overlays/rtl8852cu.nix`

Présent dans la repo mais non branché dans la flake actuelle. Expose `rtl8852cu` pour plusieurs familles de kernel packages.
