{
  myvars,
  ...
}:
{
  imports = [
    ../../modules
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "mechrevo";
    networkmanager.enable = true;
  };

  modules = {
    preservation.enable = true;
  };

  system.stateVersion = "${myvars.stateVersion}";
}
