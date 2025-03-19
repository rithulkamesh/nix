{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = (oldAttrs.mesonFlags or []) ++ ["-Dexperimental=true"];
    });

    style = ''
      /* Tokyo Night (Night variant) colors */
      @define-color bg            #1a1b26;
      @define-color bg-alt        #24283b;
      @define-color fg            #c0caf5;
      @define-color fg-alt        #a9b1d6;
      @define-color blue          #7aa2f7;
      @define-color blue-alt      #3d59a1;
      @define-color green         #9ece6a;
      @define-color magenta       #bb9af7;
      @define-color red           #f7768e;
      @define-color yellow        #e0af68;
      @define-color cyan          #7dcfff;
      @define-color orange        #ff9e64;

      * {
        font-family: 'JetBrains Mono', 'SF Pro Text', monospace;
        font-size: 11px;
        min-height: 0;
        transition: 0.2s ease;
      }

      window#waybar {
        background: transparent;
      }

      #waybar > box {
        margin: 10px 10px 0 10px;
        background: alpha(@bg, 0.95);
        border-radius: 6px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
        border: 1px solid alpha(@blue-alt, 0.2);
      }

      #workspaces {
        margin: 2px;
        border-radius: 6px;
        background: alpha(@bg-alt, 0.8);
        padding: 0 4px;
      }

      #workspaces button {
        all: unset;
        font-size: 12px;
        color: @fg-alt;
        padding: 0 4px;
        margin: 2px 1px;
        border-radius: 4px;
      }

      #workspaces button.active {
        color: #ffffff;
        background: alpha(@blue, 0.2);
      }

      #workspaces button.urgent {
        background: alpha(@red, 0.2);
        color: @red;
      }

      /* Set common module styling */
      #clock,
      #network,
      #wireplumber,
      #battery {
        padding: 0 1px;
        margin: 2px 2px;
        color: @fg;
      }

      #clock {
        font-weight: bold;
      }

      #battery {
        color: @green;
      }

      #battery.charging {
        color: @yellow;
      }

      #battery.warning:not(.charging) {
        color: @orange;
      }

      #battery.critical:not(.charging) {
        color: @red;
        animation: blink 1s linear infinite alternate;
      }

      @keyframes blink {
        to {
          color: #ffffff;
          background-color: alpha(@red, 0.2);
        }
      }

      tooltip {
        background: @bg;
        border: 1px solid @blue-alt;
        border-radius: 8px;
      }

      tooltip label {
        color: @fg;
      }
    '';

    settings = [
      {
        layer = "top";
        position = "top";
        height = 31;
        spacing = 8;

        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["wireplumber" "network" "battery"];

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
        };

        clock = {
          format = "{:%I:%M %p}";
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "<big>{:%B %d, %Y}</big>\n<tt>{calendar}</tt>";
        };

        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 Muted";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
          };
          on-click = "pavucontrol";
        };

        network = {
          format = "󰖩 {essid}";
          tooltip-format = "Signal: {signalStrength}%\nUp: {bandwidthUpBits}\nDown: {bandwidthDownBits}";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-alt = "{icon} {time}";
          format-time = "{H}h {M}m";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
      }
    ];
  };
}
