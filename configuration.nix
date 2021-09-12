{ config, pkgs, ... }:

{
  boot.kernelPackages = with pkgs; linuxPackages_latest;

  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "ondemand";
    scsiLinkPolicy = "min_power";
  };

  time.timeZone = "Europe/London";

  nixpkgs.config = { allowUnfree = true; };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  networking = {
    useDHCP = false;
    firewall = { enable = false; };
    networkmanager = { enable = true; };
  };

  i18n.defaultLocale = "en_US.UTF-8";

  console = { useXkbConfig = true; };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    binaryCaches = [ "https://cache.nixos.org" ];
    trustedBinaryCaches = [ "http://cache.nixos.org" "http://hydra.nixos.org" ];
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  hardware.trackpoint = {
    enable = true;
    speed = 250;
  };

  hardware.video = { hidpi = { enable = true; }; };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [ intel-ocl ];
  };

  programs.light = { enable = true; };

  users = {
    # Setting this to true temporaily to prevent being locked out from the system
    mutableUsers = false;
    groups = { docker = { }; };
    users.hugosum = {
      isNormalUser = true;
      home = "/home/hugosum";
      extraGroups =
        [ "wheel" "networkmanager" "docker" "input" "video" "audio" "sound" ];
      hashedPassword =
        "$6$pHSJA2UTMz$Z5IS7T6E67bshhmPfcAQRRKgbEuOelR23SiB5Os0YqUqX.oDl5P/nhnKbSAYmiU1mHn01tJ90HD11dYQpg1iN0";
    };
  };

  environment.systemPackages = with pkgs; [ git ];

  system.stateVersion = "21.05";

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };
}
