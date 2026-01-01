{
  lib,
  config,
  ...
}:
let
  cfg = config.services'.caddy;
in
{
  options.services'.caddy = {
    enable = lib.mkEnableOption "Enable Caddy web server";
  };

  config = lib.mkIf cfg.enable {
    services.caddy = {
      enable = true;
      enableReload = true;
      adapter = "caddyfile";
      user = "caddy";
      logDir = "/var/log/caddy";
      logFormat = lib.mkForce ''
        level INFO
        format console
      '';
      extraConfig = lib.mkBefore ''
        (cloudflare_headers) {
        header_up X-Real-IP {http.request.header.CF-Connecting-IP}
        header_up X-Forwarded-For {http.request.header.CF-Connecting-IP}
        }
      '';
    };

    networking.firewall = {
      allowedTCPPorts = [
        80
        443
      ];
      allowedUDPPorts = [ 443 ];
    };

    preservation'.os.directories = [
      {
        directory = config.services.caddy.dataDir;
        inherit (config.services.caddy) user group;
      }
    ];
  };
}
