# graphics.nix
#
# This module configures graphics hardware support with a focus on NVIDIA GPU configuration.
# It sets up the NVIDIA drivers and configures hybrid graphics (NVIDIA + AMD) with PRIME sync.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  ###########################################
  # Boot and Hardware Configuration
  ###########################################

  # Enable hardware graphics support
  hardware.graphics.enable = true;

  # NVIDIA driver configuration

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  hardware.nvidia = {

    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;

    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:00:0";
      amdgpuBusId = "PCI:66:00:0";
    };
  };

  # # Improve GNOME performance
  # services.xserver.desktopManager.gnome = {
  #   enable = true;
  #   extraGSettingsOverrides = ''
  #     [org.gnome.mutter]
  #     experimental-features=[]
  #   '';
  # };

  # Optimize memory usage
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
}
