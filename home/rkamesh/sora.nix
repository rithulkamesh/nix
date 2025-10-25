{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    #./common/wm/bspwm.nix
    ./common/core/ghostty.nix
    ./common/core/zsh.nix
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
      mongodb-compass
      ollama
      gdb
      pavucontrol
      obs-studio
      bat

      ripgrep
      fd
      shellcheck
      pandoc
      libreoffice-qt6-fresh
      btop
      sqlite
      awscli2
      jq
      tree
      wireshark
      dig

      code-cursor
      asusctl

      slack

      # Productivity tools
      zellij # Terminal multiplexer
      kanshi # Dynamic display configuration

      # Email and Calendar
      thunderbird # Email client with built-in calendar

      # Password Manager and Security
      bitwarden # Password manager with passkey support
      bitwarden-cli # Command line interface

    ];
  };

}
