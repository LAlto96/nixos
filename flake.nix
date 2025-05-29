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
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
      nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      home-manager = {
        url = "github:nix-community/home-manager";
	      inputs.nixpkgs.follows = "nixpkgs";
	      # inputs.nixpkgs.follows = "nixpkgs-unstable";
      };
      hyprland-contrib = {
        url = "github:hyprwm/contrib";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      pipewire-screenaudio.url = "github:IceDBorn/pipewire-screenaudio";
      stylix.url = "github:danth/stylix";
      hyprpanel = {
        url = "github:jas-singhfsu/hyprpanel";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      zen-browser = {
        url = "github:youwen5/zen-browser-flake"; # https://github.com/youwen5/zen-browser-flake/
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = {self, nixpkgs, nixpkgs-stable, nixpkgs-unstable, home-manager, pipewire-screenaudio, stylix, hyprpanel, zen-browser,  ... }@inputs: {
    nixosConfigurations =  {
      laptop = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        # The `specialArgs` parameter passes the
        # non-default nixpkgs instances to other nix modules
        specialArgs = {
          inherit inputs;
          # To use packages from nixpkgs-stable,
          # we configure some parameters for it first
          pkgs-stable = import nixpkgs-stable {
            # Refer to the `system` parameter from
            # the outer scope recursively
            inherit system;
            # To use Chrome, we need to allow the
            # installation of non-free software.
            config.allowUnfree = true;
          };
        };
        modules = [
          stylix.nixosModules.stylix
          ./hardware-configuration-laptop.nix
          ./configuration.nix
          ./amdgpu.nix
          ./nvidiagpu.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = false;
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
            # given the users in this list the right to specify additional substituters via:
            #    1. `nixConfig.substituters` in `flake.nix`
            nix.settings.trusted-users = [ "laptop" ];
          }
        ];
      };
      desktop = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          # To use packages from nixpkgs-stable,
          # we configure some parameters for it first
          pkgs-stable = import nixpkgs-stable {
            # Refer to the `system` parameter from
            # the outer scope recursively
            inherit system;
            # To use Chrome, we need to allow the
            # installation of non-free software.
            config.allowUnfree = true;
          };
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          {nixpkgs.overlays = [inputs.hyprpanel.overlay];}
          stylix.nixosModules.stylix
          ./hardware-configuration-desktop.nix
          ./configuration.nix
          # ./amdgpu.nix
          ./nvidiagpu.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = false;
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
            networking.firewall.allowedTCPPorts = [ 22 80 91 443 444 5037 5555 6379 7777 7878 8080 8501 8777 9100 47990 47984 48010 47998 47999 48000 48002 48010 47989 8989 8096 8211 27015 ];
            networking.firewall.allowedUDPPorts = [ 22 80 91 443 444 5037 5555 6379 7777 7878 8080 8501 8777 9100 47990 47984 48010 47998 47999 48000 48002 48010 47989 8989 8096 8211 27015 ];
            # networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
            # networking.firewall.allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
          }
          {
            virtualisation.docker.enable = true;
          }
          {
            # given the users in this list the right to specify additional substituters via:
            #    1. `nixConfig.substituters` in `flake.nix`
            nix.settings.trusted-users = [ "desktop" ];
          }
          {
            # services.sunshine = {
            #   enable = true;
            #   autoStart = true;
            #   capSysAdmin = true;
            #   openFirewall = true;
            # };
           
            # services.openssh = {
            # enable = true;
            # ports = [ 22 ];
            # settings = {
            #   PasswordAuthentication = true;
            #   AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
            #   UseDns = true;
            #   X11Forwarding = false;
            #   PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
            #   };
            # };
            # services.xserver.enable = true;
            services.displayManager.sddm.enable = true;
            # services.displayManager.autoLogin.enable = true;
            # services.displayManager.autoLogin.user = "desktop";
            services.displayManager.sddm.wayland.enable = true;
            services.desktopManager.plasma6.enable = true;
            services.displayManager.defaultSession = "hyprland";
            # boot.kernelParams = [ "ip=dhcp" ];
            # boot.initrd = {
            #   availableKernelModules = [ "r8169" ];
            #   systemd.users.root.shell = "/bin/cryptsetup-askpass";
            #   network = {
            #     enable = true;
            #     ssh = {
            #       enable = true;
            #       port = 22;
            #       authorizedKeys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWTL6IAnn17hgapb6vJlPhRU9T4aXgY+XteLRBJrlqhkENCJw7I7KWAA/7xRwLCMGw4JJtAglCMAyXDzvHy70Csn5u4ZqZ3MMzbjmsyq08y/uco4aWE7b76h/sNB5XC264NJ3nQpl4F+bTk81mFSGDzaiTh6pGcKGYCUq1FOvrGMzamqz9TQtNGqgL5j+Q4RKFOAep41Vg2+xqdTjJQMhdOcY4pz8MXQ+SUC9NQXqcmYJi95SZ9eY666kWeDChFySKNSzxdXE6vL53xh+LmnELYH3OP/IA9XfW1NEZ4tONUVR6clvSlyw5+ITlSIPjRR41PArCxQhHzTTPEEwWje+gEVduXWFZFx4tfVngId/pqMaTfCrjMkKirDQUznnbJ99Y1AQb3EzuSIZRYA+PZC1+Adhz+lddj+3BXcN9jxniNXS2hsIl5XgfJb5HdszmvALGHueW5oFZtasnR18JMjIhCFs/mjTjSi2JubGytdafRIXaCLyGRyIDgCE/c2v0q7c=" ];
            #       hostKeys = [ "/etc/secrets/initrd/ssh_host_rsa_key" ];
            #     };
            #   };
            # };
          }
        ];

      };
    };
  };
}
