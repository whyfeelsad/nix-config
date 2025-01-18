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
  ];

  networking.hostName = "mechrevo";
  networking.networkmanager.enable = true;

  environment.systemPackages = [
    pkgs.git
    pkgs.just
  ];

  system.stateVersion = "${myvars.stateVersion}";
}
