{
  config,
  pkgs,
  lib,
  myvars,
  flake-inputs,
  ...
}:
{
  imports = [
    flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak

    ./cli
    ./gui

    ./dev
    ./desktop/flatpak
    ./desktop/displaymanager/swaylock
    ./desktop/windowmanager/niri
    ./desktop/windowmanager/waybar
    ./desktop/windowmanager/cursor
  ];

  home = {
    username = "${myvars.userName}";
    homeDirectory = "/home/${myvars.userName}";
    stateVersion = "${myvars.stateVersion}";
  };

  programs.home-manager.enable = true;
}
