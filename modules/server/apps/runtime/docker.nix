{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.services'.docker;
  user = config.core'.userName;
in
{
  options.services'.docker = {
    enable = lib.mkEnableOption "Enable Docker container engine";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      storageDriver = "btrfs";
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      extraOptions = "--iptables=false --ip6tables=false";
    };

    # Useful other development tools
    environment.systemPackages = with pkgs; [
      dive # look into docker image layers
      docker-compose # start group of containers for dev
      lazydocker # Docker terminal UI.
    ];

    users.users.${user}.extraGroups = [ "docker" ];

    preservation'.os.directories = [
      "/var/lib/docker"
    ];
  };
}
