{pkgs, lib, ...}:
{
  #ZSH
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    shellAliases = {
        doom = "/home/desktop/.config/emacs/bin/doom";
        emacs = "emacsclient -c -a 'emacs'";
        sysupdate = "sudo nixos-rebuild switch --flake /home/desktop/Documents/nix-configuration#desktop --show-trace";
        v4l2loopback-ctl0 = "nix-shell -p linuxKernel.packages.linux_zen.v4l2loopback --run 'v4l2loopback-ctl set-caps /dev/video0 \"YU12:1280x720\" && sudo v4l2loopback-ctl set-fps /dev/video0 60'";
        v4l2loopback-ctl1 = "nix-shell -p linuxKernel.packages.linux_zen.v4l2loopback --run 'v4l2loopback-ctl set-caps /dev/video1 \"YU12:1280x720\" && sudo v4l2loopback-ctl set-fps /dev/video1 60'";
    };
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
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.7.0";
          sha256 = "149zh2rm59blr2q458a5irkfh82y3dwdich60s9670kl3cl5h2m1";
        };
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
