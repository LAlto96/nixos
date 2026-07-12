{ inputs, hyprpanelHyprlandLuaOverlay, imageMagickCompatOverlay }:
with inputs; [
  stylix.nixosModules.stylix
  ./configuration.nix
  home-manager.nixosModules.home-manager
  ({ pkgs-unstable, ... }: {
    nixpkgs.overlays = [
      hyprpanelHyprlandLuaOverlay
      imageMagickCompatOverlay
      inputs.millennium.overlays.default
    ];
    home-manager.extraSpecialArgs = {
      inherit inputs pkgs-unstable;
    };
    home-manager.sharedModules = [
      inputs.zen-browser.homeModules.beta
      {
        nixpkgs.overlays = [
          hyprpanelHyprlandLuaOverlay
          imageMagickCompatOverlay
          inputs.millennium.overlays.default
        ];
      }
    ];
    home-manager.useGlobalPkgs = false;
    home-manager.useUserPackages = true;
  })
]
