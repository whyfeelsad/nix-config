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
  ];

  home = {
    username = "${myvars.userName}";
    homeDirectory = "/home/${myvars.userName}";
    stateVersion = "${myvars.stateVersion}";
  };

  programs.home-manager.enable = true;
}
