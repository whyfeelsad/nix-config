{
  hm'.programs.kitty = {
    enable = true;
    # kitty has catppuccin theme built-in,
    # all the built-in themes are packaged into an extra package named `kitty-themes`
    # and it's installed by home-manager if `theme` is specified.
    themeFile = "everforest_dark_hard";
    font = {
      name = "Maple Mono NF";
      size = 14;
    };

    settings = {
      hide_window_decorations = "titlebar-only";
      window_padding_width = "15";
      background_opacity = "0.9";
      background_blur = "30";
      remember_window_size = "yes";
      enable_audio_bell = false;

      # tab bar
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      # cursor
      cursor_blink_interval = "0";
      # detect_urls no
      mouse_hide_wait = "1";
    };
  };
}
