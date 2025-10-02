{
  pkgs,
  inputs,
  ...
}:
{
  imports = [ ./hypr ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      # Monitor configuration
      monitor = [
        "HDMI-A-1,3840x2160,0x0,1.5" # 4K external monitor on the left
        "eDP-1,preferred,2560x0,1" # Laptop display to the right (2560px = 3840/1.5 scaling)
      ];
      bindl = [
        # When lid is closed, disable internal display
        ",switch:on:Lid Switch,exec,hyprctl keyword monitor eDP-1,disable"
        # When lid is opened, enable internal display
        ",switch:off:Lid Switch,exec,hyprctl keyword monitor eDP-1,preferred,2560x0,1"
      ];
      # Input settings
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
        kb_options = "ctrl:nocaps";
      };

      # General settings
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        layout = "dwindle";
        resize_on_border = true;
        "col.active_border" = "0xffa3e49f 0xff63b2b8 0xff82599c 45deg";
        "col.inactive_border" = "0xff6e738d";
      };

      # Decoration settings
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };
      };

      animations = {
        enabled = true;
        animation = [
          "windows, 1, 7, default"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # XWayland settings for better performance
      xwayland = {
        force_zero_scaling = true;
      };

      # Misc settings for better performance
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        enable_swallow = true;
        swallow_regex = "^(Alacritty|kitty|ghostty)$";
        vfr = true;
      };

      "$mod" = "SUPER";
      bind = [
        # General Volume/Key Binds
        ",XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"

        ",XF86AudioMute, exec, pw-volume mute toggle; pkill -RTMIN+8 waybar"
        ",XF86AudioRaiseVolume, exec, pw-volume change +5%; pkill -RTMIN+8 waybar"
        ",XF86AudioLowerVolume, exec, pw-volume change -5%; pkill -RTMIN+8 waybar"

        # Key based Binds
        "$mod, Return, exec, ghostty"
        "$mod SHIFT, Q, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, dolphin"
        "$mod, V, togglefloating,"
        "$mod, D, exec, rofi -show drun"
        "$mod, P, pseudo,"
        "$mod, J, togglesplit,"

        # Screenshot binds (Windows-like)
        "$mod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy && notify-send \"Screenshot\" \"Area screenshot copied to clipboard\""
        ", Print, exec, grim - | wl-copy && notify-send \"Screenshot\" \"Full screenshot copied to clipboard\""
        "$mod, Print, exec, grim ~/Pictures/screenshot_$(date +%Y%m%d_%H%M%S).png && notify-send \"Screenshot\" \"Saved to ~/Pictures/\""

        # Lock screen
        "$mod, L, exec, hyprlock"

        # Media controls
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        # Additional useful bindings
        "$mod SHIFT, E, exec, wlogout"
        "$mod, B, exec, pkill -SIGUSR1 waybar" # Toggle waybar
        "$mod CTRL, R, exec, hyprctl reload" # Reload config
        "$mod, F, fullscreen"
        "$mod SHIFT, F, exec, hyprctl dispatch workspaceopt allfloat"
        "$mod, C, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy" # Clipboard history

        # Monitor management
        "$mod CTRL, 1, focusmonitor, HDMI-A-1" # Focus external monitor
        "$mod CTRL, 2, focusmonitor, eDP-1" # Focus laptop monitor

        # Pro tip bindings
        "$mod SHIFT, R, exec, wf-recorder -g \"$(slurp)\" -f ~/Videos/recording_$(date +%Y%m%d_%H%M%S).mp4" # Screen recording
        "$mod CTRL, Q, exec, pkill wf-recorder" # Stop recording
        "$mod, T, exec, ghostty -e btop" # System monitor
        "$mod SHIFT, B, exec, blueman-manager" # Bluetooth manager

        # Window management
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        # Resize windows
        "$mod CTRL, left, resizeactive, -20 0"
        "$mod CTRL, right, resizeactive, 20 0"
        "$mod CTRL, up, resizeactive, 0 -20"
        "$mod CTRL, down, resizeactive, 0 20"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      exec-once = [
        "dunst"
        "caa -d"
        "hyprpaper"
        "gnome-keyring-daemon -s"
        "nm-applet --indicator"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
        "wlsunset -S 06:30 -s 19:30"
        "hypridle"
        "blueman-applet"
        "kanshi" # Dynamic display configuration
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "QT_QPA_PLATFORMTHEME,qt6ct"

        # XWayland performance and scaling fixes
        "GDK_BACKEND,wayland,x11"
        "QT_QPA_PLATFORM,wayland;xcb"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XCURSOR_SIZE,24"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

        # NVIDIA specific for better performance
        "WLR_NO_HARDWARE_CURSORS,1"
        "__GL_GSYNC_ALLOWED,0"
        "__GL_VRR_ALLOWED,0"
        "WLR_DRM_NO_ATOMIC,1"
      ];

      # Window rules for better app behavior
      windowrulev2 = [
        # Float specific applications
        "float,class:^(pavucontrol)$"
        "float,class:^(nm-applet)$"
        "float,class:^(blueman-manager)$"
        "float,class:^(wlogout)$"
        "float,title:^(rofi)"

        # Picture-in-picture
        "float,title:^(Picture-in-Picture)$"
        "pin,title:^(Picture-in-Picture)$"
        "move 69% 4%,title:^(Picture-in-Picture)$"
        "size 30% 30%,title:^(Picture-in-Picture)$"

        # Center dialogs
        "center,class:^(gcr-prompter)$"
        "center,class:^(polkit-gnome-authentication-agent-1)$"

        # Workspace assignments
        "workspace 2,class:^(firefox)$"
        "workspace 3,class:^(code|Code)$"
        "workspace 4,class:^(discord|Discord)$"
        "workspace 5,class:^(Spotify|spotify)$"
        "workspace 6,class:^(steam)$"
        "workspace 6,class:^(lutris)$"

        # Gaming optimizations
        "fullscreen,class:^(steam_app_.*)$"
        "workspace 6,class:^(steam_app_.*)$"
        "immediate,class:^(steam_app_.*)$"
        "fullscreen,class:^(gamescope)$"

        # Opacity rules
        "opacity 0.9 0.9,class:^(ghostty)$"
        "opacity 0.95 0.95,class:^(code|Code)$"
        "opacity 1.0 1.0,class:^(steam_app_.*)$"

        # System utilities
        "float,class:^(btop)$"
        "float,class:^(blueman-manager)$"

        # Focus rules
        "suppressevent maximize, class:.*"
      ];
    };
  };

  programs.ghostty = {
    enable = true;
  };

  # Hypridle configuration
  home.file.".config/hypr/hypridle.conf".text = ''
    general {
        lock_cmd = pidof hyprlock || hyprlock
        before_sleep_cmd = loginctl lock-session
        after_sleep_cmd = hyprctl dispatch dpms on
        ignore_dbus_inhibit = false
    }

    listener {
        timeout = 150
        on-timeout = brightnessctl -s set 10
        on-resume = brightnessctl -r
    }

    listener {
        timeout = 300
        on-timeout = loginctl lock-session
    }

    listener {
        timeout = 330
        on-timeout = hyprctl dispatch dpms off
        on-resume = hyprctl dispatch dpms on
    }

    listener {
        timeout = 1800
        on-timeout = systemctl suspend
    }
  '';

  # Kanshi configuration for dynamic display management
  home.file.".config/kanshi/config".text = ''
    # Profile for external monitor + laptop (docked) - current setup
    profile docked {
        output HDMI-A-1 mode 3840x2160@60Hz position 0,0 scale 1.5
        output eDP-1 mode 1920x1080@144Hz position 2560,0 scale 1.0
    }

    # Profile for laptop only (undocked)
    profile laptop {
        output eDP-1 mode 1920x1080@144Hz position 0,0 scale 1.0
    }

    # Profile for external monitor only (lid closed or laptop disabled)
    profile external {
        output HDMI-A-1 mode 3840x2160@60Hz position 0,0 scale 1.5
    }
  '';

  home.packages = with pkgs; [
    # Necessary Utilities
    xfce.thunar
    pavucontrol

    # Theming
    inputs.matugen.packages.${system}.default

    # XF86 Bind Tools
    pw-volume
    brightnessctl

    # GTK Themes
    nwg-look
    tokyonight-gtk-theme

    # Screenshot tools
    grim
    slurp
    wl-clipboard

    # Network management
    networkmanagerapplet

    # Quality of life utilities
    wlogout # Logout menu
    swaynotificationcenter # Alternative to dunst
    wl-gammactl # Blue light filter
    wlsunset # Auto blue light based on time
    playerctl # Media control
    pamixer # Audio control
    swayidle # Idle management
    hypridle # Idle daemon for Hyprland
    cliphist # Clipboard history
    polkit_gnome # Authentication agent

    # Pro tips implementations
    wf-recorder # Screen recording for Wayland
    gamescope # Gaming performance layer
    blueman # Bluetooth GUI management
    btop # Modern system monitor
    looking-glass-client # VM display (optional)    # File management and utilities
    xdg-utils # Desktop integration
    shared-mime-info # File type associations
    gtk3 # GTK3 support
    qt5.qtwayland # Qt5 Wayland support
    qt6.qtwayland # Qt6 Wayland support
  ];
}
