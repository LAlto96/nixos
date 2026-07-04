{ config, pkgs, pkgs-unstable, lib, ... }:

{
  # Hyprland Config
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    extraConfig = ''
      require("base")
      require("host")
    '';
  };
  xdg.configFile = {
    "hypr/base.lua".source = ../hyprland.base.lua;
    "hypr/host.lua".source = ./hyprland.lua;
  };

  # Rofi Config
  stylix.targets.rofi.enable = false;
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = ./rofi/catppuccin-latte.rasi;
    font = "JetBrainsMono NF";
    extraConfig = {
      modi = "run,drun,window";
      icon-theme = "Oranchelo";
      show-icons = true;
      terminal = "kitty";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 﩯  Window";
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
    };
  };

  # kitty config
  programs.kitty = {
    enable = true;
    package = pkgs-unstable.kitty;
    shellIntegration.enableZshIntegration = true;
    font ={
        name = lib.mkForce "JetBrainsMono NF";
        size = lib.mkForce 13;
    };
  };
}
