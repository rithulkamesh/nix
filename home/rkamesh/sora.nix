{ pkgs, ... }:

{
  imports = [
    ./common/core/ghostty.nix
    ./common/core/zsh.nix
    ./common/wm/hyprland.nix
    ./common/optional/zathura.nix
  ];
}
