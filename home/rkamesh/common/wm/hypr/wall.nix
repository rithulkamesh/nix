{
  config,
  lib,
  packages,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;
      preload = [
        "~/Pictures/tyn-wall.png"
      ];

      wallpaper = [
        ",~/Pictures/tyn-wall.png"
      ];
    };
  };
}
