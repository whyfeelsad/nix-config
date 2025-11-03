{
  lib,
  config,
  ...
}: let
  cfg = config.hardware'.grub;
in {
  options.hardware'.grub = {
    enable = lib.mkEnableOption "Enable GRUB";
  };

  config = lib.mkIf cfg.enable {
    boot.loader.grub = {
      enable = lib.mkDefault true;
      default = lib.mkDefault "saved";
      efiSupport = lib.mkDefault true;
      configurationLimit = lib.mkDefault 5;
      efiInstallAsRemovable = lib.mkDefault true;
    };
  };
}
