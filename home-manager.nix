{ config, lib, pkgs, ... }:

with config.lib;

{
  home.file = {
    #tmux
    ".tmux.conf" = { source = file.mkOutOfStoreSymlink "${config.home.homeDirectory}/flake/.tmux.conf"; };
    #git
    ".gitconfig" = { source = file.mkOutOfStoreSymlink ./.gitconfig; };
    #cursor theme
    ".icons/default" = {
      source = "${pkgs.bibata-cursors}/share/icons/Bibata_Ice";
    };
  };

  xdg.configFile = {
    #neovim
    "nvim/init.lua" = { source = ./nvim/init.lua; };
    "nvim/plugins" = { source = ./nvim/plugins; };
    "nvim/ftplugin" = { source =  ./nvim/ftplugin; };
    "nvim/ftdetect" = { source = ./nvim/ftdetect; };
    #leftwm
    "leftwm/" = { source = ./leftwm; };
    #fusuma
    "fusuma/" = { source = ./fusuma; };
    #wezterm
    "wezterm/" = { source = ./wezterm; };
  };

  systemd = { user.startServices = "sd-switch"; };

  programs.home-manager = { enable = true; };

  programs.lsd = { enable = true; };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    # enableZshIntegraton = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    config = { };
  };

  programs.bat = {
    enable = true;
    config = { };
  };
}
