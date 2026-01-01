{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.services'.postgresql;
  user = config.core'.userName;
in {
  options.services'.postgresql = {
    enable = lib.mkEnableOption "Enable PostgreSQL service";
  };

  config = lib.mkIf cfg.enable {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_18;
      enableJIT = true;
      enableTCPIP = true;

      settings = {
        port = 5432;
        max_connections = 100;
        log_connections = true;
        log_statement = "all";
        logging_collector = true;
        log_disconnections = true;
        log_destination = lib.mkForce "syslog";
        shared_buffers = "128MB";
        huge_pages = "try";
      };

      identMap = ''
        superuser_map      root                postgres
        superuser_map      postgres            postgres
        superuser_map      postgres-exporter   postgres
        superuser_map      ${user}             postgres
        # Let other names login as themselves
        superuser_map      /^(.*)$             \1
      '';

      initdbArgs = [
        "--data-checksums"
        "--allow-group-access"
      ];

      # https://www.postgresql.org/docs/current/auth-pg-hba-conf.html
      authentication = lib.mkForce ''
        # TYPE  DATABASE        USER            ADDRESS                 METHOD   OPTIONS

        # "local" is for Unix domain socket connections only
        local   all             all                                     peer     map=superuser_map
        # IPv4 local connections:
        host    all             all             127.0.0.1/32            trust
        # IPv6 local connections:
        host    all             all             ::1/128                 trust

        # Allow replication connections from localhost, by a user with the
        # replication privilege.
        local   replication     all                                     trust
        host    replication     all             127.0.0.1/32            trust
        host    replication     all             ::1/128                 trust

        # Other Remote Access - allow access only the database with the same name as the user
        host    sameuser        all             0.0.0.0/0               scram-sha-256
      '';
    };

    networking.firewall.allowedTCPPorts = [5432];

    preservation'.os.directories = [
      "/var/lib/postgresql"
    ];
  };
}
