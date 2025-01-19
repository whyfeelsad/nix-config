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

    ../../modules/nixos/base
    ../../modules/nixos/desktop

    ../../modules/nixos/services/daed
  ];

  networking.hostName = "mechrevo";
  networking.networkmanager.enable = true;

  system.stateVersion = "${myvars.stateVersion}";
}
