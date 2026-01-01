{
  lib,
  config,
  ...
}: let
  cfg = config.boot'.systemd-boot;
in {
  options.boot'.systemd-boot = {
    enable = lib.mkEnableOption "Enable systemd-boot bootloader";
  };

  config = lib.mkIf cfg.enable {
    boot.loader.systemd-boot = {
      enable = lib.mkDefault true;
      editor = lib.mkDefault false;
      consoleMode = lib.mkDefault "max";
      configurationLimit = lib.mkDefault 5;
    };
  };
}
