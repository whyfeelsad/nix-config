{
  config,
  pkgs,
  lib,
  myvars,
  ...
}: {
  imports = [
    ./shell
  ];

  home = {
    username = "${myvars.userName}";
    homeDirectory = "/home/${myvars.userName}";
    stateVersion = "${myvars.stateVersion}";
  };

  programs.home-manager.enable = true;
}
