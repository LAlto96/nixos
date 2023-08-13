{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    coc.enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      nerdtree
      # vim-nerdtree-tabs
      vim-nerdtree-syntax-highlight
      nvim-web-devicons
      vimtex
      coc-vimtex
      copilot-lua
      vim-nix
    ];
  };
}