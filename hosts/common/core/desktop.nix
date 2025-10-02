# This module configures desktop environments.
{
  lib,
  pkgs,
  ...
}:
{
  #
  # GNOME Desktop Environment Configuration
  #
  # This section enables GNOME with the following features:
  # - X11 server with US keyboard layout
  # - Remaps Caps Lock key to function as a Control key
  # - LightDM as the display manager
  # - Latest GNOME as the desktop environment
  # - Wayland session support
  #
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
}
