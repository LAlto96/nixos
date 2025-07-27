{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "laptop";
  home.homeDirectory = "/home/laptop";
  nixpkgs.config.allowUnfree = true;
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # mesa
    moonlight-qt
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Add neovim configuration
  home.file.".config/nvim/lua/coc.lua".source = ./hm/nvim-config/coc.lua;
  home.file.".config/btop/themes/catppuccin_latte.theme".source =
    ./hm/btop/themes/catppuccin_latte.theme;
  home.file.".config/btop/themes/catppuccin_mocha.theme".source =
    ./hm/btop/themes/catppuccin_mocha.theme;
  home.file.".config/YouTube Music/config.json".source = ./hm/youtube-config/config.json;
  home.file.".config/YouTube Music/latte.css".source = ./hm/youtube-config/latte.css;
  home.file.".config/hyprpanel/config.json".source = ./hm/hyprpanel/config-laptop.json;
  home.file.".config/hyprpanel/modules.json".source = ./hm/hyprpanel/modules.json;
  home.file.".config/hyprpanel/modules.scss".source = ./hm/hyprpanel/modules.scss;
  home.file.".config/hypr/hypridle.conf".source = ./hypridle.conf;
  home.file.".config/hypr/hyprlock.conf".source = ./hm/hyprlock/hyprlock.conf;
  home.file.".config/hypr/catppuccin_hyprlock_background_sapphire.jpg".source =
    ./hm/hyprlock/catppuccin_hyprlock_background_sapphire.jpg;
  home.file.".config/hypr/latte.conf".source = ./hm/hyprlock/latte.conf;
  home.file.".config/doom/init.el".source = ./hm/doom/init.el;
  home.file.".config/doom/config.el".source = ./hm/doom/config.el;
  home.file.".config/doom/packages.el".source = ./hm/doom/packages.el;
  programs.git = {
    enable = true;
    userName = "Alto";
    userEmail = "lafon.ludovic.ll@proton.me";
  };

  imports = [
    ./hm/vscode.nix
    ./hm/zsh.nix
    ./hm/neovim.nix
    ./wm-laptop/wm.nix
  ];
  services.syncthing.enable = true;
  programs.zsh.shellAliases = {
    ac = "sudo tlp ac";
    bat = "sudo tlp start";
  };
}
