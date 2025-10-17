{
  config,
  pkgs,
  ...
}:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = "~/.config/rofi/gruvbox.rasi";

    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      terminal = "ghostty";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      sidebar-mode = false;
    };
  };

  # Gruvbox theme as a separate file
  home.file.".config/rofi/gruvbox.rasi".text = ''
    * {
        bg0: #282828;
        bg1: #3c3836;
        bg2: #504945;
        bg3: #665c54;
        fg0: #ebdbb2;
        fg1: #d5c4a1;
        fg2: #a89984;
        red: #cc241d;
        green: #689d6a;
        yellow: #d79921;
        blue: #458588;
        magenta: #b16286;
        cyan: #689d6a;

        font: "JetBrains Mono Nerd Font 12";
        
        background-color: transparent;
        text-color: @fg0;
        
        margin: 0px;
        padding: 0px;
        spacing: 0px;
    }

    window {
        location: center;
        width: 480;
        background-color: @bg0;
        border: 2px solid;
        border-color: @blue;
        border-radius: 12px;
        padding: 20px;
    }

    inputbar {
        padding: 12px;
        spacing: 12px;
        children: [ icon-search, entry ];
        background-color: @bg1;
        border-radius: 8px;
        margin: 0px 0px 20px 0px;
    }

    icon-search {
        expand: false;
        filename: "search";
        size: 18px;
        vertical-align: 0.5;
    }

    entry {
        font: inherit;
        placeholder-color: @fg2;
        placeholder: "Search applications...";
        vertical-align: 0.5;
    }

    listview {
        background-color: transparent;
        columns: 1;
        lines: 8;
        cycle: true;
        dynamic: true;
        scrollbar: false;
    }

    element {
        padding: 8px 12px;
        background-color: transparent;
        text-color: @fg1;
        border-radius: 6px;
        spacing: 12px;
    }

    element selected {
        background-color: @bg2;
        text-color: @fg0;
    }

    element-icon {
        background-color: transparent;
        text-color: inherit;
        size: 24px;
        cursor: inherit;
    }

    element-text {
        background-color: transparent;
        text-color: inherit;
        cursor: inherit;
        vertical-align: 0.5;
        horizontal-align: 0.0;
    }
  '';
}
