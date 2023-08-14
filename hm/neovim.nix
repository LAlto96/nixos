{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    # coc.enable = true;
    # defaultEditor = true;
    # plugins = with pkgs.vimPlugins; [
    #   catppuccin-nvim
    #   nerdtree
    #   # vim-nerdtree-tabs
    #   #vim-nerdtree-syntax-highlight
    #   #nvim-web-devicons
    #   #vimtex
    #   #coc-vimtex
    #   #copilot-lua
    #   #vim-nix
    #   # coc-sh
    #   # coc-docker
    #   # coc-css
    #   # coc-yank
    #   # coc-yaml
    #   # coc-json
    #   # coc-vimtex
    #   # coc-highlight
    #   # coc-markdownlint
    #   # coc-nginx
    #   # coc-pyright
    # ];
    # extraConfig =
    #   ''
    #     nnoremap <F4> :NERDTreeToggle<CR>
    #   '';
    # extraLuaConfig =
    #   ''
    #     vim.g.coq_settings = {auto_start = true}
    #     vim.cmd.colorscheme "catppuccin"
    #     require("copilot").setup({})
    #   '';
  };
}
