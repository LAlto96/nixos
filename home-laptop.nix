{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "laptop";
  home.homeDirectory = "/home/laptop";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [        
    mesa
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

  imports = [
    ./vscode/vscode.nix
    ./wm/wm.nix
  ];

  # home. file {
  #   ".config/inkscape" = {
  #     source = ./inkscape;
  #     recursive = true;
  #   };
  # };


  #ZSH
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    antidote = {
      enable = true;
      useFriendlyNames = true;
      plugins = [
        "romkatv/powerlevel10k"
      ];
    };
    initExtra = "[[ ! -f ~/.p10k.zsh ]] || source /etc/nixos/p10k.zsh";
    # oh-my-zsh = {
    #   enable = true;
    # };
  };
  
  

}

