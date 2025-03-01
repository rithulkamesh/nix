# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').
{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    (self: super: {
      qt5 = super.qt5;
      libsForQt5 = super.libsForQt5;
    })
  ];

  imports = [
    ./hardware-configuration.nix
    ../common/core
    ./graphics.nix
  ];

  # Kernel packages
  boot.kernelPackages = pkgs.linuxPackages;

  # Boot loader configuration
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };

  ###########################################
  # Networking
  ###########################################

  networking = {
    hostName = "sora";
    networkmanager.enable = true;
  };

  ###########################################
  # User Configuration
  ###########################################

  users.users.rkamesh = {
    isNormalUser = true;
    description = "Rithul Kamesh";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      obsidian

      neofetch
      discord
      spotify
      eza
      zoxide
      bun
      pyenv
      direnv
      zathura
      gh
      insomnia
      firefox
      wl-clipboard-rs
    ];
  };

  ###########################################
  # System Programs and Packages
  ###########################################

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Font configuration
  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      pkgs.nerd-fonts.fira-code
    ];
    fontconfig.enable = true;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    # Basic utilities
    (neovim.override {
      extraMakeWrapperArgs = ''--prefix PATH : "${
        lib.makeBinPath [
          pkgs.gcc
          pkgs.gnumake
        ]
      }"'';
    })
    wget
    git
    zip
    unzip
    fzf
    libsForQt5.qt5.qtwayland
    qt5.qtbase

    (vivaldi.override {
      commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
    })

    # Development tools
    gnupg
    pinentry-curses

    # Programming languages and build tools
    gcc
    clang
    cmake
    gnumake
    go
    rustup
    vscode
    python312
    python312Packages.pip
    uv
    nodejs_20

    # Graphics and CUDA
    cudatoolkit
    linuxPackages.nvidia_x11
    libGLU
    libGL
    xorg.libX11
    xorg.libXi
    xorg.libXmu

    # System tools
    pkg-config
    nixfmt-rfc-style
    home-manager
    os-prober

    # Gaming
    vulkan-tools
    lutris
  ];

  ###########################################
  # System Services
  ###########################################

  # Enable printing support
  services.printing.enable = true;
  # Smart card support
  services.pcscd.enable = true;

  # GPG agent configuration
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Library path configuration
  environment.shellInit = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.fzf ]}:$LD_LIBRARY_PATH"
  '';

  # SSH server
  services.openssh.enable = true;

  system.stateVersion = "24.11";
}
