{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [ ];
    extraPackages = with pkgs; [ ];
  };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
