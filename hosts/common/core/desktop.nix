# This module configures desktop environments.
{
  lib,
  pkgs,
  ...
}:
{
  services.xserver = {
    xkb = {
      layout = "us";
      options = "ctrl:nocaps";
    };
  };

  #
  # Hyprland Configuration
  #
  # This section configures Hyprland with the following features:
  # - Wayland-based compositor
  # - Hardware acceleration support
  # - Default XDG desktop portal
  #
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "0";
    NIXOS_OZONE_WL = "1";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Polkit for authentication dialogs (needed for NetworkManager to save passwords)
  security.polkit.enable = true;

  # Additional NetworkManager configuration for password storage
  services.dbus.packages = [ pkgs.networkmanager ];

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
