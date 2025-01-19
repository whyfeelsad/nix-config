{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 10;
        hide_cursor = true;
        ignore_empty_input = true;
      };

      background = {
        path = "/home/aaron/Pictures/wallpaper/akshar-dave-BcvPlibJyo0-unsplash.jpg";
        color = "rgb(84,147,171)";
        blur_passes = 3;
        blur_size = 3;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      image = {
        path = "/home/aaron/Pictures/wallpaper/akshar-dave-BcvPlibJyo0-unsplash.jpg";
        size = 200;
        border_color = "rgb(84,147,171)";
        position = "0, 150";
        halign = "center";
        valign = "center";
      };

      label = {
        text = "$TIME";
        color = "rgb(10, 10, 10)";
        font_size = 90;
        font_family = "CaskaydiaCove NFM Bold";
        position = "0, -150";
        halign = "center";
        valign = "top";
      };

      input-field = {
        size = "300, 60";
        outline_thickness = 4;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "rgb(84,147,171)";
        inner_color = "rgb(10, 10, 10)";
        font_color = "rgb(84,147,171)";
        fade_on_empty = false;
        placeholder_text = ''<span foreground="##cdd6f4"><i>󰌾 Logged in as </i><span foreground="##5493ab">$USER</span></span>'';
        hide_input = false;
        check_color = "rgb(204, 136, 34)";
        fail_color = "rgb(204, 34, 34)";
        fail_text = ''<i>$FAIL <b>($ATTEMPTS)</b></i>'';
        capslock_color = -1;
        position = "0, 0";
        halign = "center";
        valign = "center";
      };
    };
  };
}
