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
  ];

  networking.hostName = "mechrevo";
  networking.networkmanager.enable = true;

  system.stateVersion = "${myvars.stateVersion}";
}
