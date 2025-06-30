{
  lib,
  pkgs,
  myvars,
  config,
  ...
}: {
  imports = [
    ../../modules
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "mechrevo";
    networkmanager.enable = true;
  };

  services.dae = {
    enable = true;
    configFile = "/home/aaron/.config/dae/config.dae";
  };

  modules = {
    incus.enable = true;
    preservation.enable = true;
    disko-luks-btrfs.enable = true;
  };

  system.stateVersion = "${myvars.stateVersion}";
}
