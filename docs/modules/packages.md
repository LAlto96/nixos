# Modules paquets

## `packages/common.nix`

- Active Java, Steam et Gamescope.
- Construit `environment.systemPackages` à partir de groupes `pkgs2_*`.
- Ajoute `stablepkgs` depuis `pkgs-stable`.

## `packages/desktop.nix`

Ajoute des paquets orientés desktop:

- audio/prod (`reaper`, `yabridge`)
- vidéo (`davinci-resolve`)
- virtualisation (`quickemu`)
- bench/OC (`nvidia_oc`, `phoronix-test-suite`)
- outils gaming depuis stable (`sgdboop`, `alvr`)

## `packages/laptop.nix`

Ajoute `powertop`.
