{ config, pkgs, lib,  ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "desktop";
  home.homeDirectory = "/home/desktop";


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [        
    mesa
    droidcam
    sunshine
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
  home.file."/.config/nvim/lua/coc.lua".source = ./hm/nvim-config/coc.lua;
  home.file."/.config/btop/themes/catppuccin_latte.theme".source = ./hm/btop/themes/catppuccin_latte.theme;
  home.file."/.config/btop/themes/catppuccin_mocha.theme".source = ./hm/btop/themes/catppuccin_mocha.theme;
  home.file.".config/YouTube Music/config.json".source = ./hm/youtube-config/config-desktop.json;
  home.file.".config/YouTube Music/latte.css".source = ./hm/youtube-config/latte.css;
  programs.git = {
    enable = true;
    userName = "Alto";
    userEmail = "lafon.ludovic.ll@proton.me";
  };

  imports = [
    ./hm/vscode.nix
    ./hm/zsh.nix
    ./hm/neovim.nix
    ./wm-desktop/wm.nix
  ];
  services.syncthing.enable = true;
}

