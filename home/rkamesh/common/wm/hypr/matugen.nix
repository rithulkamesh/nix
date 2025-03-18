{
  config,
  pkgs,
  lib,
  ...
}: {
  # Create necessary directories
  home.file = {
    # Create the TokyoNight theme file
    ".config/matugen/schemes/tokyonight.yaml".text = ''
      scheme: "TokyoNight Night"
      author: "Rithul Kamesh"
      base00: "1a1b26" # Background
      base01: "16161e" # Lighter Background
      base02: "2f3549" # Selection Background
      base03: "444b6a" # Comments, Invisibles
      base04: "787c99" # Dark Foreground
      base05: "a9b1d6" # Default Foreground
      base06: "cbccd1" # Light Foreground
      base07: "d5d6db" # Light Background
      base08: "f7768e" # Red
      base09: "ff9e64" # Orange
      base0A: "e0af68" # Yellow
      base0B: "9ece6a" # Green
      base0C: "7dcfff" # Cyan
      base0D: "7aa2f7" # Blue
      base0E: "bb9af7" # Purple
      base0F: "c53b53" # Dark Red
    '';

    ".config/matugen/templates/hyprland-colors.conf".text = ''
      <* for name, value in colors *>
      $image = {{image}}
      $\{{name}} = rgba({{value.default.hex_stripped}}ff)
      <* endfor *>
    '';

    ".config/matugen/templates/colors.css".text = ''
      /*
          * Css Colors
          * Generated with Matugen
      */
      <* for name, value in colors *>
          @define-color {{name}} {{value.default.hex}};
      <* endfor *>
    '';

    # Create the Matugen config file
    ".config/matugen/config.toml".text = ''
      [config]
      scheme="tokyonight"

      [templates.waybar]
      input_path = '~/.config/matugen/templates/colors.css'
      output_path = '~/.config/waybar/colors.css'
      post_hook = 'pkill -SIGUSR2 waybar'


      [templates.hyprland]
      input_path = '~/.config/matugen/templates/hyprland-colors.conf'
      output_path = '~/.config/hypr/colors.conf'
      post_hook = 'hyprctl reload'
    '';
  };
}
