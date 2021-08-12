{ config, lib, pkgs, ... }:

{
  home.file = {
    #neovim
    ".config/nvim" = {
      source = ./nvim;
    };
    #leftwm
    ".config/leftwm/" = {
      source = ./leftwm;
    };
    #tmux
    ".tmux.conf" = {
      source = ./.tmux.conf;
    };
    #git
    ".gitconfig" = {
      source = ./.gitconfig;
    };
    #cursor theme
    ".icons/default" = {
      source = "${pkgs.bibata-cursors}/share/icons/Bibata_Ice";
    };
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
