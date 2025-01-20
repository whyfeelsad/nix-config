{ pkgs, ... }:
{
  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  home.packages = with pkgs; [
    fuzzel
    swaybg

    materialgram
    firefox
    remmina

    xwayland-satellite
  ];
}
