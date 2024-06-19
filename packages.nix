{config, pkgs, lib, inputs, ...}:
{
  programs.java.enable = true;
  environment.systemPackages = with pkgs; [

      # Catppuccin GTK Theme
      (catppuccin-gtk.override {
        accents = [ "sapphire" ]; # You can specify multiple accents here to output multiple themes
        size = "compact";
        tweaks = [ "rimless" ]; # You can also specify multiple tweaks here
        variant = "latte";
      })

      ctop # Container monitoring tool
      cliphist # CLipboard manager

      # DAWs
      reaper
      yabridge
      yabridgectl

      # Emacs
      emacs
      emacsPackages.vterm
      coreutils # Coreutils
      ripgrep # Ripgrep
      fd
      clang
      libvterm

      qalculate-gtk # Calculator
      #(pkgs.callPackage ./droidcam.nix {}) # Droidcam
      droidcam
      w3m # Image preview for ranger
      atool
      v4l-utils
      qemu
      drawio
      zathura
      texliveFull #LaTeX


      # Le sang de la veine
      dvc
      gpu-viewer
      helvum
      upscayl
      ranger # File manager
      btop # htop but better
      neofetch # System info
      kitty # Terminal
      # firefox # Browser
      (firefox.override { nativeMessagingHosts = [ inputs.pipewire-screenaudio.packages.${pkgs.system}.default ]; })
      webcord-vencord # Discord
      pandoc
      #discord # Chat
      #betterdiscordctl # BetterDiscord
      nzbget # NZB Downloader
      protonvpn-gui # VPN
      protonvpn-cli
      obsidian # Notes
      ledger # Finance Management
      ledger-web # Finance Management
      conda # Python
      multiviewer-for-f1 # F1
      moonlight-qt # Nvidia Gamestream
      nodejs # Node
      motrix # Downloader
      
      deluged
      xclip


      docker-compose

      # Media
      #youtube-music # Youtube Music
      moc
      mpv # Video Player
      yt-dlp # Youtube Downloader
      pamixer # PulseAudio Mixer
      pavucontrol # PulseAudio Volume Control
      easyeffects # Audio Effects

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
      # retroarchFull # Retroarch
      gamemode # Game mode
      gamescope # Game mode
      prismlauncher
      optifine
      mangohud # Game mode
      heroic # Epic Games
      lutris # Game manager
      protonup-qt # Proton updater
      protontricks # Proton tricks
      steamtinkerlaunch
    ];
  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}
