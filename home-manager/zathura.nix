{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.zathura = {
    enable = true;
    options = {
      # Colors (Catppuccin Mocha)
      default-fg = "#CDD6F4";
      default-bg = "#1E1E2E";

      completion-bg = "#313244";
      completion-fg = "#CDD6F4";
      completion-highlight-bg = "#575268";
      completion-highlight-fg = "#CDD6F4";
      completion-group-bg = "#313244";
      completion-group-fg = "#89B4FA";

      statusbar-fg = "#CDD6F4";
      statusbar-bg = "#313244";

      notification-bg = "#313244";
      notification-fg = "#CDD6F4";
      notification-error-bg = "#313244";
      notification-error-fg = "#F38BA8";
      notification-warning-bg = "#313244";
      notification-warning-fg = "#FAE3B0";

      inputbar-fg = "#CDD6F4";
      inputbar-bg = "#313244";

      recolor-lightcolor = "#1E1E2E";
      recolor-darkcolor = "#CDD6F4";

      index-fg = "#CDD6F4";
      index-bg = "#1E1E2E";
      index-active-fg = "#CDD6F4";
      index-active-bg = "#313244";

      render-loading-bg = "#1E1E2E";
      render-loading-fg = "#CDD6F4";

      # Recolor settings
      recolor = true;
      recolor-keephue = true;

      # Layout settings
      adjust-open = "best-fit";
      pages-per-row = 1;
      scroll-page-aware = true;
      scroll-step = 50;
      zoom-step = 20;
      guioptions = "none";

      # Basic settings
      selection-clipboard = "clipboard";
      window-title-basename = true;
      statusbar-home-tilde = true;
      incremental-search = true;
      font = "JetBrainsMono Nerd Font 10";

      # Database settings
      database = "sqlite";
      save-position = true;
      link-zoom = false;
      page-cache-size = 15;
      page-store-threshold = 10;
      page-store-interval = 10;
      page-right-to-left = false;
    };

    mappings = {
      # Navigation
      h = "navigate previous";
      j = "scroll down";
      k = "scroll up";
      l = "navigate next";
      H = "navigate previous";
      J = "scroll down";
      K = "scroll up";
      L = "navigate next";

      # Arrow navigation
      "<Left>" = "navigate previous";
      "<Right>" = "navigate next";
      "<Up>" = "scroll up";
      "<Down>" = "scroll down";

      # Page fitting
      a = "adjust_window";
      s = "adjust_window best-fit";
      d = "adjust_window height";
      f = "adjust_window width";

      # Toggle modes
      "<C-f>" = "toggle_fullscreen";
      "<C-d>" = "toggle_page_mode";
      "<C-r>" = "reload";
      r = "rotate";
      R = "rotate";
      i = "recolor";

      # Zoom controls
      "<C-k>" = "zoom in";
      "<C-j>" = "zoom out";

      # Search
      "/" = "search";
      n = "search_next";
      N = "search_previous";

      # Clipboard
      y = "selection_clipboard";
    };
  };
}
