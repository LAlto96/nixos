{
  description = "A template that shows all standard flake outputs";
  nixConfig = {
    experimental-features = [ "nix-command" "flakes"];
    substituters = [
      "https://cache.nixos.org/"
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
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      home-manager = {
        url = "github:nix-community/home-manager";
	      inputs.nixpkgs.follows = "nixpkgs";
      };
      hyprland-contrib = {
        url = "github:hyprwm/contrib";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      pipewire-screenaudio.url = "github:IceDBorn/pipewire-screenaudio";
      stylix.url = "github:danth/stylix";
  };

  outputs = {self, nixpkgs, home-manager, pipewire-screenaudio, stylix,  ... }@inputs: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          stylix.nixosModules.stylix
          ./configuration.nix
          ./amdgpu.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.laptop = import ./home-laptop.nix;
          }
          {
            virtualisation.docker.enable = true;
          }
          {
            networking.firewall.allowedTCPPorts = [ 80 91 443 444 8501 9100 ];
            networking.firewall.allowedUDPPorts = [ 80 91 443 444 8501 9100 ];
          }
          {
            hardware.bluetooth.enable = true;
            services.blueman.enable = true;
            swapDevices = [ {
              device = "/var/lib/swapfile";
              size = 16*1024;
            } ];
          }
          {
            stylix.image = /home/laptop/Documents/nix-configuration/hm/wallpaper/wall2.png;
          }
        ];
      };
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          stylix.nixosModules.stylix
          ./configuration.nix
          ./amdgpu.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.desktop = import ./home-desktop.nix;
            home-manager.backupFileExtension = "backup";
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
            networking.firewall.allowedTCPPorts = [ 80 91 443 444 6379 7777 7878 8080 8501 9100 47990 47984 48010 47998 47999 48000 48002 48010 47989 8989 8096 8211 27015 ];
            networking.firewall.allowedUDPPorts = [ 80 91 443 444 6379 7777 7878 8080 8501 9100 47990 47984 48010 47998 47999 48000 48002 48010 47989 8989 8096 8211 27015 ];
          }
          {
            virtualisation.docker.enable = true;
          }
          {
            stylix.image = /home/desktop/Documents/nix-configuration/hm/wallpaper/wall2.png;
          }
          
   
        ];

      };
    };
  };
}
