{ config, lib, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    zoxide
  ];
  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    # autosuggestions = {

    # };
    shellInit = ''
      # Enable zoxide
      eval "$(zoxide init zsh)"
    '';
    promptInit = "";
  };
}
