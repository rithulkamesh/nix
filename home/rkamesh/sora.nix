{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./common/core/bspwn.nix
    ./common/core/ghostty.nix
    ./common/core/zsh.nix
    # ./common/wm/hyprland.nix
    ./common/optional/zathura.nix
  ];

  home = {
    stateVersion = "24.11";
    username = "rkamesh";
    homeDirectory = "/home/rkamesh";
  };
}
