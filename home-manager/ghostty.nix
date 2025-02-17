{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghostty
  ];

  home.file.".config/ghostty/config" = {
    text = ''
      palette = 0=#45475a
      palette = 1=#f38ba8
      palette = 2=#a6e3a1
      palette = 3=#f9e2af
      palette = 4=#89b4fa
      palette = 5=#f5c2e7
      palette = 6=#94e2d5
      palette = 7=#bac2de
      palette = 8=#585b70
      palette = 9=#f38ba8
      palette = 10=#a6e3a1
      palette = 11=#f9e2af
      palette = 12=#89b4fa
      palette = 13=#f5c2e7
      palette = 14=#94e2d5
      palette = 15=#a6adc8
      background = 1e1e2e
      foreground = cdd6f4
      cursor-color = f5e0dc
      selection-background = 353749
      selection-foreground = cdd6f4

      shell-integration = zsh
      theme = catppuccin-mocha

      font-family = "JetBrains Mono"
      font-size = 11

      background-opacity = 0.9
      window-decoration = false
      background-blur-radius = 35
      title = "👻"
    '';
  };
}
