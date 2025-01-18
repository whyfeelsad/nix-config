{
  config,
  pkgs,
  lib,
  myvars,
  flake-inputs,
  ...
}: {
  imports = [
    flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak

    ./programs
    ./shell
  ];

  home = {
    username = "${myvars.userName}";
    homeDirectory = "/home/${myvars.userName}";
    stateVersion = "${myvars.stateVersion}";
  };

  programs.home-manager.enable = true;
}
