{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  services.xserver = {
    windowManager.bspwm.enable = true;
    windowManager.default = "bspwm";
    windowManager.bspwm.configFile = "/home/rkamesh/.config/bspwm/bspwmrc";
    windowManager.bspwm.sxhkd.configFile = "/home/rkamesh/.config/bspwm/sxhkdrc";
    desktopManager.xterm.enable = false;

    displayManager.lightdm = {
      autoLogin.enable = true;
      autoLogin.user = "rkamesh";
    };
  };

  services.xrdp.defaultWindowManager = "bspwm";
}
