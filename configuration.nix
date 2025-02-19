# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  ###########################################
  # Boot and Hardware Configuration
  ###########################################

  # Enable hardware graphics support
  hardware.graphics.enable = true;

  # NVIDIA driver configuration
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:1";
      amdgpuBusId = "PCI:102:0:1";
    };
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

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
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary:
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  ###########################################
  # System Localization
  ###########################################

  # Time zone and hardware clock settings
  time = {
    timeZone = "Asia/Kolkata";
    hardwareClockInLocalTime = true;
  };

  # Locale settings
  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

  ###########################################
  # Desktop Environment
  ###########################################

  # X11 and GNOME configuration
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us";
      variant = "";
      options = "ctrl:nocaps";
    };
  };

  ###########################################
  # Audio Configuration
  ###########################################

  # Disable PulseAudio in favor of PipeWire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # PipeWire configuration
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    # media-session.enable = true;
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
      vivaldi
      neofetch
      discord
      spotify
    ];
  };

  ###########################################
  # System Programs and Packages
  ###########################################

  # Default shell configuration
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Font configuration
  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
    fontconfig.enable = true;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    # Basic utilities
    neovim
    wget
    git
    zip
    fzf

    # Development tools
    gnupg
    pinentry-curses
    zsh

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

  # ASUS-specific services
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  # ROG laptop specific configuration
  programs.rog-control-center = {
    enable = true;
    autoStart = true;
  };
  services.supergfxd.enable = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11";
}
