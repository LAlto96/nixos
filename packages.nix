{config, pkgs, inputs, ...}:
{
  programs.java.enable = true;
  environment.systemPackages = with pkgs; [
      # Le sang de la veine
      ranger # File manager
      btop # htop but better
      neofetch # System info
      kitty # Terminal
      firefox # Browser
      discord # Chat
      betterdiscordctl # BetterDiscord
      nzbget # NZB Downloader
      protonvpn-gui # VPN
      obsidian # Notes
      ledger # Finance Management
      ledger-web # Finance Management
      conda # Python
      multiviewer-for-f1 # F1
      moonlight-qt # Nvidia Gamestream

      # Media
      youtube-music # Youtube Music
      mpv # Video Player
      yt-dlp # Youtube Downloader
      pamixer # PulseAudio Mixer
      pavucontrol # PulseAudio Volume Control
      easyeffects # Audio Effects
      davinci-resolve # Video Editor

      # System packages
      wl-clipboard # Clipboard manager
      wget # Download manager
      git # Version control
      wirelesstools # Wireless tools
      lm_sensors # Sensor tools
      ffmpeg_6 # Video tools
      ffmpegthumbnailer # Video thumbnailer
      corefonts # Fonts
      zip # Zip
      unzip # Unzip
      p7zip # 7zip
      xdg-utils # XDG utils
      unrar # Rar
      w3m # Image preview for ranger
      poppler_utils # pdf image preview for ranger
      gnome.gnome-disk-utility # Disk utility
      gdu # Disk usage
      wineWowPackages.waylandFull # Wine
        # Screenshot
        inputs.hyprland-contrib.packages.${pkgs.system}.grimblast # Grim but from Hypr
        swappy # Screenshot
        #Wallpaper
        swaybg # Wallpaper
      
      # Brightness Control
      wluma # Automatic Brightness control
      brightnessctl # Brightness control (hardware)

      # Gaming
      gamemode # Game mode
      gamescope # Game mode
      mangohud # Game mode
      heroic # Epic Games
      lutris # Game manager
      protonup-qt # Proton updater
      protontricks # Proton tricks
      steamPackages.steamcmd
      steam-tui
        # Steam
        (steam.override {
         extraPkgs = pkgs: [ bumblebee glxinfo libkrb5 keyutils ]; 
        }).run
        # Steam Tinker Launch dependencies for protonup-qt
        gawk
        gnumake
        bash
        procps
        xdotool
        xorg.xprop
        xorg.xrandr
        vim
        xorg.xwininfo
        yad

    ];
  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    package = pkgs.steam.override {
    extraPkgs = pkgs: with pkgs; [
      gamescope
    ];
  };
  };
  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override ({ extraPkgs ? pkgs': [], ... }: {
        extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
          libgdiplus
        ]);
      });
    })
  ];
}
