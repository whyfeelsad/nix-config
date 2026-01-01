{
  lib,
  config,
  ...
}: let
  cfg = config.services'.forgejo;
in {
  options.services'.forgejo = {
    enable = lib.mkEnableOption "Enable Forgejo service";

    domain = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "The domain name for Forgejo";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.git = {
      description = "Forgejo Service";
      home = "/var/lib/forgejo";
      useDefaultShell = true;
      group = "forgejo";
      isSystemUser = true;
    };

    users.groups.forgejo = {};

    services.openssh.extraConfig = ''
      Match User git
        AuthorizedKeysFile %h/.ssh/authorized_keys /etc/ssh/authorized_keys.d/%u
    '';

    services.forgejo = {
      enable = true;
      lfs.enable = true;

      user = "git";
      group = "forgejo";

      database = {
        type = "postgres";
        user = "forgejo";
        name = "forgejo";
        createDatabase = false;
      };

      settings = {
        ui = {
          DEFAULT_SHOW_FULL_NAME = true;
          SHOW_USER_EMAIL = false;
        };
        "ui.meta" = {
          AUTHOR = "Coding is a passion.";
          DESCRIPTION = "Coding is a passion.";
          KEYWORDS = "go,git,self-hosted,forgejo";
        };
        log = {
          LEVEL = "Error";
        };
        server = {
          DOMAIN = cfg.domain;
          LANDING_PAGE = "explore";
          PROTOCOL = "http+unix";
          HTTP_ADDR = "/run/forgejo/forgejo.sock";
          ROOT_URL = "https://${cfg.domain}/";
          SSH_DOMAIN = cfg.domain;
          SSH_PORT = 22;
          START_SSH_SERVER = true;
        };
        repository = {
          DEFAULT_PRIVATE = "private";
          ENABLE_PUSH_CREATE_ORG = true;
          ENABLE_PUSH_CREATE_USER = true;
          USE_COMPAT_SSH_URI = true;
          DISABLE_STARS = true;
        };
        service = {
          ALLOW_ONLY_EXTERNAL_REGISTRATION = true; # 仅允许外部注册（如 OAuth）
          DEFAULT_ALLOW_CREATE_ORGANIZATION = true; # 默认允许创建组织
          DEFAULT_ENABLE_TIMETRACKING = true; # 默认启用时间跟踪
          DEFAULT_KEEP_EMAIL_PRIVATE = true; # 默认隐藏邮箱
          DISABLE_REGISTRATION = true; # 禁止注册
          ENABLE_CAPTCHA = false; # 启用验证码
          ENABLE_NOTIFY_MAIL = false; # 启用邮件通知
          REGISTER_EMAIL_CONFIRM = false; # 注册需要邮箱确认
          REQUIRE_SIGNIN_VIEW = false; # 需要登录才能查看
          SHOW_REGISTRATION_BUTTON = false; # 隐藏注册按钮
        };
        session = {
          PROVIDER = "db";
          COOKIE_SECURE = true;
        };
      };
    };

    # Setup binds to port 22
    # https://discourse.nixos.org/t/how-do-i-set-process-capabilities/4368/4
    systemd.services.forgejo = {
      serviceConfig = {
        AmbientCapabilities = lib.mkForce ["CAP_NET_BIND_SERVICE"];
        CapabilityBoundingSet = lib.mkForce "CAP_NET_BIND_SERVICE";
        PrivateUsers = lib.mkForce false;
      };
    };

    services.postgresql = {
      ensureDatabases = ["forgejo"];
      ensureUsers = [
        {
          name = "forgejo";
          ensureDBOwnership = true;
        }
      ];
    };

    services.caddy.virtualHosts = lib.mkIf (cfg.domain != null) {
      "${cfg.domain}" = {
        extraConfig = ''
          encode zstd gzip
          rewrite /user/login /user/oauth2/PocketID
          reverse_proxy unix//run/forgejo/forgejo.sock
        '';
      };
    };

    networking.firewall.allowedTCPPorts = [22];

    preservation'.os.directories = [
      "/var/lib/forgejo"
    ];
  };
}
