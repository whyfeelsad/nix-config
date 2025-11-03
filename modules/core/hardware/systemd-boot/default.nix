{
  lib,
  config,
  ...
}: let
  cfg = config.hardware'.systemd-boot;
in {
  options.hardware'.systemd-boot = {
    enable = lib.mkEnableOption "Enable systemd-boot";
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      systemd-boot = {
        enable = lib.mkDefault true;
        editor = lib.mkDefault false;
        consoleMode = lib.mkDefault "max";
        configurationLimit = lib.mkDefault 5;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
