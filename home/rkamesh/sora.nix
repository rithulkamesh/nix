{ pkgs, ... }:

{
  imports = [
    ./common/core/ghostty.nix
    ./common/core/zsh.nix
    ./common/optional/zathura.nix
  ];
}
