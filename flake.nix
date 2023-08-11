{
  description = "A template that shows all standard flake outputs";
  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      hyprland.url = "github:hyprwm/Hyprland/v0.28.0";
      home-manager = {
        url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = {self, nixpkgs, home-manager,hyprland, ... }@inputs: {
    nixosConfigurations = {
      "laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = { inherit inputs; };
	modules = [
	  ./configuration.nix
	  ./amdgpu.nix
	  home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.laptop = import ./home-laptop.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
	 #  boot.initrd.kernelModules = [ "amdgpu" ];
	 #  hardware.opengl.extraPackages = with pkgs; [
	 #    rocm-opencl-icd
	 #    rocm-opencl-runtime
	 #  ];
	 #  hardware.opengl.driSupport = true;
	 #  hardware.opengl.driSupport32Bit = true;
        ];
      };
    };
  };
}
