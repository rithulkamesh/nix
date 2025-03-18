{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ghostty
  ];

  home.file.".config/ghostty/config" = {
    text = ''
      shell-integration = zsh
      theme = tokyonight

      font-family = "JetBrains Mono"
      font-size = 11

      background-opacity = 0.87
      background-blur-radius = 45
      title = "👻"
    '';
  };
}
