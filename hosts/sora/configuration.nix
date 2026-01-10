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
  imports = [
    ./graphics.nix
    ./hardware-configuration.nix
    ../common/core
  ];

  nixpkgs.overlays = [ ];

  virtualisation.docker.enable = true;

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
      default = "saved";
    };
  };

  ###########################################
  # Networking
  ###########################################

  networking = {
    hostName = "sora";
    networkmanager = {
      enable = true;
      # Enable WiFi password storage and automatic connection
      wifi.backend = "wpa_supplicant";
      plugins = [
        pkgs.networkmanager-strongswan
      ];
    };
    firewall = {
      allowedUDPPorts = [
        5353
        427
      ]; # 5353 = mDNS, 427 = SLP
      allowedTCPPorts = [
        5353
        427
      ];
    };
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
      "docker"
      "dialout"
      "input"
      "audio"
      "lp"
      "scanner"
      "wireshark"
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
      wl-clipboard-rs
      mu
      opencl-headers
      cudaPackages.cuda_opencl
      isync
      pkg-config
    ];
  };

  ###########################################
  # System Programs and Packages
  ###########################################

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.udev.packages = with pkgs; [ platformio-core.udev ];

  nix.settings.trusted-users = [
    "root"
    "rkamesh"
  ];

  services.tlp = {
  enable = true;
   settings = {
     CPU_MAX_PER_ON_BAT = 60; # Limit CPU to 60% on battery
   };
};

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
    killall
    git
    zip
    unzip
    fzf
    libsForQt5.qt5.qtwayland
    qt5.qtbase
    vivaldi
    vlc
    hplip

    # Development tools
    gnupg
    lsof

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
    texliveFull
    ffmpeg-full

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

    # Hardware Dev
    kicad
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
    pinentryPackage = pkgs.pinentry-qt;
  };
  programs.nix-ld.enable = true;

  # Library path configuration
  environment.shellInit = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.fzf ]}:$LD_LIBRARY_PATH"
  '';

  # SSH server
  services.openssh.enable = true;

  system.stateVersion = "24.11";
}
