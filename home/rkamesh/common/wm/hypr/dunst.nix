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
        width = 400;
        height = 200;
        origin = "top-right";
        offset = "15x65";
        scale = 0;
        notification_limit = 0;

        ### Progress bar ###
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 0;
        progress_bar_min_width = 350;
        progress_bar_max_width = 400;

        indicate_hidden = "yes";
        transparency = 0;
        separator_height = 2;
        padding = 12;
        horizontal_padding = 15;
        text_icon_padding = 0;
        frame_width = 2;
        frame_color = "#1bd5ab";
        gap_size = 5;
        separator_color = "auto";
        sort = "yes";

        ### Text ###
        font = "FiraCode Nerd Font 16";
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
        min_icon_size = 32;
        max_icon_size = 64;
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
        corner_radius = 10;
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
        background = "#111019";
        foreground = "#F1F0F5";
        frame_color = "#0B0A10";
        timeout = 3;
        highlight = "#AAC5A0";
      };

      urgency_normal = {
        background = "#111019";
        foreground = "#F1F0F5";
        frame_color = "#0B0A10";
        timeout = 5;
        highlight = "#A8C5E6";
      };

      urgency_critical = {
        background = "#111019";
        foreground = "#E97193";
        frame_color = "#0B0A10";
        timeout = 10;
        highlight = "#E97193";
      };
    };
  };
}
