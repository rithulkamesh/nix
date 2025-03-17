# graphics.nix
#
# This module configures graphics hardware support with a focus on NVIDIA GPU configuration.
# It sets up the NVIDIA drivers and configures hybrid graphics (NVIDIA + AMD) with PRIME sync.
{
  config,
  lib,
  pkgs,
  ...
}: {
  ###########################################
  # Boot and Hardware Configuration
  ###########################################

  # Enable hardware graphics support
  hardware.graphics.enable = true;

  # NVIDIA driver configuration
  services.xserver.videoDrivers = ["nvidia"];
  services.xserver.displayManager.lightdm.enable = true;
  hardware.nvidia = {
    # Enable kernel modesetting for better Wayland compatibility
    modesetting.enable = true;

    # Enable power management features
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    # Use the proprietary drivers instead of open source ones
    open = false;

    # Enable the NVIDIA settings panel
    nvidiaSettings = true;

    # PRIME configuration for hybrid graphics (NVIDIA + AMD)
    prime = {
      offload.enable = true;
      # Enable PRIME sync for tear-free rendering
      sync.enable = false;

      # PCI bus IDs for the NVIDIA and AMD GPUs
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:66:0:0";
    };

    # Use the stable NVIDIA driver package that matches the current kernel
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    forceFullCompositionPipeline = true;
  };

  # Improve GNOME performance
  services.xserver.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=[]
    '';
  };

  # Optimize memory usage
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
}
