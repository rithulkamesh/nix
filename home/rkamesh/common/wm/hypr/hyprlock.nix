{
  config,
  pkgs,
  ...
}: {
  # Create the hyprlock configuration file at ~/.config/hypr/hyprlock.conf
  home.file.".config/hypr/hyprlock.conf".text = ''
    # Tokyonight Night hyprlock configuration (OG typing style)
    # Managed via Home Manager

    # Define theme variables
    $background_color = rgba(26,27,38,1.0)
    $text_color       = rgba(169,177,214,1.0)
    $accent           = rgba(122,162,247,1.0)
    $font             = "JetBrainsMono Nerd Font"

    # GENERAL SETTINGS
    general {
        disable_loading_bar = true
        hide_cursor         = true
    }

    # BACKGROUND: solid background using TokyoNight color palette
    background {
        monitor     =
        path        = "~/Pictures/wall_mtn.jpg"   # Leave empty to use the solid color
        color       = $background_color
        blur_passes = 5
    }

    # CLOCK LABEL (Time) positioned at the top center
    label {
        monitor      =
        text         = cmd[update:1000] echo "$(date +'%I:%M %p')"
        color        = $text_color
        font_size    = 90
        font_family  = $font
        position     = 0, -200   # Adjust this value to move further up if desired
        halign       = center
        valign       = center
    }

    input-field {
        monitor           =
        size              = 300, 60
        outline_thickness = 4
        dots_size         = 0.25
        dots_spacing      = 0.15
        dots_center       = true
        outer_color       = $accent
        inner_color       = rgba(30,30,30,1.0)
        font_color        = $text_color
        fade_on_empty     = false
        placeholder_text  = "Enter Password"
        hide_input        = false
        check_color       = $accent
        fail_color        = rgba(255,85,85,1.0)
        fail_text         = "$FAIL"
        position          = 0, 0    # Centered just below the clock
        halign            = center
        valign            = center
    }

    # USER AVATAR: circular image placed below the password prompt
    image {
        monitor      =
        path         = ~/Pictures/pfp.png
        size         = 120
        rounding     = -1
        border_size  = 4
        border_color = $accent
        position     = 0, 150   # Adjust to space further if needed
        halign       = center
        valign       = center
    }
  '';
}
