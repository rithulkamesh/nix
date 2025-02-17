{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  home.username = "rkamesh";
  home.homeDirectory = "/home/rkamesh";

  # Add necessary packages
  home.packages = with pkgs; [
    eza
    zoxide
    bun
    pyenv
    direnv
    zathura
    gh
  ];

  imports = [
    ./shell.nix
    ./zathura.nix
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
