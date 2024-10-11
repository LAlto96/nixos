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
    # exec-once = swaybg -i /etc/nixos/hm/wallpaper/wall1.png -m fill &
    #exec-once = ~/Documents/.git/eww/target/release/eww daemon
    exec-once = eww open bar
    #exec-once = ~/Documents/.git/eww/target/release/eww open bar2
    exec-once = wl-paste --type text --watch cliphist store #Stores only text data
    exec-once = wl-paste --type image --watch cliphist store #Stores only image data
    bind = SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy

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
        # blur = true
    
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
        new_status = master
    }
    
    gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = false
    }
    
    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
    device {
        name = epic-mouse-v1
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
    bind = $mainMod, T, togglefloating,
    bind = $mainMod, space, exec, rofi -show drun
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, S, togglesplit, # dwindle
    bind = $mainMod, F,fullscreen
    bind = ,print, exec, grimblast --freeze save area - | swappy -f - 
    bind=, XF86AudioRaiseVolume, exec, pamixer -i 5 
    bind=, XF86AudioLowerVolume, exec, pamixer -d 5
    bind =, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bind=,XF86MonBrightnessDown,exec,brightnessctl -q s 5%-
    bind=,XF86MonBrightnessUp,exec,brightnessctl -q s +5%
    
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
    bind = $mainMod SHIFT, ccedilla, movetoworkspace, 9
    bind = $mainMod SHIFT, agrave, movetoworkspace, 10

    # Resize windows with mainMod + SHIFT + vim keys
    binde = $mainMod SHIFT, h, resizeactive, -40 0
    binde = $mainMod SHIFT, l, resizeactive, 40 0
    binde = $mainMod SHIFT, k, resizeactive, 0 -40
    binde = $mainMod SHIFT, j, resizeactive, 0 40

    # Move windows with mainMod + CTRL + vim keys
    bind = $mainMod CTRL, h, movewindow, l
    bind = $mainMod CTRL, l, movewindow, r
    bind = $mainMod CTRL, k, movewindow, u
    bind = $mainMod CTRL, j, movewindow, d

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
    # env = GDK_SCALE,1.95
    # env = XCURSOR_SIZE,16

    '';

  # Rofi Config
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
    # theme = ./rofi/catppuccin-latte.rasi;
    # font = "MesloLGS NF";
  };

  # kitty config
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    # font ={
    #  package = pkgs.meslo-lgs-nf;
    #  name = "MesloLGS NF";
    #  size = 9;
    # };
    # extraConfig = "
    # # font_family MesloLGS NF

    # # vim:ft=kitty

    # ## name:     Catppuccin Kitty Latte
    # ## author:   Catppuccin Org
    # ## license:  MIT
    # ## upstream: https://github.com/catppuccin/kitty/blob/main/themes/latte.conf
    # ## blurb:    Soothing pastel theme for the high-spirited!



    # # The basic colors
    # foreground              #4C4F69
    # background              #EFF1F5
    # selection_foreground    #EFF1F5
    # selection_background    #DC8A78

    # # Cursor colors
    # cursor                  #DC8A78
    # cursor_text_color       #EFF1F5

    # # URL underline color when hovering with mouse
    # url_color               #DC8A78

    # # Kitty window border colors
    # active_border_color     #7287FD
    # inactive_border_color   #9CA0B0
    # bell_border_color       #DF8E1D

    # # OS Window titlebar colors
    # wayland_titlebar_color system
    # macos_titlebar_color system

    # # Tab bar colors
    # active_tab_foreground   #EFF1F5
    # active_tab_background   #8839EF
    # inactive_tab_foreground #4C4F69
    # inactive_tab_background #9CA0B0
    # tab_bar_background      #BCC0CC

    # # Colors for marks (marked text in the terminal)
    # mark1_foreground #EFF1F5
    # mark1_background #7287fD
    # mark2_foreground #EFF1F5
    # mark2_background #8839EF
    # mark3_foreground #EFF1F5
    # mark3_background #209FB5

    # # The 16 terminal colors

    # # black
    # color0 #5C5F77
    # color8 #6C6F85

    # # red
    # color1 #D20F39
    # color9 #D20F39

    # # green
    # color2  #40A02B
    # color10 #40A02B

    # # yellow
    # color3  #DF8E1D
    # color11 #DF8E1D

    # # blue
    # color4  #1E66F5
    # color12 #1E66F5

    # # magenta
    # color5  #EA76CB
    # color13 #EA76CB

    # # cyan
    # color6  #179299
    # color14 #179299

    # # white
    # color7  #ACB0BE
    # color15 #BCC0CC

    # background_opacity 0.85
    # ";
  };

  #eww config
  programs.eww = {
    enable = true;
    package = pkgs.eww;
    configDir = ./eww;
  };
}
