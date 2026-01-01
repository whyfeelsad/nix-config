{
  lib,
  config,
  ...
}: let
  cfg = config.containers'.v2node;
  port = 28256;
in {
  options.containers'.v2node = {
    enable = lib.mkEnableOption "";
  };

  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d /var/lib/v2node 0755 root root -"
    ];

    virtualisation.oci-containers.containers = {
      v2node = {
        hostname = "v2node";
        serviceName = "v2node";
        image = "ghcr.io/wyx2685/v2node:v0.2.4";
        ports = ["${toString port}:${toString port}"];
        volumes = [
          "/var/lib/v2node:/etc/v2node"
        ];
        extraOptions = [
          "--memory=256m"
        ];
      };
    };

    preservation'.os.directories = [
      "/var/lib/v2node"
    ];

    networking.firewall = {
      allowedTCPPorts = [port];
      allowedUDPPorts = [port];
    };
  };
}
