{lib, ...}: {
  boot.loader.systemd-boot = {
    configurationLimit = lib.mkDefault 10;
    consoleMode = lib.mkDefault "max";
  };

  boot.loader.timeout = lib.mkDefault 3;

  # for power management
  services = {
    power-profiles-daemon = {
      enable = true;
    };
    upower.enable = true;
  };
}
