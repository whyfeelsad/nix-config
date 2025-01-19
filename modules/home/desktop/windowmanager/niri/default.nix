{pkgs, ...}: {
  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  home.packages = with pkgs; [
    fuzzel
    swaybg

    materialgram
    firefox
    vscode

    xfce.thunar
    xwayland-satellite
  ];
}
