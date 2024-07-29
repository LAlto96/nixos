{config, pkgs, lib, inputs, ...}:
{
  programs.java.enable = true;
  environment.systemPackages = with pkgs; [

    libmpg123
    # Themes
    (catppuccin-gtk.override {
      accents = [ "sapphire" ];
      size = "compact";
      tweaks = [ "rimless" ];
      variant = "latte";
    })

    # Container Management
    ctop

    # Clipboard Management
    cliphist
    wl-clipboard
    xclip

    # Spell Checking
    ispell

    # API Testing
    postman

    # Digital Audio Workstations (DAWs)
    reaper
    yabridge
    yabridgectl

    # Text Editors and IDEs
    emacs
    emacsPackages.vterm

    # Terminal Utilities
    coreutils
    ripgrep
    fd
    clang
    libvterm
    neofetch
    kitty

    # Calculator
    qalculate-gtk

    # Camera Tools
    droidcam

    # File Management
    ranger
    atool

    # Video Utilities
    v4l-utils
    ffmpeg_6
    ffmpegthumbnailer

    # Virtualization
    qemu

    # Diagramming and Visualization
    drawio
    graphviz

    # PDF and Document Handling
    zathura
    texliveFull
    poppler_utils

    # System Monitoring and Info
    cmatrix
    dvc
    gpu-viewer
    helvum
    upscayl
    btop
    lm_sensors

    # Networking
    git
    wirelesstools
    docker-compose

    # Browsers and Internet Tools
    (firefox.override { nativeMessagingHosts = [ inputs.pipewire-screenaudio.packages.${pkgs.system}.default ]; })
    w3m

    # Communication
    webcord-vencord
    vesktop

    # Text Processing
    pandoc

    # Downloaders
    nzbget
    motrix
    wget

    # VPN
    protonvpn-gui
    protonvpn-cli

    # Finance Management
    ledger
    ledger-web

    # Python
    conda

    # Media Streaming
    multiviewer-for-f1
    moonlight-qt

    # Development Tools
    nodejs

    # Torrent Clients
    deluged

    # Media Players and Tools
    moc
    mpv
    yt-dlp
    pamixer
    pavucontrol
    easyeffects

    # Compression Tools
    zip
    unzip
    p7zip
    unrar

    # Utilities
    xdg-utils
    gnome-disk-utility
    gdu

    # Wine
    wineWowPackages.waylandFull

    # Screenshots
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    swappy

    # Wallpaper
    swaybg

    # Brightness Control
    wluma
    brightnessctl

    # Gaming
    radeontop
    gamemode
    gamescope
    prismlauncher
    optifine
    mangohud
    goverlay
    heroic
    lutris
    protonup-qt
    vkbasalt
    protontricks

    # Xorg Tools
    xdotool
    xorg.xprop
    unixtools.xxd
    xorg.xwininfo
    yad
  ];

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
