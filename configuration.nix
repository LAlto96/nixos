# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
  {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./python.nix
    ];

  services.flatpak.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = "204800";
  };
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_6;
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ config.boot.kernelPackages.v4l2loopback ];
 # boot.extraModprobeConfig = ''
 #   # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
 #   # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
 #   # https://github.com/umlaeute/v4l2loopback
 #   options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
 # '';
  nixpkgs.config.nvidia.acceptLicense = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  services.udisks2.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "fr";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Console font
  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    font = "ter-u32n";
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      meslo-lgs-nf
      corefonts
    ];

    fontconfig = {
      # Fixes pixelation
      antialias = true;

      # Fixes antialiasing blur
      hinting = {
        enable = true;
        style = "full"; # no difference
        autohint = true; # no difference
      };

      subpixel = {
        # Makes it bolder
        rgba = "rgb";
        lcdfilter = "default"; # no difference
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.laptop = {
    isNormalUser = true;
    description = "laptop";
    extraGroups = [ "networkmanager" "wheel" "video"];
  };
  users.users.desktop = {
    isNormalUser = true;
    description = "desktop";
    extraGroups = [ "networkmanager" "wheel" "video" "docker"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Unsecure packages
  nixpkgs.config.permittedInsecurePackages = [
                "electron-25.9.0"
              ];

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.nixPath = [ "nixpkgs=/etc/channels/nixpkgs" "nixos-config=/etc/nixos/configuration.nix" "/nix/var/nix/profiles/per-user/root/channels" ];
  environment.etc."channels/nixpkgs".source = inputs.nixpkgs.outPath;
  

  # Environment variables
  environment.variables = {
    QT_QPA_PLATFORM="wayland;xcb";
  };
  #XDG Portal
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Neovim
  # programs.neovim = { enable = true;
  #   defaultEditor = true;
  # };
  # Cachix for Hypland
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
  
  # Enabling Hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  
  # ZSH Integration
  programs.zsh.enable = true ;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  # Enable sound with pipewire.
  sound.enable = false;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
    wireplumber.enable = true;

  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8989 8096 ];
  networking.firewall.allowedUDPPorts = [ 8989 8096 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

