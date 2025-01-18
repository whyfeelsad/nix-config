{
  config,
  pkgs,
  ...
}: let
  makeCommand = command: {
    command = [command];
  };
in {
  programs.niri = {
    enable = true;
    settings = {
      environment = {
        CLUTTER_BACKEND = "wayland";
        DISPLAY = ":0";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
      };
      spawn-at-startup = [
        (makeCommand "waybar")
        (makeCommand "swaybg" "-m" "fill" "-i" "/home/aaron/Pictures/wallpaper/akshar-dave-BcvPlibJyo0-unsplash.jpg")
      ];
      input = {
        keyboard = {
          xkb.layout = "us";
          repeat-delay = 250;
          repeat-rate = 50;
        };
        touchpad = {
          dwt = true;
          dwtp = true;

          tap = true;
          natural-scroll = true;
          tap-button-map = "left-right-middle";
          scroll-method = "two-finger";
          click-method = "clickfinger";
        };
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus = true;
        workspace-auto-back-and-forth = true;
      };
      outputs = {};
      layout = {
        gaps = 8;
        center-focused-column = "never";

        preset-column-widths = [
          {proportion = 1.0 / 3.0;}
          {proportion = 1.0 / 2.0;}
          {proportion = 2.0 / 3.0;}
          {proportion = 1.0;}
        ];
        default-column-width = {proportion = 1.0 / 2.0;};

        focus-ring = {
          enable = true;
          width = 2;

          active.color = "#8ec07c";
          inactive.color = "#1d2021";
        };
        border.enable = false;
      };
      animations.enable = true;
    };
  };
}
