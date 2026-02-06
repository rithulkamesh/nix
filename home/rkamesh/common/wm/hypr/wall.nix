{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Disable hyprpaper service (using swww instead for better performance)
  services.hyprpaper.enable = false;

  # swww is configured in hyprland.nix exec-once for better performance
  # swww is significantly faster with multiple 4K displays, especially on NVIDIA
}
