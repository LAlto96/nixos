{pkgs, inputs, ...}:
{
  programs.java.enable = true;
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
      wget
      git
      wirelesstools
      lm_sensors
      ffmpeg_6
      ffmpegthumbnailer
      corefonts
      zip
      unzip
      p7zip
      xdg-utils
      wineWowPackages.waylandFull
      protontricks
      # nur.repos.rycee.firefox-addons

      
      # Le sang de la veine
      ranger
      poppler_utils # pdf image preview for ranger
      btop
      neofetch
      kitty
      wl-clipboard
      firefox
      discord
      betterdiscordctl
      heroic
      lutris
      protonup-qt
      gnome.gnome-disk-utility
      gamemode
      gamescope
      mangohud
      pavucontrol
      easyeffects
      
      #Wallpaper
      swaybg

      #media
      youtube-music
      mpv
      yt-dlp
      pamixer # PulseAudio Mixer

      # Screenshot
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
      swappy
      
      # Brightness Control
      wluma
      brightnessctl

      # Steam
      (steam.override {
       extraPkgs = pkgs: [ bumblebee glxinfo libkrb5 keyutils ];
      }).run
    ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
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
