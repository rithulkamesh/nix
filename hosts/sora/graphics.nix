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
  services.xserver.displayManager.gdm.enable = true;

  services.xserver.enable = true;
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
  boot = {
    kernelParams = [
      "nvidia-drm.modeset=1"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
    extraModprobeConfig = ''
      options bbswitch load_state=-1 unload_state=1 nvidia-drm
    '';
    blacklistedKernelModules = [
      "nouveau"
      "rivafb"
      "nvidiafb"
      "rivatv"
      "nv"
      "uvcvideo"
    ];

    # Optimize memory management
    kernel.sysctl = {
      "vm.swappiness" = 10;
    };
  };

  # Additional performance tweaks
  environment.variables = {
    # Force Wayland for certain applications
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";

    # Fix: Use string for path instead of bare path reference
    WLR_DRM_DEVICES = "/dev/dri/card1";

    # Add additional NVIDIA optimizations
    __GL_THREADED_OPTIMIZATIONS = "1";
    __GL_SHADER_DISK_CACHE = "1";
    __GL_SHADER_DISK_CACHE_PATH = "/tmp/nvidia-cache";
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
  };
}
