{ config, pkgs, lib, ... }:
let
  cfg = config.wmCommon;
  optionalAttr = lib.optionalAttrs;
  mkIf = lib.mkIf;
  types = lib.types;
in {
  options.wmCommon = {
    hyprlandConfig = lib.mkOption {
      type = types.path;
      description = "Path to hyprland configuration";
    };
    rofiTheme = lib.mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Rofi theme file";
    };
    rofiFont = lib.mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Rofi font";
    };
    kittyFontName = lib.mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Kitty font name";
    };
    kittyFontSize = lib.mkOption {
      type = types.nullOr types.int;
      default = null;
      description = "Kitty font size";
    };
    disableStylixRofi = lib.mkOption {
      type = types.bool;
      default = false;
      description = "Disable stylix target for rofi";
    };
  };

  config = {
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.extraConfig = builtins.readFile cfg.hyprlandConfig;

    stylix.targets.rofi.enable = mkIf cfg.disableStylixRofi false;

    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
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
    } // optionalAttr (cfg.rofiTheme != null) { theme = cfg.rofiTheme; }
      // optionalAttr (cfg.rofiFont != null) { font = cfg.rofiFont; };

    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
    } // optionalAttr (cfg.kittyFontName != null && cfg.kittyFontSize != null) {
      font = {
        name = lib.mkForce cfg.kittyFontName;
        size = lib.mkForce cfg.kittyFontSize;
      };
    };
  };
}
