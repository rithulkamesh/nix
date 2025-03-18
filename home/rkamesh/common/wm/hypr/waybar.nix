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
      @import url("colors.css");

      * {
        font-family: 'SF Pro Text', sans-serif;
        font-size: 12px;
        transition: 0.3s ease-in-out;
      }

      window#waybar {
        background-color: transparent;
        color: @on_surface;
      }

      .modules-left, .modules-center, .modules-right {
        background-color: alpha(@surface_container_high, 0.95);
        border-radius: 12px;
        margin: 4px;
        padding: 0 6px;
      }

      #workspaces {
        padding: 0 4px;
      }

      #workspaces button {
        padding: 2px 8px;
        margin: 2px;
        border-radius: 8px;
        background-color: transparent;
        color: @on_surface;
        font-size: 13px;
      }

      #workspaces button.active {
        background-color: @primary_container;
        color: @on_primary_container;
      }

      #workspaces button.urgent {
        background-color: @error_container;
        color: @on_error_container;
      }

      #battery,
      #network,
      #wireplumber,
      #clock {
        padding: 0 10px;
        margin: 4px 2px;
        font-size: 13px;
      }

      #battery.charging, #battery.plugged {
        color: @tertiary;
      }

      #battery.critical:not(.charging) {
        background-color: @error_container;
        color: @on_error_container;
        animation: blink 0.5s linear infinite alternate;
      }

      @keyframes blink {
        to {
          background-color: @error;
          color: @on_error;
        }
      }

      #network.disconnected {
        color: @error;
      }

      #wireplumber.muted {
        color: @outline;
        opacity: 0.7;
      }

      tooltip {
        background-color: @surface_container;
        border-radius: 8px;
        border: 1px solid @outline_variant;
      }

      tooltip label {
        color: @on_surface;
      }
    '';

    settings = [
      {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 0;
        margin = "4 4 0 4";

        "modules-left" = ["hyprland/workspaces"];
        "modules-center" = ["clock"];
        "modules-right" = ["wireplumber" "network" "battery"];

        clock = {
          format = "{:%I:%M %p}";
          tooltip-format = "{:%A, %B %d, %Y}";
        };

        network = {
          "format-wifi" = "  {essid}";
          "format-ethernet" = "󰈀";
          "format-disconnected" = "󰌙";
          "tooltip-format-wifi" = "Signal strength: {signalStrength}%";
          "tooltip-format-ethernet" = "{ipaddr}/{cidr}";
          "tooltip-format-disconnected" = "Disconnected";
        };

        battery = {
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{icon} {capacity}%";
          "format-charging" = "  {capacity}%";
          "format-plugged" = "  {capacity}%";
          "format-icons" = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };

        wireplumber = {
          "format" = "{icon} {volume}%";
          "format-muted" = "󰝟";
          "format-icons" = ["󰕿" "󰖀" "󰕾"];
        };
      }
    ];
  };
}
