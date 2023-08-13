{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
      wget
      git
      wirelesstools
      lm_sensors
      ffmpeg_6
      ffmpegthumbnailer
      # nur.repos.rycee.firefox-addons

      
      # Le sang de la veine
      ranger
      poppler_utils # pdf image preview for ranger
      btop
      neofetch
      kitty
      wl-clipboard
      firefox
      # Vivaldi
      vivaldi

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
    ];
}