# This module configures KDE Plasma 6 desktop environment.
#
# It enables:
# - X11 server with US keyboard layout
# - Remaps Caps Lock key to function as a Control key
# - SDDM as the display manager
# - Plasma 6 as the desktop environment
#
# This is part of the core system configuration and should be
# included in systems that require a graphical desktop environment.
{ ... }:
{
  services = {
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        options = "ctrl:nocaps";
      };

    };
  };
}
