{
  config,
  lib,
  pkgs,
  myvars,
  ...
}: {
  imports = [
    ./zram.nix
    ./hardware-configuration.nix

    ../../modules/base
    ../../modules/impermanence

    ../../modules/desktop
  ];

  networking.hostName = "mechrevo";
  networking.networkmanager.enable = true;

  services.flatpak.enable = false;

  system.stateVersion = "${myvars.stateVersion}";
}
