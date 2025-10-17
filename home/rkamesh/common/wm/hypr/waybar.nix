{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = (oldAttrs.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });

    style = ''
      /* Gruvbox Dark colors */
      @define-color bg            #282828;
      @define-color bg-alt        #3c3836;
      @define-color fg            #ebdbb2;
      @define-color fg-alt        #a89984;
      @define-color blue          #458588;
      @define-color blue-alt      #076678;
      @define-color green         #b16286;
      @define-color magenta       #b16286;
      @define-color red           #cc241d;
      @define-color yellow        #d79921;
      @define-color cyan          #689d6a;
      @define-color orange        #d65d0e;

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
      #custom-date,
      #network,
      #wireplumber,
      #battery,
      #pulseaudio,
      #custom-audio-output,
      #custom-power {
        padding: 0 4px;
        margin: 2px 2px;
        color: @fg;
      }

      #clock {
        font-weight: bold;
      }

      #custom-date {
        color: @fg-alt;
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
        spacing = 6;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [
          "clock"
          "custom/date"
        ];
        modules-right = [
          "pulseaudio"
          "custom/audio-output"
          "network"
          "battery"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          format = "{}";
          on-click = "activate";
        };

        "hyprland/window" = {
          format = "{}";
          separate-outputs = true;
          max-length = 50;
        };

        clock = {
          format = "{:%I:%M %p}";
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "<big>{:%B %d, %Y}</big>\n<tt>{calendar}</tt>";
          interval = 1;
        };

        "custom/date" = {
          exec = ''bash -c 'day=$(date +%-d); case $day in 1|21|31) suf="st";; 2|22) suf="nd";; 3|23) suf="rd";; *) suf="th";; esac; date +" $day$suf %B %Y"' '';
          interval = 60;
          format = "{}";
          tooltip = false;
        };

        tray = {
          icon-size = 16;
          spacing = 8;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 Muted";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "pavucontrol";
        };

        "custom/audio-output" = {
          exec = ''bash -c 'pactl get-default-sink | sed "s/.*\.//" | sed "s/_/ /g" | awk "{print toupper(substr(\$0,1,1)) tolower(substr(\$0,2))}" | cut -c1-12' '';
          interval = 2;
          format = "󰓃 {}";
          on-click = "~/.config/waybar/audio-switcher.sh";
          tooltip = false;
        };

        network = {
          format = "󰖩 {essid}";
          format-disconnected = "󰖪 Disconnected";
          tooltip-format = "Signal: {signalStrength}%\nUp: {bandwidthUpBits}\nDown: {bandwidthDownBits}";
          tooltip-format-disconnected = "Disconnected";
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
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        "custom/power" = {
          format = "󰐥";
          on-click = "wlogout";
          tooltip = false;
        };
      }
    ];
  };
}
