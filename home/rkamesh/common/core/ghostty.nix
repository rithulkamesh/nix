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
      theme = TokyoNight

      font-family = "JetBrains Mono"
      font-size = 11

      window-padding-x = 10
      window-padding-y = 5
      window-padding-balance = true

      background-opacity = 0.97
      background-blur-radius = 45
      title = "👻"
    '';
  };
}
