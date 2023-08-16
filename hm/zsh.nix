{pkgs, lib, ...}:
{
  #ZSH
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];
    # antidote = {
    #   enable = true;
    #   useFriendlyNames = true;
    #   plugins = [
    #     "romkatv/powerlevel10k"
    #   ];
    # };
    #initExtra = "[[ ! -f ~/.p10k.zsh ]] || source /etc/nixos/hm/p10k.zsh";

  };
}
