{ config, pkgs, pkgs-stable, lib, inputs, ... }:

let
  # Stable packages from an alternate channel. For example, you might add kicad here.
  stablepkgs = with pkgs-stable; [
    # kicad
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

  ##############################################################
  # 2. System-Wide Packages
  ##############################################################
  # environment.systemPackages lists applications that will be available system-wide.
  environment.systemPackages = with pkgs; [

    #####################################
    # 2.0: To categorize
    #####################################
    nodejs

    #####################################
    # 2.1: General Productivity & Multimedia Tools
    #####################################
    hyprpanel             # Hyprland panel integration
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
    # davinci-resolve       # Professional video editing and color correction suite
    qpwgraph              # Graphing tool (verify details online if needed)
    speedtest-go          # Command-line internet speed test
    android-tools         # Tools for interacting with Android devices
    scrcpy                # Screen mirroring tool for Android

    #####################################
    # 2.2: Themes & Appearance Customizations
    #####################################
    # Catppuccin GTK theme with custom settings.
    (catppuccin-gtk.override {
      accents = [ "sapphire" ];
      size = "compact";
      tweaks = [ "rimless" ];
      variant = "latte";
    })

    #####################################
    # 2.3: Clipboard Management & Spell Checking
    #####################################
    cliphist              # Clipboard history manager
    wl-clipboard          # Wayland clipboard utility
    xclip                 # X11 clipboard tool for copying/pasting
    clipse                # Alternative clipboard utility (check online for specifics)
    ispell                # Spell-checking tool

    #####################################
    # 2.4: API Testing and Development Utilities
    #####################################
    postman               # API development and testing tool

    #####################################
    # 2.5: Digital Audio Workstations (DAWs) and Audio Tools
    #####################################
    reaper                # Digital Audio Workstation (DAW)
    yabridge              # Bridges Windows audio plugins (for DAWs)
    yabridgectl           # Utility to control yabridge

    #####################################
    # 2.6: Text Editors & IDEs
    #####################################
    emacs                 # Powerful text editor
    emacsPackages.vterm   # Terminal emulator within Emacs

    #####################################
    # 2.7: Terminal & System Utilities
    #####################################
    coreutils             # Basic file, shell, and text utilities
    ripgrep               # Fast text search tool
    fd                    # Simple, fast file finder
    clang                 # C language family compiler frontend
    libvterm              # Terminal emulator library
    neofetch              # System information tool for the terminal
    kitty                 # Modern, GPU-accelerated terminal emulator

    #####################################
    # 2.8: Calculator
    #####################################
    qalculate-gtk         # Feature-rich GTK calculator

    #####################################
    # 2.9: Camera & File Management Tools
    #####################################
    droidcam              # Stream your Android camera to your PC
    atool                 # Archive management tool (alternative to file managers like ranger)

    #####################################
    # 2.10: Video Processing & Utilities
    #####################################
    v4l-utils             # Tools for Video4Linux devices
    ffmpeg_6              # Multimedia framework for video/audio processing
    ffmpegthumbnailer     # Generates thumbnails from video files

    #####################################
    # 2.11: Virtualization
    #####################################
    qemu                  # Machine emulator and virtualizer

    #####################################
    # 2.12: PDF & Document Handling
    #####################################
    zathura               # Lightweight and customizable PDF viewer
    texliveFull           # Full TeX distribution for document compilation
    poppler_utils         # Utilities for PDF manipulation

    #####################################
    # 2.13: System Monitoring & Information Tools
    #####################################
    cmatrix               # Matrix-style terminal screensaver (repeated for emphasis)
    helvum                # Graphical audio routing tool
    upscayl               # AI-powered image upscaling tool
    btop                  # Resource monitor for system metrics
    lm_sensors            # Hardware monitoring tool
    mission-center
    s-tui
    stress

    #####################################
    # 2.14: Networking Tools
    #####################################
    git                   # Distributed version control system
    wirelesstools         # Tools for managing wireless interfaces
    docker-compose        # Define and run multi-container Docker applications

    #####################################
    # 2.15: Browsers & Internet Utilities
    #####################################
    # Firefox with custom native messaging hosts for pipewire audio capture.
    #(firefox.override { nativeMessagingHosts = [ inputs.pipewire-screenaudio.packages.${pkgs.system}.default ]; })
    inputs.zen-browser.packages.${pkgs.system}.default # zen-browser
    w3m                   # Text-based web browser

    #####################################
    # 2.16: Communication Tools
    #####################################
    vesktop               # Communication application (verify details online)

    #####################################
    # 2.17: Text Processing & Document Conversion
    #####################################
    pandoc                # Universal document converter

    #####################################
    # 2.18: Download Managers & VPN Tools
    #####################################
    nzbget                # NZB download tool
    motrix                # Multi-protocol download manager
    wget                  # Command-line network downloader
    protonvpn-gui         # Graphical ProtonVPN client
    protonvpn-cli         # Command-line ProtonVPN client

    #####################################
    # 2.19: Finance Management
    #####################################
    ledger                # Command-line accounting tool
    # ledger-web          # Ledger web interface (currently commented out)

    #####################################
    # 2.20: Python Environment Management
    #####################################
    conda                 # Python package, dependency, and environment manager

    #####################################
    # 2.21: Media Players & Streaming Tools
    #####################################
    moc                   # Console audio player
    mpv                   # Versatile media player
    yt-dlp                # Command-line YouTube downloader
    pamixer               # Command-line PulseAudio mixer utility
    pavucontrol           # Graphical PulseAudio volume control
    easyeffects           # Audio effects processor

    #####################################
    # 2.22: Compression & Archiving Tools
    #####################################
    zip                   # ZIP archiver
    unzip                 # Tool to extract ZIP archives
    _7zz                  # 7-Zip archiving tool
    _7zz-rar              # 7-Zip with RAR support
    unrar                 # Extractor for RAR archives

    #####################################
    # 2.23: Additional Utilities
    #####################################
    xdg-utils             # Utilities for XDG-compliant desktop environments
    gnome-disk-utility    # Graphical disk utility for managing storage
    gdu                   # Disk usage analyzer

    #####################################
    # 2.24: Wine for Windows Applications
    #####################################
    wineWowPackages.waylandFull  # Wine package optimized for Wayland

    #####################################
    # 2.25: Screenshots & Wallpaper Management
    #####################################
    # grimblast: screenshot utility for Hyprland (sourced from hyprland-contrib).
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    swappy              # Alternative screenshot tool
    swaybg                # Wallpaper setter for Wayland compositors

    #####################################
    # 2.26: Brightness Control Utilities
    #####################################
    wluma                 # Utility to adjust brightness in Wayland
    brightnessctl         # Command-line brightness controller

    #####################################
    # 2.27: Gaming Tools & Enhancements
    #####################################
    radeontop             # Monitor Radeon GPU usage in real time
    gamescope             # Compositor for game streaming and recording
    prismlauncher         # Game launcher for Linux
    mangohud             # On-screen display for monitoring game performance
    heroic                # Alternative game launcher (for Epic Games, etc.)
    lutris                # Gaming platform for Linux games
    protonup-qt           # GUI tool to update Proton versions
    protontricks          # Utility for managing Proton tweaks
    gwe

    #####################################
    # 2.28: Xorg Specific Tools
    #####################################
    xdotool               # Automate X window interactions
    xorg.xprop            # Utility to display window properties in X
    unixtools.xxd         # Hex dump utility
    xorg.xwininfo         # Display information about X windows
    yad                   # Yet Another Dialog for X (GUI dialogs)
    steamtinkerlaunch     # Tool to tweak Steam launch options

  ] ++ stablepkgs;  # Append any additional stable packages (e.g., kicad)

}
