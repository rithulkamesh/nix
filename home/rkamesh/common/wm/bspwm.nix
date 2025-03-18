{
  config,
  lib,
  pkgs,
  ...
}:

{
  ##############################
  # BSPWM Configuration
  ##############################
  xsession.windowManager.bspwm = {
    enable = true;
    settings = {
      border_width = 2;
      window_gap = 12;
      split_ratio = 0.52;
      borderless_monocle = true;
      gapless_monocle = true;
      focus_follows_pointer = true;
    };
    startupPrograms = [
      "sxhkd"
      "polybar"
    ];
    rules = {
      "Vivaldi" = {
        desktop = "^2";
      };
    };
  };

  ##############################
  # SXHKD Keybindings
  ##############################
  services.sxhkd = {
    enable = true;
    keybindings = {
      # Launch terminal (change "alacritty" to your preferred terminal)
      "super + Return" = "alacritty";

      # Program launcher
      "super + space" = "rofi -show drun";

      # Reload sxhkd configuration
      "super + Escape" = "pkill -USR1 -x sxhkd";

      # Quit/restart bspwm
      "super + alt + {q,r}" = "bspc {quit,wm -r}";

      # Close window
      "super + w" = "bspc node -c";

      # Focus windows in a direction
      "super + {h,j,k,l}" = "bspc node -f {west,south,north,east}";
      "super + shift + {h,j,k,l}" = "bspc node -s {west,south,north,east}";

      # Switch to workspace n with $mod+n (n = 1-9)
      "super + {1-9}" = "bspc desktop -f '^{}'";
      # Move window to workspace n with $mod+shift+n
      "super + shift + {1-9}" = "bspc node -d '^{}'";
    };
  };

  ##############################
  # Package Installation
  ##############################
  home.packages = with pkgs; [
    polybar
    rofi
    alacritty
    feh # For setting wallpaper
    dunst # Notification daemon
    picom # Compositor (transparency, shadows, etc.)
  ];

  ##############################
  # Polybar Configuration with Catppuccin Mocha Colors
  ##############################
  # Catppuccin Mocha palette (excerpt):
  #   - Base:      #1e1e2e
  #   - Text:      #cdd6f4  (used as default foreground)
  #   - Pink:      #f5c2e7  (active workspace)
  #   - Blue:      #89b4fa  (occupied workspace)
  home.file.".config/polybar/config".text = ''
    [bar/i3bar]
    width = 100%
    height = 30
    bottom = true
    background = "#1e1e2e"    ; # Catppuccin Mocha base
    foreground = "#cdd6f4"    ; # Default text color
    font-0 = "monospace:size=10"

    modules-left = xworkspaces
    modules-center = date
    modules-right = battery

    [module/xworkspaces]
    type = internal/xworkspaces
    format = <label>
    ; Workspace labels using Catppuccin Mocha colors:
    label-active = "%{F#f5c2e7}%name%%{F-}"    ; Active: pink
    label-occupied = "%{F#89b4fa}%name%%{F-}"   ; Occupied: blue
    label-empty = "%{F#cdd6f4}%name%%{F-}"      ; Empty: default foreground

    [module/date]
    type = internal/date
    date = "%a %b %d, %Y %H:%M"

    [module/battery]
    type = internal/battery
    adapter = "BAT0"
    full-at = 98
    format = "<ramp> <percentage>%"
  '';
}
