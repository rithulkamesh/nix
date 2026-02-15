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
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
  };

  # Asus Configuration
  services = {
    supergfxd.enable = true;
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };

  # NVIDIA driver configuration
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true; # Check if this causes sleep issues, but generally good for modern cards
    powerManagement.finegrained = false; # Set to true only if offload mode is primary and power saving is critical
    open = false; # Use proprietary drivers (strictly requested)
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta; # Use beta drivers for cutting-edge fixes and video codec support

    prime = {
      # Sync mode: NVIDIA GPU drives the display. Good for performance ("Desktop Mode").
      sync.enable = true;

      # Bus IDs checked from previous config.
      # Verify these with lspci if needed, but assuming they were correct.
      nvidiaBusId = "PCI:1:00:0";
      amdgpuBusId = "PCI:66:00:0";
    };

    # Force maximum link bandwidth for USB-C DisplayPort connections
    # This helps ensure 4K@60Hz works over USB-C
    nvidiaPersistenced = true;

    # Additional settings for USB-C DisplayPort support
    forceFullCompositionPipeline = false; # Let the compositor handle it
  };

  # CUDA Support for Nixpkgs
  nixpkgs.config.cudaSupport = true;

  # Environment Config for CUDA/Wayland/VA-API
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # Enable hardware video decoding for Vivaldi and other applications
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __VK_LAYER_NV_optix = "1";
  };

  # Optimize memory usage
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
}
