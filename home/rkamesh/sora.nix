{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    #./common/wm/bspwm.nix
    ./common/core/ghostty.nix
    ./common/core/zsh.nix
    ./common/core/dev.nix # Added dev environment
    ./common/wm/hyprland.nix
    ./common/optional/zathura.nix
    ./common/optional/spicetify.nix
  ];

  home = {
    stateVersion = "24.11";
    username = "rkamesh";
    homeDirectory = "/home/rkamesh";

    # Extra Packages that don't fall under any category
    packages = with pkgs; [
      # GUI Apps
      mongodb-compass
      obs-studio
      pavucontrol
      slack
      vivaldi
      google-chrome
      vlc
      obsidian
      discord

      # Productivity
      zellij
      kanshi
      bitwarden-desktop
      bitwarden-cli

      # Office / Docs
      libreoffice-qt6-fresh
      kdePackages.okular
      pandoc

      # Creative
      blender

      # Misc CLI (that aren't strictly "dev" or are specific to this machine)
      neofetch
      btop
      tree
      wireshark
      isync
      mu

      # Hardware
      asusctl

      # Secretg / keys
      gnupg
    ];
  };
}
