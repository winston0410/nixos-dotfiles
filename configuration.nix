# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  boot.tmp.cleanOnBoot = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  hardware.graphics = { enable = true; };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;
    modesetting.enable = true;
    powerManagement.finegrained = false;
    open = true;
  };
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = with pkgs; [ xterm ];
  programs.dconf.enable = true;
  programs.ssh.enableAskPassword = false;
services.gnome.gnome-keyring.enable = true;
  services.gnome.games.enable = false;
  services.gnome.core-utilities.enable = false;
  services.gnome.gnome-browser-connector.enable = true;
  environment.gnome.excludePackages = (with pkgs; [ gnome-tour gnome-shell-extensions]);
  programs.gnome-terminal.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.sudo.enable = false;
  security.pam.services.gdm-password.enableGnomeKeyring = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  # NOTE after applying the config, you need to create an OpenRGB profile so the setting can be persisted. The OpenRGB profile file is binary, therefore not suitable to be generated with home-manager at the moment
  services.hardware.openrgb.enable = true;
  services.hardware.openrgb.motherboard = "amd";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kghugo = {
    isNormalUser = true;
    description = "kghugo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  services.xserver.displayManager.autoLogin.enable = false;
  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "kghugo";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;

  nixpkgs.config.allowUnfree = true;
  programs.nano.enable = false;
  environment.systemPackages = with pkgs; [
    vim
    git-credential-oauth
    # NOTE to allow all console applications to use system Xserver clipboard
    xclip
  ];
  nix.gc = {
    automatic = true;
    dates = "*-*-* 21:00:00";
    options = "--delete-older-than 7d";
  };
  nix.optimise = {
    automatic = true;
    dates = [ "*-*-* 21:00:00" ];
  };
  programs.git = {
    enable = true;
    config = {
      core = { editor = "vim"; };
      user = {
        name = "unknown";
        email = "johndoe@example.com";
      };
      credential = { helper = [ "cache --timeout 43200" "oauth" ]; };
    };
  };
# NOTE cannot move this to home-manager layer. Revisit this later
programs.kdeconnect = {
  enable = true;
  package = pkgs.gnomeExtensions.gsconnect;
};
 i18n.inputMethod = {
  enable = true;
  type = "ibus";
  ibus.engines = with pkgs; [ ibus-engines.rime ibus-engines.hangul ];
 };

  virtualisation = {
    containers = {
      enable = true;
    };
    podman = {
      enable = true;

      dockerCompat = true;

      defaultNetwork.settings.dns_enabled = true;
    };
  };

  documentation.nixos.enable = false;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
