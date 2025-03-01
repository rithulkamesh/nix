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
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    # Enable kernel modesetting for better Wayland compatibility
    modesetting.enable = true;

    # Enable power management features
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # Use the proprietary drivers instead of open source ones
    open = false;

    # Enable the NVIDIA settings panel
    nvidiaSettings = true;

    # PRIME configuration for hybrid graphics (NVIDIA + AMD)
    prime = {
      # Enable PRIME sync for tear-free rendering
      sync.enable = true;

      # PCI bus IDs for the NVIDIA and AMD GPUs
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:66:0:0";
    };

    # Use the stable NVIDIA driver package that matches the current kernel
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    forceFullCompositionPipeline = false;
  };
}
