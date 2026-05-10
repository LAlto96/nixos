# Modules paquets

## `packages/common.nix`

- Active Java, Steam et Gamescope.
- Construit `environment.systemPackages` à partir de groupes `pkgs2_*`.
- Ajoute `unstableGamingPkgs` depuis `pkgs-unstable` pour les exceptions gaming rapides.
- Ajoute `unstableCompatibilityPkgs` depuis `pkgs-unstable` pour les paquets absents de stable.

## `packages/desktop.nix`

Ajoute des paquets orientés desktop:

- audio/prod (`reaper`, `yabridge`)
- vidéo (`davinci-resolve`)
- virtualisation (`quickemu`)
- bench/OC (`phoronix-test-suite`)
- outils Steam/gaming (`sgdboop` depuis stable, `alvr` et `nvidia_oc` depuis unstable)

## Policy paquets

- Ajouter un paquet dans une liste `with pkgs; [...]` par défaut.
- Utiliser `pkgs-unstable` seulement quand le paquet est absent de stable ou doit suivre un rythme plus rapide.
- Regrouper chaque exception unstable dans une liste nommée qui explique la raison (`unstableGamingPkgs`, `unstableCompatibilityPkgs`, `unstableGamingDesktopPkgs`).

## `packages/laptop.nix`

Ajoute `powertop`.
