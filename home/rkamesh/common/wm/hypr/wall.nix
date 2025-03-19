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
        "~/Pictures/wall_mtn.jpg"
      ];

      wallpaper = [
        ",~/Pictures/wall_mtn.jpg"
      ];
    };
  };
}
