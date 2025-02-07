{
  inputs,
  pkgs,
  ...
}: {
  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  home.packages = with pkgs; [
    fuzzel
    swaybg
    dunst
    pot

    materialgram
    firefox
    remmina

    bitwarden-desktop
    plex-desktop
    wakatime-cli
    xwayland-satellite

    xfce.thunar
  ];
}
