{
  lib,
  config,
  ...
}: let
  cfg = config.services'.vnstat;
in {
  options.services'.vnstat = {
    enable = lib.mkEnableOption "Enable vnstat network traffic monitor";
  };

  config = lib.mkIf cfg.enable {
    services.vnstat.enable = true;

    preservation'.os.directories = [
      "/var/lib/vnstat"
    ];
  };
}
