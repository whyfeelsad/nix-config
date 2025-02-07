{
  lib,
  pkgs,
  myvars,
  config,
  ...
}: {
  imports = [
    ./hardware.nix
    ./impermanence.nix

    ../../modules/base
    ../../modules/desktop
    ../../modules/services/daed
#    ../../modules/services/podman
    ../../modules/services/docker
    ../../modules/services/virt-manager
  ];

  networking.hostName = "mechrevo";
  networking.networkmanager.enable = true;

  system.stateVersion = "${myvars.stateVersion}";
}
