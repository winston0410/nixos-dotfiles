{ config, lib, pkgs, ... }:

let
  keybindings = pkgs.writeText "xkb-layout" ''
    !Map Caps_Lock to Alt
    remove lock = Caps_Lock
    keysym Caps_Lock = Alt_L
    add Mod1 = Alt_L
    !Map Super to Control
    remove Mod4 = Super_L
    keysym Super_L = Control_L
    add Control = Control_L
  '';

  initialLight = "sudo light -S 5";

  cursor = with pkgs; bibata-cursors;

  # alt + n
  # xte "key Down"
  # alt + p
  # xte "key Up"

  sxhkdConfig = pkgs.writeText "sxhkd-config" ''
    alt + n
      xdotool key --clearmodifiers "Down"
    alt + p
      xdotool key --clearmodifiers "Up"
  '';
in {
  environment.systemPackages = with pkgs; [
    xdotool
    xorg.xmodmap
    xclip
    # For showing background image in window manager
    feh
    insomnia
    brave
    cursor
    # (callPackage ./eww.nix {})
  ];


  services.xserver = {
    enable = true;
    layout = "us";
    # dpi = 227;
    # Use a lower dpi to 
    dpi = 200;
    resolutions = [{
      x = 2560;
      y = 1600;
    }];
    autoRepeatInterval = 30;
    autoRepeatDelay = 200;
    autorun = true;
    libinput = {
      enable = true;
      mouse = {
        naturalScrolling = true;
        clickMethod = "clickfinger";
        accelSpeed = "1000";
      };
      touchpad = {
        naturalScrolling = true;
        tapping = false;
        clickMethod = "clickfinger";
        accelSpeed = "1000";
      };
    };

    windowManager.leftwm = { enable = true; };

    displayManager = {
      defaultSession = "none+leftwm";
      lightdm = {
        enable = true;
        greeter = { enable = false; };
        autoLogin.timeout = 0;
      };
      autoLogin = {
        enable = true;
        user = "hugosum";
      };
      sessionCommands = ''
        ${initialLight}
        ${pkgs.xorg.xmodmap}/bin/xmodmap ${keybindings}
      '';
        # ${pkgs.fusuma}/bin/fusuma -d -c ${./fusuma/config.yaml}
    };
  };
}
