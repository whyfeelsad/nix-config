{
  lib,
  config,
  ...
}: let
  cfg = config.containers'.warp;
in {
  options.containers'.warp = {
    enable = lib.mkEnableOption "Cloudflare WARP";
  };

  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d /var/lib/warp 0755 root root -"
    ];

    virtualisation.oci-containers.containers = {
      warp = {
        hostname = "warp";
        serviceName = "warp";
        image = "docker.io/caomingjun/warp:latest";
        ports = ["127.0.0.1:1080:1080"];
        environment = {
          WARP_SLEEP = "2";
        };
        volumes = [
          "/var/lib/warp:/var/lib/cloudflare-warp"
        ];
        extraOptions = [
          "--memory=256m"
          "--device-cgroup-rule=c 10:200 rwm"
          "--cap-add=NET_ADMIN"
          "--cap-add=MKNOD"
          "--cap-add=AUDIT_WRITE"
          "--sysctl=net.ipv6.conf.all.disable_ipv6=0"
          "--sysctl=net.ipv4.conf.all.src_valid_mark=1"
        ];
        autoStart = true;
      };
    };

    preservation'.os.directories = [
      "/var/lib/warp"
    ];
  };
}
