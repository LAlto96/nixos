{ inputs, imageMagickCompatOverlay }:
with inputs; [
  stylix.nixosModules.stylix
  ./configuration.nix
  home-manager.nixosModules.home-manager
  ({ pkgs-unstable, ... }: {
    nixpkgs.overlays = [ imageMagickCompatOverlay ];
    home-manager.extraSpecialArgs = {
      inherit inputs pkgs-unstable;
    };
    home-manager.sharedModules = [
      {
        nixpkgs.overlays = [ imageMagickCompatOverlay ];
      }
    ];
    home-manager.useGlobalPkgs = false;
    home-manager.useUserPackages = true;
  })
]
