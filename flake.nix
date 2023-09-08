{
  description = "A template that shows all standard flake outputs";
  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      hyprland.url = "github:hyprwm/Hyprland";
      home-manager = {
        url = "github:nix-community/home-manager";
	      inputs.nixpkgs.follows = "nixpkgs";
      };
      hyprland-contrib = {
        url = "github:hyprwm/contrib";
        inputs.nixpkgs.follows = "nixpkgs";
      };

  # ...
  };

  outputs = {self, nixpkgs, home-manager, hyprland, ... }@inputs: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
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
          }
          {
            hardware.bluetooth.enable = true;
            services.blueman.enable = true;
            swapDevices = [ {
              device = "/var/lib/swapfile";
              size = 16*1024;
            } ];
          }
        ];
      };
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./amdgpu.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.desktop = import ./home-desktop.nix;
          }
          {
            fileSystems."/mnt/storage" =
              { 
                device = "/dev/disk/by-uuid/323ce481-302f-4675-89a9-ca0b1971d8f2";
                fsType = "ext4";
              };
              fileSystems."/mnt/ssd" =
              { 
                device = "/dev/disk/by-uuid/D0CE962DCE960C3A";
                fsType = "ntfs-3g";
              };
          }
          {
            # Open ports in the firewall.
            networking.firewall.allowedTCPPorts = [ 47990 47984 48010 47998 47999 48000 48002 48010 47989 ];
            networking.firewall.allowedUDPPorts = [ 47990 47984 48010 47998 47999 48000 48002 48010 47989 ];
          }
          # {
          #   virtualisation.docker.enable = true;
          # }
          
   
        ];

      };
    };
  };
}
