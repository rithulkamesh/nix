{
  config,
  pkgs,
  ...
}:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      # BACKGROUND - Use fallback color to prevent black screen
      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 2;
          blur_size = 4;
          contrast = 0.8;
          brightness = 0.4;
          vibrancy = 0.1;
          vibrancy_darkness = 0.3;
        }
        # Fallback solid color if screenshot fails
        {
          monitor = "";
          color = "rgba(40, 40, 40, 1.0)"; # Gruvbox dark background
        }
      ];

      # GENERAL
      general = {
        no_fade_in = false;
        no_fade_out = false;
        hide_cursor = true;
        grace = 1;
        disable_loading_bar = false;
      };

      # INPUT FIELD
      input-field = [
        {
          monitor = "";
          size = "320, 50";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.3;
          dots_center = true;
          dots_rounding = -1;
          outer_color = "rgba(60, 56, 54, 0.3)";
          inner_color = "rgba(40, 40, 40, 0.4)";
          font_color = "rgb(235, 219, 178)";
          fade_on_empty = true;
          fade_timeout = 1000;
          rounding = 8;
          check_color = "rgba(104, 157, 106, 1)";
          fail_color = "rgba(204, 36, 29, 1)";
          placeholder_text = "<span foreground=\"#a89984\">Enter Password</span>";
          hide_input = false;
          position = "0, -150";
          halign = "center";
          valign = "center";
          shadow_passes = 1;
          shadow_size = 2;
          shadow_color = "rgba(0, 0, 0, 0.3)";
        }
      ];

      # PROFILE PICTURE
      image = [
        {
          monitor = "";
          path = "$HOME/Pictures/pfp.png";
          size = 120;
          border_size = 2;
          border_color = "rgba(235, 219, 178, 0.3)";
          rounding = -1;
          position = "0, 50";
          halign = "center";
          valign = "center";
          shadow_passes = 1;
          shadow_size = 2;
          shadow_color = "rgba(0, 0, 0, 0.3)";
        }
      ];

      # LABELS
      label = [
        # TIME
        {
          monitor = "";
          text = "cmd[update:1000] bash -c 'echo \"<span foreground=\\\"#ebdbb2\\\">$(date +\"%-I:%M\")</span><span foreground=\\\"#a89984\\\"> $(date +\"%p\")</span>\"'";
          color = "rgba(235, 219, 178, 0.9)";
          font_size = 64;
          font_family = "JetBrains Mono";
          position = "0, 200";
          halign = "center";
          valign = "center";
          shadow_passes = 1;
          shadow_size = 2;
          shadow_color = "rgba(0, 0, 0, 0.5)";
        }
        # DATE
        {
          monitor = "";
          text = "cmd[update:60000] bash -c 'day=$(date +%-d); case $day in 1|21|31) suf=\"st\";; 2|22) suf=\"nd\";; 3|23) suf=\"rd\";; *) suf=\"th\";; esac; echo \"<span foreground=\\\"#d5c4a1\\\">$(date +\"%A\")</span>, <span foreground=\\\"#a89984\\\">$day$suf $(date +\"%B %Y\")</span>\"'";
          color = "rgba(235, 219, 178, 0.8)";
          font_size = 18;
          font_family = "JetBrains Mono";
          position = "0, 140";
          halign = "center";
          valign = "center";
          shadow_passes = 1;
          shadow_size = 1;
          shadow_color = "rgba(0, 0, 0, 0.3)";
        }
        # CALENDAR EVENTS
        {
          monitor = "";
          text = "cmd[update:300000] ${pkgs.khal}/bin/khal list today tomorrow --format '{start-time} {title}' 2>/dev/null | head -3 | sed 's/^/• /' || echo 'No events'";
          color = "rgba(168, 153, 132, 0.7)";
          font_size = 14;
          font_family = "JetBrains Mono";
          position = "0, 20";
          halign = "center";
          valign = "center";
          shadow_passes = 1;
          shadow_size = 1;
          shadow_color = "rgba(0, 0, 0, 0.3)";
        }
        # USER
        {
          monitor = "";
          text = "$USER";
          color = "rgba(168, 153, 132, 0.8)";
          font_size = 16;
          font_family = "JetBrains Mono";
          position = "0, -100";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
