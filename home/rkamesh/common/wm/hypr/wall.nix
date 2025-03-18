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
        "~/Pictures/wall.png"
      ];

      wallpaper = [
        ",~/Pictures/wall.png"
      ];
    };
  };
}
