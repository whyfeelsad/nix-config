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
  ];

  networking.hostName = "mechrevo";
  networking.networkmanager.enable = true;

  environment.systemPackages = [
    pkgs.git
    pkgs.just
  ];

  system.stateVersion = "${myvars.stateVersion}";
}
