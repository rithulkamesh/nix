{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system}.extensions; [
      shuffle
    ];

    theme = {
      name = "Tokyo";
      colorScheme = "Night";
      src = pkgs.fetchFromGitHub {
        owner = "evening-hs";
        repo = "Spotify-Tokyo-Night-Theme";
        rev = "main";
        sha256 = "sha256-cLj9v8qtHsdV9FfzV2Qf4pWO8AOBXu51U/lUMvdEXAk=";
      };

      injectCss = true;
      injectThemeJs = true;
      replaceColors = true;
      homeConfig = true;
      overwriteAssets = false;
      additionalCss = "";
    };
  };
}
