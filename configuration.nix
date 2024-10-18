# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
# let
#   myOverlays = [
#     (self: super: {
#       lsp-plugins = super.lsp-plugins.override {
#         php = super.php82;
#       };
#     })
#   ];
# in
  {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./python.nix
    ];
  # nixpkgs.overlays = myOverlays;
  # systemd-services
  # systemd.services.deckyloader = {
  #   enable = true;
  #   description = "Deckyloader";
  #   unitConfig = {
  #     Type = "simple";
  #     After = network-online.target;
  #     Wants = network-online.target;
  #     };
  #   serviceConfig = {
  #     User = "root";
  #     Restart = "always";
  #     RestartSec = "1";
  #     ExecStart = "${HOMEBREW_FOLDER}/services/PluginLoader";
  #     WorkingDirectory="${HOMEBREW_FOLDER}/services";
  #     Environment="PLUGIN_PATH=${HOMEBREW_FOLDER}/plugins";
  #     KillSignal="SIGKILL";
  #     };
  #   serviceInstall = {
  #     WantedBy = [ "multi-user.target" ];
  #     };
  #   };

  services.flatpak.enable = true;
  nix.settings.auto-optimise-store = true;
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
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_6;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_lqx;
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.extraModprobeConfig = ''
    # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
    # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
    # https://github.com/umlaeute/v4l2loopback
    options v4l2loopback video_nr=0,1 exclusive_caps=1,1 card_label="Virtual Camera 0","OBS Camera"
  '';
  security.polkit.enable = true;


# Plymouth

  boot.plymouth = {
    enable = true;
    # theme = "pixels";
    # themePackages = with pkgs; [
    #   # By default we would install all themes
    #   (adi1090x-plymouth-themes.override {
    #     selected_themes = [ "pixels" ];
    #   })
    # ];
  };

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
    xkb.layout = "fr";
    xkb.variant = "";
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
    extraGroups = [ "networkmanager" "wheel" "video" "gamemode"];
  };
  users.users.desktop = {
    isNormalUser = true;
    description = "desktop";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" "gamemode"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Unsecure packages
  nixpkgs.config.permittedInsecurePackages = [
                "electron-25.9.0"
                "freeimage-unstable-2021-11-01"
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
  };

  programs.zsh.enable = true ;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  # Enable sound with pipewire.
  # sound.enable = false;
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

  services.emacs = {
    enable = true;
    package = pkgs.emacs; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # Open ports in the firewall.
  services.logrotate.checkConfig = false;
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

  programs.yazi = {
    enable = true;
    settings.yazi = {
      opener = {
        pdf = [
          {
            run = ''zathura "$@"'';
            block = true;
            for = "unix";
          }
        ];
        #open = [
        #  {
        #    run = ''xdg-open "$@"'';
        #    block = true;
        #    for = "unix";
        #  }
        #];
        #edit = [
        #  {
        #    run = ''nvim "$@"'';
        #    block = true;
        #    for = "unix";
        #  }
        #];
        #play = [
        #  {
        #    run = ''mpv "$@"'';
        #    block = true;
        #    for = "unix";
        #  }
        #];
        #archive = [
        #  {
        #    run = ''atool -x -e "$@"'';
        #    block = true;
        #    for = "unix";
        #  }
        #];
    };
      open = {
       prepend_rules = [
          {
            mime = "application/pdf";
            use = "pdf";
          }
        ];
      };
    };
  };



  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 11;
        ioprio = 0;
        disable_splitlock = 1;
      };
      # Warning: GPU optimisations have the potential to damage hardware
     # gpu = {
     #   apply_gpu_optimisations = "accept-responsibility";
     #   gpu_device = 1;
     #   amd_performance_level = "high";
     # };
    };
  };

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml" ;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  nix.gc = {
    automatic = true;
    dates = "02:00";
    options = "--delete-older-than 10d";
  };


}

