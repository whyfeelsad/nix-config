{
  config,
  pkgs,
  lib,
  myvars,
  ...
}: {
  imports = [
    ./cli
    ./gui
    ./desktop/displaymanager/swaylock
    ./desktop/windowmanager/niri
    ./desktop/windowmanager/waybar
  ];

  home = {
    username = "${myvars.userName}";
    homeDirectory = "/home/${myvars.userName}";
    stateVersion = "${myvars.stateVersion}";
  };

  programs.home-manager.enable = true;
}
