{ config, pkgs, lib, ... }:
{
  imports = [ ../wm-common/wm.nix ];

  wmCommon = {
    hyprlandConfig = ./hyprland.conf;
    rofiTheme = ./rofi/catppuccin-latte.rasi;
    rofiFont = "JetBrainsMono NF";
    kittyFontName = "JetBrainsMono NF";
    kittyFontSize = 13;
    disableStylixRofi = true;
  };
}
