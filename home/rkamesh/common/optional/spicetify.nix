{
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system}.extensions; [
      shuffle
    ];

    theme = {
      name = "Gruvify";
      src = pkgs.fetchFromGitHub {
        owner = "Skaytacium";
        repo = "Gruvify";
        rev = "main";
        sha256 = "sha256-XMW6bkpMtci7dSz94SGkX03YSEMfxBX9+eltnOfsiDs=";
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
