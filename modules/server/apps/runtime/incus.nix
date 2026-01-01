{
  lib,
  config,
  ...
}:
let
  cfg = config.services'.incus;
  user = config.core'.userName;
in
{
  options.services'.incus = {
    enable = lib.mkEnableOption "Enable Incus service";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.incus = {
      enable = true;
      # ui.enable = true;
      preseed = {
        networks = [
          {
            config = {
              "ipv4.address" = "10.0.100.1/24";
              "ipv4.nat" = "true";
            };
            name = "incusbr0";
            type = "bridge";
          }
        ];
        profiles = [
          {
            devices = {
              eth0 = {
                name = "eth0";
                network = "incusbr0";
                type = "nic";
              };
              root = {
                path = "/";
                pool = "default";
                size = "35GiB";
                type = "disk";
              };
            };
            name = "default";
          }
        ];
        storage_pools = [
          {
            config = {
              source = "/var/lib/incus/storage-pools/default";
            };
            driver = "dir";
            name = "default";
          }
        ];
      };
    };

    networking.firewall.interfaces.incusbr0 = {
      allowedTCPPorts = [
        53
        67
      ];
      allowedUDPPorts = [
        53
        67
      ];
    };

    users.users.${user}.extraGroups = [ "incus-admin" ];

    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };

    preservation'.os.directories = [
      "/var/lib/incus"
    ];
  };
}
