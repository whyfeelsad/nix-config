{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.containers'.cloudflyer;
in {
  options.containers'.cloudflyer = {
    enable = lib.mkEnableOption "cloudflyer";

    domain = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Domain name to serve cloudflyer on via Caddy.";
    };
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.cloudflyer-key = {
      sopsFile = ../../secrets/containers.yaml;
    };

    systemd.services.cloudflyer = {
      after = ["network.target" "sops-nix.service"];
      wants = ["sops-nix.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        ExecStart = pkgs.writeShellScript "cloudflyer-start" ''
          key=$(cat ${config.sops.secrets.cloudflyer-key.path})
          ${pkgs.podman}/bin/podman run --name cloudflyer \
            --hostname cloudflyer \
            --memory=2g \
            --cpus=2 \
            -p 127.0.0.1:3000:3000 \
            docker.io/jackzzs/cloudflyer:latest \
            -K "$key" -H 0.0.0.0 -M 2
        '';
        ExecStop = "${pkgs.podman}/bin/podman stop cloudflyer";
        ExecStopPost = "${pkgs.podman}/bin/podman rm cloudflyer";
        Restart = "always";
        RestartSec = "3";
      };
    };

    services.caddy.virtualHosts = lib.mkIf (cfg.domain != null) {
      "${cfg.domain}" = {
        extraConfig = ''
          reverse_proxy localhost:3000 {
            import cloudflare_headers
          }
        '';
      };
    };
  };
}
