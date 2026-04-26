{ inputs, imageMagickCompatOverlay }:
with inputs; [
  stylix.nixosModules.stylix
  ./configuration.nix
  home-manager.nixosModules.home-manager
  {
    nixpkgs.overlays = [ imageMagickCompatOverlay ];
    home-manager.sharedModules = [
      {
        nixpkgs.overlays = [ imageMagickCompatOverlay ];
      }
    ];
    home-manager.useGlobalPkgs = false;
    home-manager.useUserPackages = true;
  }
]
