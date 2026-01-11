{
  description = "A template that shows all standard flake outputs";
  nixConfig = {
    experimental-features = [ "nix-command" "flakes"];
    substituters = [
      # cache mirror located in China
      # status: https://mirror.sjtu.edu.cn/
      # "https://mirror.sjtu.edu.cn/nix-channels/store"
      # status: https://mirrors.ustc.edu.cn/status/
      # "https://mirrors.ustc.edu.cn/nix-channels/store"

      "https://cache.nixos.org"
     ];

    extra-substituters = [
      # Nix community's cache server
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    pipewire-screenaudio.url = "github:IceDBorn/pipewire-screenaudio";
    stylix.url = "github:danth/stylix";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, nixpkgs-unstable, home-manager, pipewire-screenaudio, stylix, zen-browser, ... }:
    let
      system = "x86_64-linux";
      desktopPorts = import ./hosts/desktop/ports.nix;
      commonModules = import ./common-modules.nix { inherit inputs; };
    in {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            pkgs-stable = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
          };
          modules = commonModules ++ [
            { nixpkgs.hostPlatform = system; }
            ./hosts/laptop
          ];
        };
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            pkgs-stable = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
          modules = commonModules ++ [
            { nixpkgs.hostPlatform = system; }
            (import ./hosts/desktop { inherit desktopPorts; })
          ];
        };
      };
    };
}
