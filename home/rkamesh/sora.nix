{
  pkgs,
  inputs,
  ...
}: {
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
  };
}
