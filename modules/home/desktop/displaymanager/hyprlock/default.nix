{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 10;
        hide_cursor = true;
        no_fade_in = false;
      };
      background = [
        {
          path = "/home/aaron/Pictures/wallpaper/akshar-dave-BcvPlibJyo0-unsplash.jpg";
          blur_passes = 3;
          blur_size = 4;
        }
      ];
      label = [
        {
          text = "$TIME";
          color = "rgb(167, 192, 128)";
          font_size = 90;
          font_family = "Maple Mono NF";
          position = "0, -150";
          halign = "center";
          valign = "top";
        }
      ];
      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(CFE6F4)";
          inner_color = "rgb(657DC2)";
          outer_color = "rgb(0D0E15)";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }
      ];
    };
  };
}
