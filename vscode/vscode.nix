{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = true;
    enableExtensionUpdateCheck = true;
    extensions = with pkgs.vscode-extensions; [
      github.copilot
      ms-python.vscode-pylance
      catppuccin.catppuccin-vsc
      grapecity.gc-excelviewer
      jnoortheen.nix-ide
      vscodevim.vim
    ];
    mutableExtensionsDir = false;
  };
}

