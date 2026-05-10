# Modules paquets

## `packages/common.nix`

- Active Java, Steam et Gamescope.
- Construit `environment.systemPackages` à partir de groupes `pkgs2_*`.
- Ajoute `unstableGamingPkgs` depuis `pkgs-unstable` pour les exceptions gaming rapides.

## `packages/desktop.nix`

Ajoute des paquets orientés desktop:

- audio/prod (`reaper`, `yabridge`)
- vidéo (`davinci-resolve`)
- virtualisation (`quickemu`)
- bench/OC (`phoronix-test-suite`)
- outils Steam/gaming (`sgdboop` depuis stable, `alvr` et `nvidia_oc` depuis unstable)

## `packages/laptop.nix`

Ajoute `powertop`.
