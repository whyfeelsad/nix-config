{
  programs = {
    kitty = {
      enable = true;
      themeFile = "everforest_dark_hard";

      font = {
        name = "Maple Mono NF CN";
        size = 15;
      };

      settings = {
        hide_window_decorations = "titlebar-only";
        window_padding_width = "10";

        mouse_hide_wait = 2;
        # cursor_shape = "block";
        url_color = "#0087bd";
        url_style = "dotted";
        #Close the terminal =  without confirmation;
        confirm_os_window_close = 0;
        background_opacity = "0.95";

        # tab bar
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
      };
    };
  };
}
