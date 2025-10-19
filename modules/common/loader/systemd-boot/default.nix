{ lib, ... }:
{
  boot.loader.systemd-boot = {
    enable = lib.mkDefault false;
    editor = lib.mkDefault false;
    consoleMode = lib.mkDefault "max";
    configurationLimit = lib.mkDefault 5;
  };
}
