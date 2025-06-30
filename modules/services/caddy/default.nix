{
  lib,
  config,
  ...
}: let
  cfg = config.modules.caddy;
in {
  options.modules.caddy = {
    enable = lib.mkEnableOption "Enable Caddy web server";
  };

  config = lib.mkIf cfg.enable {
    services.caddy = {
      enable = true;
      enableReload = true;
      user = "caddy";
      logDir = "/var/log/caddy";
      logFormat = lib.mkForce ''
        level INFO
        format console
      '';
    };

    networking.firewall = {
      allowedTCPPorts = [80 443];
      allowedUDPPorts = [443];
    };
  };
}
