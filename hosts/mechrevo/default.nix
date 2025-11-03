{
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "mechrevo";

  networking'.networkmanager.enable = true;

  system.stateVersion = "25.05";
}
