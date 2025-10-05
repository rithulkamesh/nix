{
  # Dunst configuration for Home Manager
  services.dunst = {
    enable = true;

    settings = {
      global = {
        ### Display ###
        monitor = 0;
        follow = "mouse";

        ### Geometry ###
        width = 300; # Changed from 200 to better fit content
        height = 80; # Reduced from 100
        origin = "top-right";
        offset = "15x65";
        scale = 0;
        notification_limit = 0;

        ### Progress bar ###
        progress_bar = true;
        progress_bar_height = 8; # Reduced from 10
        progress_bar_frame_width = 0;
        progress_bar_min_width = 250; # Reduced from 350
        progress_bar_max_width = 300; # Reduced from 400

        indicate_hidden = "yes";
        transparency = 0;
        separator_height = 2;
        padding = 8; # Reduced from 12
        horizontal_padding = 10; # Reduced from 15
        text_icon_padding = 0;
        frame_width = 1; # Reduced from 2
        frame_color = "#7aa2f7";
        gap_size = 3; # Reduced from 5
        separator_color = "auto";
        sort = "yes";

        ### Text ###
        font = "FiraCode Nerd Font 10"; # Reduced from 16
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\n<span size=\"small\">%b</span>";
        alignment = "center";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "end";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";

        ### Icons ###
        icon_position = "left";
        min_icon_size = 24; # Reduced from 32
        max_icon_size = 48; # Reduced from 64
        icon_path = "/usr/share/icons/gnome/128x128/status/:/usr/share/icons/gnome/128x128/devices/";
        icon_theme = "Papirus, Adwaita";
        enable_recursive_icon_lookup = true;

        ### History ###
        sticky_history = "yes";
        history_length = 20;

        ### Misc/Advanced ###
        dmenu = "rofi --show dmenu -p dunst:";
        browser = "/usr/bin/xdg-open";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 8; # Reduced from 10
        ignore_dbusclose = false;

        ### Wayland ###
        layer = "top";
        force_xwayland = false;
        force_xinerama = false;

        ### Mouse ###
        mouse_left_click = "close_current";
        mouse_middle_click = "context";
        mouse_right_click = "do_action";
      };

      experimental = {
        per_monitor_dpi = false;
      };

      urgency_low = {
        background = "#1a1b26";
        foreground = "#c0caf5";
        frame_color = "#414868";
        timeout = 3;
        highlight = "#9ece6a";
      };

      urgency_normal = {
        background = "#1a1b26";
        foreground = "#c0caf5";
        frame_color = "#7aa2f7";
        timeout = 5;
        highlight = "#7aa2f7";
      };

      urgency_critical = {
        background = "#1a1b26";
        foreground = "#f7768e";
        frame_color = "#f7768e";
        timeout = 10;
        highlight = "#f7768e";
      };
    };
  };
}
