{
  lib,
  config,
  ...
}:
let
  cfg = config.services'.pocket-id;
  inherit (config.services.pocket-id) user;
in
{
  options.services'.pocket-id = {
    enable = lib.mkEnableOption "Enable pocket-id server";

    domain = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "The domain name for Pocket-ID";
    };
  };

  config = lib.mkIf cfg.enable {
    services.pocket-id = {
      enable = true;
      # environmentFile = config.sops.secrets.pocket-id.path;
      settings = {
        APP_URL = "https://${cfg.domain}";
        TRUST_PROXY = true;
        PUID = config.users.users.pocket-id.uid;
        PGID = config.users.groups.pocket-id.gid;
        DB_PROVIDER = "postgres";
        DB_CONNECTION_STRING = "host=/run/postgresql user=${user} database=${user}";
        HOST = "127.0.0.1";

        UI_CONFIG_DISABLED = false;
        APP_NAME = "Aaron's Auth Gateway";
      };
    };

    services.caddy.virtualHosts = lib.mkIf (cfg.domain != null) {
      "${cfg.domain}" = {
        extraConfig = ''
          reverse_proxy localhost:1411 {
            import cloudflare_headers
          }
        '';
      };
    };

    services.postgresql = {
      ensureDatabases = [ user ];
      ensureUsers = [
        {
          name = user;
          ensureDBOwnership = true;
        }
      ];
    };

    # sops.secrets.pocket-id = {
    #   owner = config.services.pocket-id.user;
    #   sopsFile = ./secrets.yaml;
    #   restartUnits = [config.systemd.services.pocket-id.name];
    # };

    preservation'.os.directories = [
      {
        directory = config.services.pocket-id.dataDir;
        inherit (config.services.pocket-id) user group;
      }
    ];
  };
}
