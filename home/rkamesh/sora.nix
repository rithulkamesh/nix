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
      spotify

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

      # Secrets / keys
      gnupg

      # QUCS-S (Electronic Sim)
      (qucs-s.overrideAttrs (oldAttrs: {
        # Build qucs-s with Qt6 instead of Qt5
        buildInputs =
          let
            filtered = lib.filter (
              p:
              let
                name = lib.getName p;
              in
              name != "qtbase" && name != "qtsvg" && name != "qtcharts" && !(lib.hasPrefix "qt5" name)
            ) (oldAttrs.buildInputs or [ ]);
          in
          filtered
          ++ [
            pkgs.qt6.qtbase
            pkgs.qt6.qtsvg
            pkgs.qt6.qtcharts
          ];
        nativeBuildInputs =
          let
            filtered = lib.filter (p: lib.getName p != "wrapQtAppsHook") (oldAttrs.nativeBuildInputs or [ ]);
          in
          filtered ++ [ pkgs.qt6.wrapQtAppsHook ];
        cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
          "-DCMAKE_PREFIX_PATH=${pkgs.qt6.qtbase}"
        ];
      }))
    ];
  };
}
