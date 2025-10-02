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
        "HDMI-1,3840x2160,-3840x0,1.5" # 4K monitor to the left with 1.5x scaling
        "eDP-1,preferred,0x0,1" # Laptop display
      ];
      bindl = [
        # When lid is closed, disable internal display
        ",switch:on:Lid Switch,exec,hyprctl keyword monitor eDP-1,disable"
        # When lid is opened, enable internal display
        ",switch:off:Lid Switch,exec,hyprctl keyword monitor eDP-1,preferred,0x0,1"
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
      ];

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "QT_QPA_PLATFORMTHEME,qt6ct"
      ];
    };
  };

  programs.ghostty = {
    enable = true;
  };

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

    # Rofi
    rofi
  ];
}
