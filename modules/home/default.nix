{
  config,
  pkgs,
  lib,
  myvars,
  ...
}: {
  imports = [
    ./cli
  ];

  home = {
    username = "${myvars.userName}";
    homeDirectory = "/home/${myvars.userName}";
    stateVersion = "${myvars.stateVersion}";
  };

  programs.home-manager.enable = true;
}
