{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      clock = true;
      timestr = "%H:%M:%S";
      datestr = "%Y-%d-%m";
      # screenshots = true;
      ignore-empty-password = true;

      effect-blur = "7x5";
      effect-vignette = "0.75:0.75";
      effect-pixelate = 5;

      font = "Maple Mono NF CN";
      font-size = 50;
      indicator-radius = 100;
      indicator-thickness = 10;
      inside-color = "ffffff00";
      key-hl-color = "5e81ac";
      ring-color = "2e3440";
      line-uses-ring = true;
      separator-color = "e5e9f022";
      text-color = "d8dee9ff";
      layout-text-color = "d8dee9ff";
      text-clear-color = "d8dee9ff";
      text-caps-lock-color = "d8dee9ff";
      indicator-idle-visible = true;
      daemonize = true;
      image = "/home/aaron/Pictures/wallpaper/akshar-dave-BcvPlibJyo0-unsplash.jpg";
      scaling = "fill";
    };
  };
}
