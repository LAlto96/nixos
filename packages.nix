{ config, pkgs, pkgs-stable, lib, inputs, ... }:

let
  # Stable packages from an alternate channel. For example, you might add kicad here.
  stablepkgs = with pkgs-stable; [
    # kicad
  ];

  uncategorizedPkgs = with pkgs; [
    nodejs
    jq
  ];

  generalPkgs = with pkgs; [
    hyprpanel             # Hyprland panel integration
    hyprsunset            # Application to enable a blue-light filter on Hyprland
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
    davinci-resolve       # Professional video editing and color correction suite
    qpwgraph              # Graphing tool (verify details online if needed)
    speedtest-go          # Command-line internet speed test
    android-tools         # Tools for interacting with Android devices
    scrcpy                # Screen mirroring tool for Android
  ];

  appearancePkgs = with pkgs; [
    # Catppuccin GTK theme with custom settings.
    (catppuccin-gtk.override {
      accents = [ "sapphire" ];
      size = "compact";
      tweaks = [ "rimless" ];
      variant = "latte";
    })
  ];

  clipboardPkgs = with pkgs; [
    cliphist              # Clipboard history manager
    wl-clipboard          # Wayland clipboard utility
    xclip                 # X11 clipboard tool for copying/pasting
    clipse                # Alternative clipboard utility (check online for specifics)
    ispell                # Spell-checking tool
  ];

  apiDevPkgs = with pkgs; [
    postman               # API development and testing tool
  ];

  dawPkgs = with pkgs; [
    reaper                # Digital Audio Workstation (DAW)
    yabridge              # Bridges Windows audio plugins (for DAWs)
    yabridgectl           # Utility to control yabridge
  ];

  editorPkgs = with pkgs; [
    emacs                 # Powerful text editor
    emacsPackages.vterm   # Terminal emulator within Emacs
  ];

  terminalPkgs = with pkgs; [
    coreutils             # Basic file, shell, and text utilities
    ripgrep               # Fast text search tool
    fd                    # Simple, fast file finder
    clang                 # C language family compiler frontend
    libvterm              # Terminal emulator library
    neofetch              # System information tool for the terminal
    kitty                 # Modern, GPU-accelerated terminal emulator
  ];

  calculatorPkgs = with pkgs; [
    qalculate-gtk         # Feature-rich GTK calculator
  ];

  cameraPkgs = with pkgs; [
    droidcam              # Stream your Android camera to your PC
    atool                 # Archive management tool (alternative to file managers like ranger)
  ];

  videoPkgs = with pkgs; [
    v4l-utils             # Tools for Video4Linux devices
    ffmpeg_6              # Multimedia framework for video/audio processing
    ffmpegthumbnailer     # Generates thumbnails from video files
  ];

  virtualizationPkgs = with pkgs; [
    qemu                  # Machine emulator and virtualizer
  ];

  pdfPkgs = with pkgs; [
    zathura               # Lightweight and customizable PDF viewer
    texliveFull           # Full TeX distribution for document compilation
    poppler_utils         # Utilities for PDF manipulation
  ];

  monitoringPkgs = with pkgs; [
    helvum                # Graphical audio routing tool
    upscayl               # AI-powered image upscaling tool
    btop                  # Resource monitor for system metrics
    lm_sensors            # Hardware monitoring tool
    mission-center
    s-tui
    stress
  ];

  networkPkgs = with pkgs; [
    git                   # Distributed version control system
    wirelesstools         # Tools for managing wireless interfaces
    docker-compose        # Define and run multi-container Docker applications
  ];

  browserPkgs = with pkgs; [
    # Firefox with custom native messaging hosts for pipewire audio capture.
    #(firefox.override { nativeMessagingHosts = [ inputs.pipewire-screenaudio.packages.${pkgs.system}.default ]; })
    inputs.zen-browser.packages.${pkgs.system}.default # zen-browser
    w3m                   # Text-based web browser
  ];

  communicationPkgs = with pkgs; [
    vesktop               # Communication application (verify details online)
  ];

  docConversionPkgs = with pkgs; [
    pandoc                # Universal document converter
  ];

  downloadPkgs = with pkgs; [
    nzbget                # NZB download tool
    motrix                # Multi-protocol download manager
    wget                  # Command-line network downloader
    protonvpn-gui         # Graphical ProtonVPN client
    protonvpn-cli         # Command-line ProtonVPN client
  ];

  financePkgs = with pkgs; [
    ledger                # Command-line accounting tool
    # ledger-web          # Ledger web interface (currently commented out)
  ];

  pythonPkgs = with pkgs; [
    conda                 # Python package, dependency, and environment manager
  ];

  mediaPkgs = with pkgs; [
    moc                   # Console audio player
    mpv                   # Versatile media player
    yt-dlp                # Command-line YouTube downloader
    pamixer               # Command-line PulseAudio mixer utility
    pavucontrol           # Graphical PulseAudio volume control
    easyeffects           # Audio effects processor
  ];

  archivePkgs = with pkgs; [
    zip                   # ZIP archiver
    unzip                 # Tool to extract ZIP archives
    _7zz                  # 7-Zip archiving tool
    _7zz-rar              # 7-Zip with RAR support
    unrar                 # Extractor for RAR archives
  ];

  additionalPkgs = with pkgs; [
    xdg-utils             # Utilities for XDG-compliant desktop environments
    gnome-disk-utility    # Graphical disk utility for managing storage
    gdu                   # Disk usage analyzer
  ];

  winePkgs = with pkgs; [
    wineWowPackages.waylandFull  # Wine package optimized for Wayland
  ];

  screenshotPkgs = with pkgs; [
    # grimblast: screenshot utility for Hyprland (sourced from hyprland-contrib).
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    swappy              # Alternative screenshot tool
    swaybg                # Wallpaper setter for Wayland compositors
  ];

  brightnessPkgs = with pkgs; [
    wluma                 # Utility to adjust brightness in Wayland
    brightnessctl         # Command-line brightness controller
  ];

  gamingPkgs = with pkgs; [
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

  xorgPkgs = with pkgs; [
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

  ##############################################################
  # 2. System-Wide Packages
  ##############################################################
  environment.systemPackages =
    uncategorizedPkgs ++
    generalPkgs ++
    appearancePkgs ++
    clipboardPkgs ++
    apiDevPkgs ++
    dawPkgs ++
    editorPkgs ++
    terminalPkgs ++
    calculatorPkgs ++
    cameraPkgs ++
    videoPkgs ++
    virtualizationPkgs ++
    pdfPkgs ++
    monitoringPkgs ++
    networkPkgs ++
    browserPkgs ++
    communicationPkgs ++
    docConversionPkgs ++
    downloadPkgs ++
    financePkgs ++
    pythonPkgs ++
    mediaPkgs ++
    archivePkgs ++
    additionalPkgs ++
    winePkgs ++
    screenshotPkgs ++
    brightnessPkgs ++
    gamingPkgs ++
    xorgPkgs ++
    stablepkgs;  # Append any additional stable packages (e.g., kicad)
}
