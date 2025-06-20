{ config, pkgs, nixpkgs-stable, inputs, lib, ... }:

{
  ###############################
  # 1. Imports & External Files
  ###############################
  # Import additional NixOS configuration files and package definitions.
  imports =
    [
      ./packages/common.nix    # Common package definitions
      #  ./python.nix      # Python-specific configurations
    ];

  ######################################
  # 2. Hardware & Virtualization Settings
  ######################################
  #zSwap
  zramSwap.enable = true;


  # virtualisation.docker.enable = true;

  # VirtualBox host support and group membership for desktop user.
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "desktop" ];

  # Enable libvirt for virtualization management and virt-manager as the GUI.
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Enable Logitech wireless devices with both CLI and graphical tools.
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;


  hardware.nvidia-container-toolkit.enable = true;
  ##############################
  # 3. Boot & Kernel Settings
  ##############################
  # Use systemd-boot as the bootloader and allow it to manage EFI variables.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Secure boot: include a secret for the initrd (adjust as needed).
  # boot.initrd.secrets = {
  #   "/crypto_keyfile.bin" = null;
  # };

  # Enable support for NTFS filesystems.
  boot.supportedFilesystems = [ "ntfs" ];

  # Increase inotify watch limit.
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = "204800";
  };

  # Configure the kernel and add custom kernel modules.
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.extraModprobeConfig = ''
    # Configure v4l2loopback: virtual camera settings for apps like Skype, Zoom, and Teams.
    options v4l2loopback video_nr=0,1 exclusive_caps=1,1 card_label="Virtual Camera 0","OBS Camera"
  '';

  # Enable Plymouth boot splash.
  boot.plymouth.enable = true;

  ##############################
  # 4. Security & Policy
  ##############################
  # Enable Polkit for managing system-wide privileges.
  security.polkit.enable = true;
  # Enable realtime kit for low-latency processes (e.g., audio).
  security.rtkit.enable = true;

  ##############################
  # 5. Networking Configuration
  ##############################
  # Set the system hostname.
  networking.hostName = "nixos";

  # Firewall configuration: use a loose reverse path check.
  networking.firewall.checkReversePath = "loose";

  # Enable wireless support (wpa_supplicant will be used).
  networking.wireless.enable = true;
  networking.wireless.userControlled.enable = true;

  # Enable NetworkManager for easier network management.
  networking.networkmanager.enable = true;

  # Optimize DHCP client startup and avoid waiting for the network
  networking.dhcpcd.wait = "background";
  networking.dhcpcd.extraConfig = ''
    timeout 1
    noarp
    nodelay
  '';

  # Skip waiting for full network connectivity during boot
  systemd.services."NetworkManager-wait-online".enable = false;


  networking.enableIPv6  = false;
  ##############################
  # 6. Time & Internationalization
  ##############################
  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Set default locale to English while keeping the keyboard layout in French.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS       = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT   = "en_US.UTF-8";
    LC_MONETARY      = "en_US.UTF-8";
    LC_NAME          = "en_US.UTF-8";
    LC_NUMERIC       = "en_US.UTF-8";
    LC_PAPER         = "en_US.UTF-8";
    LC_TELEPHONE     = "en_US.UTF-8";
    LC_TIME          = "en_US.UTF-8";
  };

  ##############################
  # 7. Console & X11 Settings
  ##############################
  # Configure X11 keymap.
  services.xserver = {
    xkb.layout = "fr";  # Set keyboard layout to French.
    xkb.variant = "";
  };

  # Configure console keymap and font for a better CLI experience.
  console.keyMap = "fr";
  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];  # Use Terminus font during early boot.
    font = "ter-u32n";  # Set console font.
  };

  ##############################
  # 8. Font & Appearance Settings
  ##############################
  # Install and configure system fonts.
  fonts = {
    packages = with pkgs; [
      noto-fonts          # General purpose fonts.
      noto-fonts-emoji    # Emoji support.
      meslo-lgs-nf        # Monospaced font.
      corefonts         # Basic core fonts.
      nerd-fonts.jetbrains-mono  # JetBrains Mono with extra glyphs.
    ];
    fontconfig = {
      # Enable antialiasing to improve font rendering.
      antialias = true;
      # Hinting settings for sharper text.
      hinting = {
        enable = true;
        style = "full";
        autohint = true;
      };
      # Subpixel rendering settings.
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
    };
  };

  ##############################
  # 9. User & Group Management
  ##############################
  # Define non-root users and assign them to groups as needed.
  users.users.laptop = {
    isNormalUser = true;
    description = "laptop";
    extraGroups = [ "networkmanager" "wheel" "video" "gamemode" ];
  };

  users.users.desktop = {
    isNormalUser = true;
    description = "desktop";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" "gamemode" ];
  };


  ##############################
  # 10. Nix, Package & Channel Configuration
  ##############################
  # Allow installation of unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Accept NVIDIA license for proprietary drivers.
  nixpkgs.config.nvidia.acceptLicense = true;

  # Permit specific insecure packages.
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
    "freeimage-unstable-2021-11-01"
  ];

  # Enable experimental Nix features like the nix-command and flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure the flake input for nixpkgs.
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  # Set up Nix paths.
  nix.nixPath = [
    "nixpkgs=/etc/channels/nixpkgs"
    "nixos-config=/etc/nixos/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  # Link the nixpkgs channel to the specified input.
  environment.etc."channels/nixpkgs".source = inputs.nixpkgs.outPath;

  ##############################
  # 11. Environment & Shell Configuration
  ##############################
  # Set global environment variables.
  environment.variables = {
    QT_QPA_PLATFORM = "wayland;xcb";  # Allow Qt apps to use Wayland with fallback to X.
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable and set Zsh as the default shell.
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  ##############################
  # 12. D-Bus & XDG Portals
  ##############################
  # Enable D-Bus for inter-process communication.
  services.dbus.enable = true;

  # Enable XDG portals, adding the GTK portal for better GTK application compatibility.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  ##############################
  # 13. Additional Service Configurations
  ##############################
  # Enable Flatpak support for sandboxed applications.
  services.flatpak.enable = true;

  # Enable Udisks2 for disk management and mounting.
  services.udisks2.enable = true;

  # Disable logrotate config checking (useful if you have custom logrotate setups).
  services.logrotate.checkConfig = false;

  # Enable the Emacs service and set the package to be used.
  services.emacs = {
    enable = true;
    defaultEditor = true;
  };

  # LLM - Ollama - OpenWebUI
  # services.ollama = {
  #   enable = true;
  #   acceleration = "cuda";
  # };
  # services.open-webui = {
  #   enable = true;
  #   port = 8777;
  # };

  ##############################
  # 14. Application & Program Settings
  ##############################
  # Enable Hyprland (a Wayland compositor) & Hyprlock/Hypridle.
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  # Start the hyprsunset daemon as a user service
  systemd.user.services.hyprsunset = {
    description = "Hyprsunset color temperature control";
    serviceConfig = {
      # Start hyprsunset with --identity so the display
      # color is initially unmodified until adjusted by hyprsunset.sh
      ExecStart = "${pkgs.hyprsunset}/bin/hyprsunset --identity";
    };
    wantedBy = [ "graphical-session.target" ];
  };

  # Enable KDE Connect for device integration.
  programs.kdeconnect.enable = true;

  # Configure and enable Gamemode for gaming performance improvements.
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        desiredgov = "performance";
        desiredprof = "performance";
        renice = 11;
        ioprio = 0;
        disable_splitlock = 1;
      };
    };
  };

  # Enable Yazi text editor with a custom PDF opener configuration.
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
    # Import additional keymap settings from an external TOML file.
    settings.keymap = builtins.fromTOML (builtins.readFile ./yazikeymap.toml);
  };

  # Enable CoreCtrl for system monitoring and hardware control.
  programs.corectrl.enable = true;

  ##############################
  # 15. Multimedia & Audio Settings
  ##############################
  # Disable PulseAudio since Pipewire is used.
  services.pulseaudio.enable = false;

  # Configure Pipewire for audio and multimedia.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Uncomment the following line to enable JACK support if needed.
    # jack.enable = true;
    wireplumber.enable = true;
  };

  ##############################
  # 16. Desktop Appearance & Stylix Integration
  ##############################
  # Configure Stylix for theming and desktop customization.
  stylix.enable = true;
  stylix.image = ./hm/wallpaper/wall3.png;  # Set the desktop wallpaper.
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
  stylix.homeManagerIntegration.followSystem = true;
  stylix.targets.qt.platform = lib.mkForce "qtct";
  stylix.cursor.package = pkgs.catppuccin-cursors.latteSapphire;
  stylix.cursor.name = "catppuccin-latte-sapphire-cursors";
  stylix.cursor.size = 32;
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono NF";
    };
    # Use the same monospace font for other font roles.
    serif = config.stylix.fonts.monospace;
    sansSerif = config.stylix.fonts.monospace;
    emoji = config.stylix.fonts.monospace;
  };

  ##############################
  # 17. System Maintenance
  ##############################
  # Configure Nix garbage collection settings.
  # nix.gc = {
  #   automatic = true;
  #   dates = "13:30";  # Schedule GC daily at 01:30 PM.
  #   options = "--delete-older-than 10d";  # Remove GC roots older than 10 days.
  # };

  ##############################
  # 18. Final System State Version
  ##############################
  # Set the state version for NixOS. This should remain unchanged unless you understand the implications.
  system.stateVersion = "23.05";  # Did you read the comment?
}
