{ lib, ... }:
{
  boot.loader.grub = {
    enable = lib.mkDefault false;
    default = lib.mkDefault "saved";
    efiSupport = lib.mkDefault true;
    configurationLimit = lib.mkDefault 5;
    efiInstallAsRemovable = lib.mkDefault true;
  };
}
