{ config, pkgs, ... }:

{
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

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "brave";
    XCURSOR_SIZE = "60";
    XCURSOR_THEME = "Bibata_Ice";
  };

  environment.shellAliases = {
    sudo = "sudo ";
    sudoedit = "sudo -E -s $EDITOR";
    sudoe = "sudo -E -s $EDITOR";
    ls = "lsd -a ";
    rm = "rip";
    vim = "nvim";
    vi = "nvim";
    grep = "rg";
    top = "btm";
    ps = "procs";
    cp = "xcp -r ";
    dotfiles = "$(which git) --git-dir=$HOME/.dotfiles/ --work-tree=$HOME";
  };

  environment.shells = with pkgs; [ fish zsh ];

  fonts = { fonts = with pkgs; [ nerdfonts ]; };

  hardware.trackpoint = {
    enable = true;
    speed = 250;
  };

  hardware.bluetooth = { enable = true; };

  hardware.video = { hidpi = { enable = true; }; };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [ intel-ocl ];
  };

  services.blueman = { enable = false; };

  programs.light = { enable = true; };

  services.actkbd = {
    enable = true;
    # Bind key for controlling screen brightness
    bindings = [
      {
        keys = [ 224 ];
        events = [ "key" "rep" ];
        command = "/run/current-system/sw/bin/light -U 2";
      }
      {
        keys = [ 225 ];
        events = [ "key" "rep" ];
        command = "/run/current-system/sw/bin/light -A 2";
      }
      # Mute button
      # { keys = [ 113 ]; events = [ "key" "rep" ]; command = ""; }
      # Volume down
      # { keys = [ 114 ]; events = [ "key" "rep" ]; command = ""; }
      # Volume up
      # { keys = [ 115 ]; events = [ "key" "rep" ]; command = ""; }
    ];
  };

  services.printing = { enable = true; };

  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    tcp.enable = true;
  };

  users = {
    # Setting this to true temporaily to prevent being locked out from the system
    mutableUsers = false;
    groups = { docker = { }; };
    users.hugosum = {
      isNormalUser = true;
      home = "/home/hugosum";
      extraGroups = [ "wheel" "networkmanager" "docker" "input" ];
      hashedPassword =
        "$6$pHSJA2UTMz$Z5IS7T6E67bshhmPfcAQRRKgbEuOelR23SiB5Os0YqUqX.oDl5P/nhnKbSAYmiU1mHn01tJ90HD11dYQpg1iN0";
    };
  };

  environment.systemPackages = with pkgs; [
    home-manager
    # utilities
    bintools-unwrapped
    bandwhich
    dua
    xcp
    procs
    bottom
    pciutils
    light
    # Essential c compiler
    gcc
    # Essential development
    tmux
    tmuxp
    neovim
    nodejs-16_x
    git
    bat
    fzf
    fd
    ripgrep
    rm-improved
    wezterm
    # shell
    zsh
    # Linters, formatter and LSP
    stylua
    dhall
    metals
    cmake-language-server
    rust-analyzer
    checkmake
    nixfmt
    gopls
    golint
    goimports
    hadolint
    shellcheck
    rnix-lsp
    ccls
    haskell-language-server
    python39Packages.black
    python39Packages.flake8
    python39Packages.yamllint
    cpplint
    rustfmt
    clippy
    beamPackages.elixir_ls
    nodePackages.eslint_d
    nodePackages.purescript-language-server
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.yaml-language-server
    nodePackages.vls
    nodePackages.vim-language-server
    nodePackages.typescript-language-server
    nodePackages.pyright
    nodePackages.svelte-language-server
    nodePackages.svelte-check
    # nodePackages.vscode-langservers-extracted
    # nodePackages.elm-format
    # nodePackages.graphql-language-service-cli
    # #     nodePackages.prettier
    # nodePackages."@angular/language-server"
    # nodePackages."@prisma/language-server"
    # nodePackages.npm-package-json-lint
    # nodePackages.prettier_d_slim
    # nodePackages."@prettier/plugin-pug"
    # nodePackages."@prettier/plugin-xml"
    # nodePackages.prettier-plugin-svelte
    # nodePackages.prettier-plugin-toml
    nodePackages.purty
    ktlint
    # nodePackages.rustywind
    nodePackages.jsonlint
    nodePackages.fixjson

    haskellPackages.hindent
    haskellPackages.dhall-lsp-server
    sumneko-lua-language-server
    (buildGoModule rec {
      pname = "sqls";
      version = "0.2.18";
      src = fetchFromGitHub {
        owner = "lighttiger2505";
        repo = "sqls";
        rev = "v${version}";
        sha256 = "13837v27avdp2nls3vyy7ml12nj7rxragchwf92adn10ffp4aj6c";
      };
      vendorSha256 = "1rrnvvpx07q49kshib413b5y5l3icb3na4vmccb4arf5awck14db";
    })

    (buildGoModule rec {
      pname = "dockfmt";
      version = "0.3.4";
      src = fetchFromGitHub {
        owner = "jessfraz";
        repo = "dockfmt";
        rev = "1455059b8bb53ab4723ef41946c43160583a8333";
        sha256 = "1y3abi1bxn0lfcwjd761lfkjw5algyy2vvmy66z7n4sw8f8bsh60";
      };
      vendorSha256 = null;
    })

    (buildGoModule rec {
      pname = "efm-langserver";
      version = "0.0.31";
      src = fetchFromGitHub {
        owner = "mattn";
        repo = "efm-langserver";
        rev = "v${version}";
        sha256 = "183vm65wb7byijy9i9ng48ky4ajk9czlz5zsfk4sg5igdkwl7mz0";
      };
      vendorSha256 = "1whifjmdl72kkcb22h9b1zadsrc80prrjiyvyba2n5vb4kavximm";
    })
    terraform-ls
    solargraph
  ];

  services.openssh = { enable = true; };

  programs.ssh = { askPassword = ""; };

  system.stateVersion = "21.05";

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };
}
