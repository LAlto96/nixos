{ config, pkgs, pkgs-stable, lib, inputs, ... }:

let
  # Stable packages from an alternate channel. For example, you might add kicad here.
  stablepkgs = with pkgs-stable; [
    # kicad
  ];

  # 2.0: To categorize
  pkgs2_0 = with pkgs; [
    nodejs
    jq
  ];

  # 2.1: General Productivity & Multimedia Tools
  pkgs2_1 = with pkgs; [
    hyprpanel             # Hyprland panel integration
    hyprsunset
    winetricks            # Helper to run Windows applications via Wine
    onlyoffice-desktopeditors  # Office suite for document editing
    audacity              # Audio editor for recording and editing
    feh                   # Lightweight image viewer and wallpaper setter
    gimp-with-plugins     # Image editing software with additional plugins
    dosbox-staging        # DOS emulator for legacy software
    libmpg123             # MP3 decoding library
    pipes                 # Fun terminal pipe animations
    cbonsai               # Bonsai tree generator for the terminal
    cmatrix               # Matrix-style screensaver for the terminal
    cava                  # Audio visualizer for the terminal
    qpwgraph              # Graphing tool (verify details online if needed)
    speedtest-go          # Command-line internet speed test
    android-tools         # Tools for interacting with Android devices
    scrcpy                # Screen mirroring tool for Android
  ];

  # 2.2: Themes & Appearance Customizations
  pkgs2_2 = with pkgs; [
    # Catppuccin GTK theme with custom settings.
    (catppuccin-gtk.override {
      accents = [ "sapphire" ];
      size = "compact";
      tweaks = [ "rimless" ];
      variant = "latte";
    })
  ];

  # 2.3: Clipboard Management & Spell Checking
  pkgs2_3 = with pkgs; [
    cliphist              # Clipboard history manager
    wl-clipboard          # Wayland clipboard utility
    xclip                 # X11 clipboard tool for copying/pasting
    clipse                # Alternative clipboard utility (check online for specifics)
    ispell                # Spell-checking tool
  ];

  # 2.4: API Testing and Development Utilities
  pkgs2_4 = with pkgs; [
    postman               # API development and testing tool
  ];

  # 2.6: Text Editors & IDEs
  pkgs2_6 = with pkgs; [
    emacs                 # Powerful text editor
    emacsPackages.vterm   # Terminal emulator within Emacs
  ];

  # 2.7: Terminal & System Utilities
  pkgs2_7 = with pkgs; [
    coreutils             # Basic file, shell, and text utilities
    ripgrep               # Fast text search tool
    fd                    # Simple, fast file finder
    clang                 # C language family compiler frontend
    libvterm              # Terminal emulator library
    neofetch              # System information tool for the terminal
    kitty                 # Modern, GPU-accelerated terminal emulator
  ];

  # 2.8: Calculator
  pkgs2_8 = with pkgs; [
    qalculate-gtk         # Feature-rich GTK calculator
  ];

  # 2.9: Camera & File Management Tools
  pkgs2_9 = with pkgs; [
    droidcam              # Stream your Android camera to your PC
    atool                 # Archive management tool (alternative to file managers like ranger)
  ];

  # 2.10: Video Processing & Utilities
  pkgs2_10 = with pkgs; [
    v4l-utils             # Tools for Video4Linux devices
    ffmpeg_6              # Multimedia framework for video/audio processing
    ffmpegthumbnailer     # Generates thumbnails from video files
  ];

  # 2.11: Virtualization
  pkgs2_11 = with pkgs; [
    qemu                  # Machine emulator and virtualizer
  ];

  # 2.12: PDF & Document Handling
  pkgs2_12 = with pkgs; [
    zathura               # Lightweight and customizable PDF viewer
    texliveFull           # Full TeX distribution for document compilation
    poppler_utils         # Utilities for PDF manipulation
  ];

  # 2.13: System Monitoring & Information Tools
  pkgs2_13 = with pkgs; [
    helvum                # Graphical audio routing tool
    upscayl               # AI-powered image upscaling tool
    btop                  # Resource monitor for system metrics
    lm_sensors            # Hardware monitoring tool
    mission-center
    s-tui
    stress
  ];

  # 2.14: Networking Tools
  pkgs2_14 = with pkgs; [
    git                   # Distributed version control system
    wirelesstools         # Tools for managing wireless interfaces
    docker-compose        # Define and run multi-container Docker applications
    wavemon              # Network analysis tool (verify details online)
  ];

  # 2.15: Browsers & Internet Utilities
  pkgs2_15 = with pkgs; [
    # Firefox with custom native messaging hosts for pipewire audio capture.
    #(firefox.override { nativeMessagingHosts = [ inputs.pipewire-screenaudio.packages.${pkgs.system}.default ]; })
    inputs.zen-browser.packages.${pkgs.system}.default # zen-browser
    ungoogled-chromium
    w3m                   # Text-based web browser
  ];

  # 2.16: Communication Tools
  pkgs2_16 = with pkgs; [
    vesktop               # Communication application (verify details online)
  ];

  # 2.17: Text Processing & Document Conversion
  pkgs2_17 = with pkgs; [
    pandoc                # Universal document converter
  ];

  # 2.18: Download Managers & VPN Tools
  pkgs2_18 = with pkgs; [
    nzbget                # NZB download tool
    motrix                # Multi-protocol download manager
    wget                  # Command-line network downloader
    protonvpn-gui         # Graphical ProtonVPN client
    protonvpn-cli         # Command-line ProtonVPN client
  ];

  # 2.19: Finance Management
  pkgs2_19 = with pkgs; [
    ledger                # Command-line accounting tool
    # ledger-web          # Ledger web interface (currently commented out)
  ];

  # 2.20: Python Environment Management
  pkgs2_20 = with pkgs; [
    conda                 # Python package, dependency, and environment manager
  ];

  # 2.21: Media Players & Streaming Tools
  pkgs2_21 = with pkgs; [
    moc                   # Console audio player
    mpv                   # Versatile media player
    yt-dlp                # Command-line YouTube downloader
    pamixer               # Command-line PulseAudio mixer utility
    pavucontrol           # Graphical PulseAudio volume control
    easyeffects           # Audio effects processor
  ];

  # 2.22: Compression & Archiving Tools
  pkgs2_22 = with pkgs; [
    zip                   # ZIP archiver
    unzip                 # Tool to extract ZIP archives
    _7zz                  # 7-Zip archiving tool
    _7zz-rar              # 7-Zip with RAR support
    unrar                 # Extractor for RAR archives
  ];

  # 2.23: Additional Utilities
  pkgs2_23 = with pkgs; [
    xdg-utils             # Utilities for XDG-compliant desktop environments
    gnome-disk-utility    # Graphical disk utility for managing storage
    gdu                   # Disk usage analyzer
  ];

  # 2.24: Wine for Windows Applications
  pkgs2_24 = with pkgs; [
    wineWowPackages.waylandFull  # Wine package optimized for Wayland
  ];

  # 2.25: Screenshots & Wallpaper Management
  pkgs2_25 = with pkgs; [
    # grimblast: screenshot utility for Hyprland (sourced from hyprland-contrib).
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    swappy              # Alternative screenshot tool
    swaybg                # Wallpaper setter for Wayland compositors
    ksnip
  ];

  # 2.26: Brightness Control Utilities
  pkgs2_26 = with pkgs; [
    wluma                 # Utility to adjust brightness in Wayland
    brightnessctl         # Command-line brightness controller
  ];

  # 2.27: Gaming Tools & Enhancements
  pkgs2_27 = with pkgs; [
    radeontop             # Monitor Radeon GPU usage in real time
    gamescope             # Compositor for game streaming and recording
    prismlauncher         # Game launcher for Linux
    mangohud             # On-screen display for monitoring game performance
    heroic                # Alternative game launcher (for Epic Games, etc.)
    lutris                # Gaming platform for Linux games
    protonup-qt           # GUI tool to update Proton versions
    protontricks          # Utility for managing Proton tweaks
    gwe
  ];

  # 2.28: Xorg Specific Tools
  pkgs2_28 = with pkgs; [
    xdotool               # Automate X window interactions
    xorg.xprop            # Utility to display window properties in X
    unixtools.xxd         # Hex dump utility
    xorg.xwininfo         # Display information about X windows
    yad                   # Yet Another Dialog for X (GUI dialogs)
    steamtinkerlaunch     # Tool to tweak Steam launch options
  ];

