{
  config,
  lib,
  pkgs,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${config.home.homeDirectory}/Pictures/wall.png"
      ];
      splash = false;
      wallpaper = [
        "eDP-1,${config.home.homeDirectory}/Pictures/wall.png"
        "HDMI-A-1,${config.home.homeDirectory}/Pictures/wall.png"
      ];
    };
  };
}
