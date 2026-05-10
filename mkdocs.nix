{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
      mkdocs
      mkdocs-material
      pymdown-extensions
    ]))
  ];
}
