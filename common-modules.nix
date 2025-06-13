{ inputs }:
with inputs; [
  { nixpkgs.overlays = [ hyprpanel.overlay ]; }
  stylix.nixosModules.stylix
  ./configuration.nix
  home-manager.nixosModules.home-manager
  { home-manager.useGlobalPkgs = false;
    home-manager.useUserPackages = true;
  }
  { virtualisation.docker.enable = true; }
]