in
{
  ##############################################################
  # 1. Program and Service Enablings
  ##############################################################
  # Enable Java support.
  programs.java.enable = true;

  # Steam configuration: enables Steam along with firewall rules for remote play and dedicated server,
  # plus enabling a gamescope session for improved gaming performance.
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  hardware.steam-hardware.enable = true;

  ##############################################################
  # 2. System-Wide Packages
  ##############################################################
  environment.systemPackages =
    pkgs2_0 ++
    pkgs2_1 ++
    pkgs2_2 ++
    pkgs2_3 ++
    pkgs2_4 ++
    pkgs2_6 ++
    pkgs2_7 ++
    pkgs2_8 ++
    pkgs2_9 ++
    pkgs2_10 ++
    pkgs2_11 ++
    pkgs2_12 ++
    pkgs2_13 ++
    pkgs2_14 ++
    pkgs2_15 ++
    pkgs2_16 ++
    pkgs2_17 ++
    pkgs2_18 ++
    pkgs2_19 ++
    pkgs2_20 ++
    pkgs2_21 ++
    pkgs2_22 ++
    pkgs2_23 ++
    pkgs2_24 ++
    pkgs2_25 ++
    pkgs2_26 ++
    pkgs2_27 ++
    pkgs2_28 ++
    stablepkgs;  # Append any additional stable packages (e.g., kicad)
}
