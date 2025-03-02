{
  outputs,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in
{
  nix = {
    package = pkgs.nix;
    settings = {
      #extra-substituters = lib.mkAfter ["https://cache.m7.rs"];
      #extra-trusted-public-keys = ["cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg="];
      experimental-features = [
        "nix-command"
        "flakes"
        #"ca-derivations"
      ];
      warn-dirty = false;
      flake-registry = ""; # Disable global flake registry
    };
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
  };

  home.sessionVariables = {
    NIX_PATH = lib.concatStringsSep ":" (lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs);
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
