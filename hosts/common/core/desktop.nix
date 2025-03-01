# This module configures the latest GNOME desktop environment.
#
# It enables:
# - X11 server with US keyboard layout
# - Remaps Caps Lock key to function as a Control key
# - GDM as the display manager
# - Latest GNOME as the desktop environment
# - Wayland session support
# This is part of the core system configuration and should be
# included in systems that require a graphical desktop environment.
{ ... }:
{

  services.xserver = {
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    enable = true;
    xkb = {
      layout = "us";
      options = "ctrl:nocaps";
    };
  };

  # Enable common GNOME services
  services.gnome.core-utilities.enable = true;

  # Enable GNOME keyring service
  security.pam.services.gdm.enableGnomeKeyring = true;
}
