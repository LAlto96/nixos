{ config, pkgs, ... }:

{
  # Hyprland Config
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = ''
    # This is an example Hyprland config file.
    #
    # Refer to the wiki for more information.

    #
    # Please note not all available settings / options are set here.
    # For a full list, see the wiki
    #
    
    # See https://wiki.hyprland.org/Configuring/Monitors/
    monitor=eDP-1,1920x1080@60,auto,auto
    exec-once = swaybg -i ~/Pictures/wall1.png -m fill &
    #exec-once = ~/Documents/.git/eww/target/release/eww daemon
    exec-once = eww open bar
    #exec-once = ~/Documents/.git/eww/target/release/eww open bar2
    
    # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    
    # Execute your favorite apps at launch
    # exec-once = waybar & hyprpaper & firefox
    
    # Source a file (multi-file configs)
    # source = ~/.config/hypr/myColors.conf
    
    # Some default env vars.
    env = XCURSOR_SIZE,24
    
    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = fr
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =
    
        follow_mouse = 1
    
        touchpad {
            natural_scroll = false
        }
    
        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        numlock_by_default = true
    }
    
    general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
    
        gaps_in = 5
        gaps_out = 5
        border_size = 2
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)
    
        layout = dwindle
    }
    
    decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
    
        rounding = 10
        blur = true
        blur_size = 3
        blur_passes = 1
        blur_new_optimizations = true
    
        drop_shadow = true
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
    }
    
    animations {
        enabled = true
    
        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
    
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    
        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
    }
    
    dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true # you probably want this
    }
    
    master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true
    }
    
    gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = false
    }
    
    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
    device:epic-mouse-v1 {
        sensitivity = -0.5
    }
    
    # Example windowrule v1
    # windowrule = float, ^(kitty)$
    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
    
    
    # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    $mainMod = SUPER
    
    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    bind = $mainMod, Return, exec, kitty
    bind = $mainMod, Z, killactive,
    #bind = $mainMod, Z, exit,
    #bind = $mainMod, E, exec, dolphin
    bind = $mainMod, F, togglefloating,
    bind = $mainMod, space, exec, rofi -show drun
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, S, togglesplit, # dwindle
    bind = $mainMod SHIFT, F,fullscreen
    bind = ,print, exec, grim -g "$(slurp)" - | swappy -f - 
    bind=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
    bindl=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    
    # Move focus with mainMod + arrow keys
    bind = $mainMod, H, movefocus, l
    bind = $mainMod, L, movefocus, r
    bind = $mainMod, K, movefocus, u
    bind = $mainMod, J, movefocus, d
    
    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, ampersand, workspace, 1
    bind = $mainMod, eacute, workspace, 2
    bind = $mainMod, quotedbl, workspace, 3
    bind = $mainMod, apostrophe, workspace, 4
    bind = $mainMod, parenleft, workspace, 5
    bind = $mainMod, minus, workspace, 6
    bind = $mainMod, egrave, workspace, 7
    bind = $mainMod, underscore, workspace, 8
    bind = $mainMod, ccedilla, workspace, 9
    bind = $mainMod, agrave, workspace, 10
    
    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, ampersand, movetoworkspace, 1
    bind = $mainMod SHIFT, eacute, movetoworkspace, 2
    bind = $mainMod SHIFT, quotedbl, movetoworkspace, 3
    bind = $mainMod SHIFT, apostrophe, movetoworkspace, 4
    bind = $mainMod SHIFT, parenleft, movetoworkspace, 5
    bind = $mainMod SHIFT, minus, movetoworkspace, 6
    bind = $mainMod SHIFT, egrave, movetoworkspace, 7
    bind = $mainMod SHIFT, underscore, movetoworkspace, 8
    bind = $mainMod SHIFT, ccdedilla, movetoworkspace, 9
    bind = $mainMod SHIFT, agrave, movetoworkspace, 10
    
    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1
    
    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
    
    # Binds Workspace To Monitors
    workspace=1,monitor:eDP-1,default:true
    workspace=2,monitor:eDP-1
    workspace=3,monitor:eDP-1
    workspace=4,monitor:eDP-1
    workspace=5,monitor:eDP-1
    workspace=6,monitor:eDP-1
    workspace=7,monitor:eDP-1
    workspace=8,monitor:eDP-1	
    workspace=9,monitor:eDP-1
    workspace=10,monitor:eDP-1

    # unscale XWayland
    xwayland {
      force_zero_scaling = true
    }
    # toolkit-specific scale
    env = GDK_SCALE,1.2
    env = XCURSOR_SIZE,32
    '';

  # Rofi Config
  programs.rofi = {
    enable = true;
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
    theme = ./rofi/catppuccin-latte.rasi;
    font = "MesloLGS NF";
  };

  # kitty config
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    font ={
     package = pkgs.meslo-lgs-nf;
     name = "MesloLGS NF";
     size = 10;
    };
    extraConfig = "
    # font_family MesloLGS NF

    # vim:ft=kitty
    
    ## name:     Catppuccin Kitty Mocha
    ## author:   Catppuccin Org
    ## license:  MIT
    ## upstream: https://github.com/catppuccin/kitty/blob/main/mocha.conf
    ## blurb:    Soothing pastel theme for the high-spirited!
    
    
    
    # The basic colors
    foreground              #CDD6F4
    background              #1E1E2E
    selection_foreground    #1E1E2E
    selection_background    #F5E0DC
    
    # Cursor colors
    cursor                  #F5E0DC
    cursor_text_color       #1E1E2E
    
    # URL underline color when hovering with mouse
    url_color               #F5E0DC
    
    # Kitty window border colors
    active_border_color     #B4BEFE
    inactive_border_color   #6C7086
    bell_border_color       #F9E2AF
    
    # OS Window titlebar colors
    wayland_titlebar_color system
    macos_titlebar_color system
    
    # Tab bar colors
    active_tab_foreground   #11111B
    active_tab_background   #CBA6F7
    inactive_tab_foreground #CDD6F4
    inactive_tab_background #181825
    tab_bar_background      #11111B
    
    # Colors for marks (marked text in the terminal)
    mark1_foreground #1E1E2E
    mark1_background #B4BEFE
    mark2_foreground #1E1E2E
    mark2_background #CBA6F7
    mark3_foreground #1E1E2E
    mark3_background #74C7EC
    
    # The 16 terminal colors
    
    # black
    color0 #45475A
    color8 #585B70
    
    # red
    color1 #F38BA8
    color9 #F38BA8
    
    # green
    color2  #A6E3A1
    color10 #A6E3A1
    
    # yellow
    color3  #F9E2AF
    color11 #F9E2AF
    
    # blue
    color4  #89B4FA
    color12 #89B4FA
    
    # magenta
    color5  #F5C2E7
    color13 #F5C2E7
    
    # cyan
    color6  #94E2D5
    color14 #94E2D5
    
    # white
    color7  #BAC2DE
    color15 #A6ADC8
    
    background_opacity 0.95
    ";
  };

  #eww config
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww;
  };
}