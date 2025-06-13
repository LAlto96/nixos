{ config, pkgs, lib, ... }:
{
  imports = [ ../wm-common/wm.nix ];

  wmCommon = {
    hyprlandConfig = ./hyprland.conf;
    # Laptop uses defaults for fonts and theme
  };
}
