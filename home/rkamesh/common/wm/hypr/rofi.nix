{
  config,
  pkgs,
  ...
}:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = "~/.config/rofi/tokyo-night.rasi";

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

  # Tokyo Night theme as a separate file
  home.file.".config/rofi/tokyo-night.rasi".text = ''
    * {
        bg0: #1a1b26;
        bg1: #24283b;
        bg2: #414868;
        bg3: #565f89;
        fg0: #c0caf5;
        fg1: #a9b1d6;
        fg2: #737aa2;
        red: #f7768e;
        green: #9ece6a;
        yellow: #e0af68;
        blue: #7aa2f7;
        magenta: #bb9af7;
        cyan: #7dcfff;

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
