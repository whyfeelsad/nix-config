{
  config,
  lib,
  pkgs,
  myvars,
  ...
}: {
  imports = [
    ./zram.nix
    ./hardware.nix
    ./impermanence.nix
    ./windowmanager.nix

    ../../modules/nixos/base
    ../../modules/nixos/desktop
  ];

  networking.hostName = "mechrevo";
  networking.networkmanager.enable = true;

  system.stateVersion = "${myvars.stateVersion}";
}
