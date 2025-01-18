{
  config,
  lib,
  pkgs,
  myvars,
  ...
}: {
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix

    ../../modules/base
    ../../modules/impermanence
  ];

  networking.hostName = "mechrevo";
  networking.networkmanager.enable = true;

  system.stateVersion = "${myvars.stateVersion}";
}
