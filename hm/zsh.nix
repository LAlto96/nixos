{pkgs, ...}:
{
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
    initExtra = "[[ ! -f ~/.p10k.zsh ]] || source /etc/nixos/hm/p10k.zsh";
    # oh-my-zsh = {
    #   enable = true;
    # };
  };
}