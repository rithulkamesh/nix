{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./locale.nix
    ./desktop.nix
    ./audio.nix
    ./direnv.nix
  ];

  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=120 # only ask for password every 2h
    # Keep SSH_AUTH_SOCK so that pam_ssh_agent_auth.so can do its magic.
    # Defaults env_keep + =SSH_AUTH_SOCK
  '';

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      warn-dirty = false;
    };
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

}
