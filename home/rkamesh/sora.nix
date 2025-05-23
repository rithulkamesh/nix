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
    # ./common/wm/hyprland.nix
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
      anki
      ollama
      gdb
      pavucontrol
      obs-studio

      # Emacs
      ripgrep
      fd
      shellcheck
      pandoc
      libreoffice-qt6-fresh

      (pkgs.unityhub.override {
        extraPkgs = fhsPkgs: [
          fhsPkgs.harfbuzz
          fhsPkgs.libogg
        ];
      })
    ];
  };
}
